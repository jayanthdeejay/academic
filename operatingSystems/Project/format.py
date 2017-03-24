from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import LatexFormatter
lexer = get_lexer_by_name("perl", stripall=True)
formatter = LatexFormatter(cssclass="source")
