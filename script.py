import os
from pathlib import Path

article_root_path = Path("./docs/記事")
year_path = os.listdir(article_root_path)
month_path = os.listdir(year_path);

print(year_path)
