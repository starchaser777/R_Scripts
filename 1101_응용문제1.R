# [7장 응용문제1] 지역별 미세먼지 추출
# 한국환경공단(https://www.airkorea.or.kr)에서 운영하는 에어코리아(https://www.airkorea.or.kr) 홈페이지에서
# 특정일의 시도별 대기정보인 미세먼지(PM10) 또는 초미세먼지(PM2.5)의 농도를 웹스크래핑으로 추출해보자.

url = "https://www.airkorea.or.kr/web/sidoQualityCompare?itemCode=10008&pMENU_NO=102"
html = read_html(url)
html

titles = html_nodes(html, "#sidoTable_thead tr th a") %>%
  html_text()
titles