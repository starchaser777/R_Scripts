# [9장 응용문제] 일본 여행에 관한 네이버 블로그를 검색해서 어떤 단어들이 많이 나타나는지 파악해보자.
# 네이버 개발자 센터에서 블로그 검색에 대한 애플리케이션 등록

install.packages("RCurl")
install.packages("RmecabKo")
install.packages("wordcloud2")

library(RCurl)
library(XML)
library(wordcloud2)
library(RmecabKo)

# 형태소 분석을 위한 기능 설치
install_mecab("C:/RmecabKo/mecab")

library(RmecabKo)

# Naver Open API에서 블로그 검색을 위한 요청 주소를 작성
searchUrl = "https://openapi.naver.com/v1/search/blog.xml"
Client_ID = "FgU_jjk6WddZIFKSgmFh"
Client_Secret = "Ka7Os9tdKP"

# 검색하고자 하는 키워드를 한글인 경우 UTF-8로 인코딩 설정
query = URLencode(iconv("일본 여행", "UTF-8"))

# 변수에 저장된 searchUrl, Client_ID, Client_Secret, query를 하나의 url로 붙인다.
url = paste(searchUrl, "?query=", query, "&display=20", sep = "")
url

# url을 사용하여 검색한 결과 페이지를 요청하여 반환
doc = getURL(url, httpheader=c('Content-Type'="application/xml", 'X-Naver-Client-Id'=Client_ID, 'X-Naver-Client-Secret'=Client_Secret))
doc

# XML 구조로 변환
xmlFile = xmlParse(doc)
xmlFile

# XML 파일의 <item> 태그를 기준으로 데이터프레임으로 변환
df = xmlToDataFrame(getNodeSet(xmlFile, "//item"))
df
str(df)

# 전체 내용중에서 description 컬럼의 값만 추출
description = df[, 1]
description

# 불필요한 글자들 삭제(숫자, 태그, 큰따옴표)
description2 = gsub("\\d|<b>|</b>|&quot;", "", description)
description2

# 뉴스 내용중에 명사만 추출
nouns = nouns(iconv(description2, "utf-8"))
nouns

# 기사 한개당 나누어져 있는 벡터를 하나의 벡터로 통합
nouns.all = unlist(nouns, use.names = F)
nouns.all

# 글자수가 2글자 이상인 단어만 추출
nouns.all.2 = nouns.all[nchar(nouns.all)>=2]
nouns.all.2

# 단어들의 빈도수
nouns.freq = table(nouns.all.2)
nouns.freq

# 단어들의 빈도수를 데이터프레임으로 변환
nouns.df = data.frame(nouns.freq)
nouns.df

# 데이터프레임의 값 중에서 빈도수를 기준으로 내림차순 정렬
nouns.df.sortdesc = nouns.df[order(-nouns.df$Freq),]
nouns.df.sortdesc

# 워드 클라우드를 사용하여 빈도수에 따른 단어들을 시각화
wordcloud2(nouns.df.sortdesc, size = 1, rotateRatio = 0.5)

wordcloud2(nouns.df.sortdesc, size = 0.3, shape = 'star')
