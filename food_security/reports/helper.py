# EDA functions 

# Stats functions
def test_normality(df, feat_col):
    
    alpha = 0.05
    
    sns.kdeplot(df[feat_col], label=feat_col)
    plt.show()
    
    # Shapiro-Wilk test
    stat_sw, p_sw = stats.shapiro(df[feat_col])
    
    print('Sharpio-Wilk Test:\nStatistic=%.4f, p=%.4f' % (stat_sw, p_sw))
    
    if p_sw > alpha:
        print('Fail to reject H0, normally distributed')
    else:
        print('Reject H0, not normally distributed')
        
    # D'Agostino K^2
    stat_da, p_da = stats.normaltest(df[feat_col])
    
    print('\nD\'Agostino Test:\nStatistic=%.4f, p=%.4f' % (stat_sw, p_sw))
    
    if p_da > alpha:
        print('Fail to reject H0, normally distributed')
    else:
        print('Reject H0, not normally distributed')

# lm functions
def scale_feat(X, y):
    """Performs min-max feature scaling on features and response
    
    Args:
        X(df/arr): A dataframe or array of features
        y(arr): A array of response values 
    Returns:
        X(arr): A transformed array whose values are (0,1)
        y(arr): A transformed array whose values are (0,1)
    """
    scaler = MinMaxScaler()

    scaler.fit(X)
    scaler.fit(y)

    X = scaler.transform(X)
    y = scaler.transform(y)
    
    return X, y

def create_lm(df, feat_col, target):
    """Creates a linear model from a dataframe and performs model validation. 
    Steps:
        1. Seperate features and target
        2. Performs min-max scaler on features and target
        3. Creates a linear model
        4. Validates linear model
        
    Args:
        df(df): Contains both features and target
        feat_col(list): A list of feature names
        target(str): The name of the target column
    
    Returns:
        lm: A instance of a LinearRegression()
        r_sqr(float): A goodness of fit for the model
        mse(float): The MSE of predicted and actual target values
    """
    # Sepearting features and target
    reg_feat = df.loc[:, feat_col]
    reg_target = df[target].values.reshape(-1, 1)
    
    # Feature scaling
    reg_feat, reg_target = scale_feat(reg_feat, reg_target)
    
    # lm data preprocessing
    X_train, X_test, y_train, y_test = train_test_split(reg_feat, reg_target, test_size=0.2, random_state=50)
    
    
    lm = LinearRegression().fit(X_train, y_train)
    
    lm_pred = lm.predict(X_test)
    r_sqr = lm.score(X_test, y_test)
    mse = mean_squared_error(y_test, lm_pred)
    
    print('Model Validation',
         '\nR^2 = ', r_sqr,
         '\nMean squared error = ', mse)
    
    return lm, r_sqr, mse
