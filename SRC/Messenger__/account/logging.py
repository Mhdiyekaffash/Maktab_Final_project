import logging


class AdminFilter(logging.Filter):

    def filter(self, record):
        return "admin" not in record.msg.lower()