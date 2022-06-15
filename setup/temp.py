from tempfile import gettempdir, TemporaryFile

temp_dir = gettempdir()


def create_temp_file(del_on_close=False):
    return TemporaryFile(delete=del_on_close)
