import logging
import os


def main():
    search_for_data_dir()


def search_for_data_dir(data_input='../data/input',
                        data_output='../data/output'):
    if not os.path.isdir(data_input):
        os.mkdir(data_input)
        logging.info('Made dir: {}'.format(data_input))
    print('completed!')


if __name__ == '__main__':
    main()
