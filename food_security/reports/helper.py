import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.stats as stats
import seaborn as sns
import statsmodels.api as sm

from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
from statsmodels.stats.outliers_influence import variance_inflation_factor

# EDA functions
def str_to_int(df, start_col, end_col):
    """Converts column to int in place.
    
    Args:
        df: the dataframe to convert
        start_col(int): the first column to convert
        end_col(int): the last column to convert
    """
    for i in range(start_col, end_col):
        if df.iloc[:, i].dtype == np.int64:
            pass
        else:
            df.iloc[:, i] = df.iloc[:, i].str.replace(',', '')
            df.iloc[:, i] = pd.to_numeric(df.iloc[:, i])
			
			
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

def feature_processing(df, feat_col, target):
    """Seperates dataframe into features and target as well as training and testing data
    
    Args:
        df(df): Contains both features and target
        feat_col(list): A list of feature names
        target(str): The name of the target column
    
    Returns:
        X_train(arr): A Numpy array of training features
        X_test(arr): A Numpy array of testing features
        y_train(arr): A Numpy array of training the target
        y_test(arr): A Numpy array of testing the target
    """
    # Separating features and target
    reg_feat = df.loc[:, feat_col]
    reg_target = df[target].values.reshape(-1, 1)
    
    # Feature scaling
    reg_feat, reg_target = scale_feat(reg_feat, reg_target)
    
    # lm data preprocessing
    X_train, X_test, y_train, y_test = train_test_split(reg_feat, reg_target, test_size=0.2, random_state=50)
    
    return X_train, X_test, y_train, y_test
	
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
    # lm data preprocessing
    X_train, X_test, y_train, y_test = feature_processing(df, feat_col, target)
    
    
    lm = LinearRegression().fit(X_train, y_train)
    
    lm_pred = lm.predict(X_test)
    r_sqr = lm.score(X_train, y_train)
    mse = mean_squared_error(y_test, lm_pred)
    
    print('Model Validation',
         '\nR^2 = ', r_sqr,
         '\nMean squared error = ', mse)
    
    return lm, r_sqr, mse
	
def lm_details(df, feat_col, target):
    """Cleans the features and runs a statsmodels OLS. For getting more information out of the regression than
    SKLearn provides.
    
    Args:
        df(df): Contains both features and target
        feat_col(list): A list of feature names
        target(str): The name of the target column
        
    Returns:
        sm_fitted_model: A fit instance
        X_train(Arr):A Numpy array of training features"""
    X_train, X_dummy, y_train, y_dummy = feature_processing(df, feat_col, target)
    
    df_sm_ready = sm.add_constant(X_train)
    sm_general_model = sm.OLS(y_train, df_sm_ready)
    sm_fitted_model = sm_general_model.fit()
    
    print(sm_fitted_model.summary())
    return sm_fitted_model, X_train
	
def vif_multicollinearity(df):
    """VIF on a set of features.
    
    Args:
        df(df): Only contains features
    
    Returns:
        output_df(df): VIF in a column. Row number is the feature number corresponding to sm.OLS.summary()
    """
    reg_feat = sm.add_constant(df)
    output_df = pd.DataFrame()
    
    #output_df['feature'] = reg_feat.columns
    output_df['vif'] = [variance_inflation_factor(reg_feat.values, col) for col in range(reg_feat.shape[1])]
    
    return output_df
