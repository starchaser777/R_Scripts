install.packages("leaflet")
library(leaflet)

# leaflet 객체 보여지는 지도의 설정과 오픈스트리트맵재단에서 제공하는 지도타일 추가
m = leaflet() %>%
  setView(lng = 126.996542, lat = 37.5290615, zoom = 5) %>%
  addTiles()
m

# 지도 중심에 마커 출력하는 방법
m = leaflet() %>%
  addTiles() %>%
  addMarkers(lng = 126.996542, lat = 37.5290615, label = "한국폴리텍대학", popup = "서울정수캠퍼스 인공지능소프트웨어")
m

# 오늘 내가 수업 끝난 후 갈 장소를 지도에 출력하고 장소이름은 라벨로 표시하고 전화번호(또는 주소)는 팝업으로 표시
m = leaflet() %>%
  addTiles() %>%
  addMarkers(lng = 126.980774, lat = 37.560213, label = "UGG 신세계백화점 본점", popup = "서울특별시 중구 회현동1가 소공로 63") %>%
  addMarkers(lng = 126.9817325, lat = 37.5594007, label = "우리은행 본점", popup = "서울특별시 중구 회현동 소공로 51(Tel: 021-588-5000)")
m

quakes

# quakes 데이터셋에 있는 경도, 위도 값을 사용하여 지도타일을 출력
m = leaflet(data = quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~mag, stroke = TRUE, weight = 1, color = "pink", fillColor = "red", fillOpacity = 0.3)
m

# magnitude(지진규모)의 크기가 6이상이면 반지름을 10으로 설정하고 6미만이면 반지름을 1로 설정한다.
m = leaflet(data = quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~ifelse(mag >= 6, 10, 1), stroke = TRUE, weight = 1, color = "pink", fillColor = "red", fillOpacity = 0.3)
m

# mag(지진규모)가 5.5이상이면 반지름을 10, 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 테두리선의 굵기를 1, 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 불투명도를 0.3, 그렇지 않으면 0
m = leaflet(data = quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~ifelse(mag >= 5.5, 10, 0), stroke = TRUE, weight = ~ifelse(mag >= 5.5, 1, 0), color = "pink", fillColor = "red", fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0))
m

# mag(지진규모)가 6이상이면 반지름을 10, 그렇지 않고 5.5 이상이면 5, 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 테두리선의 굵기를 1, 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 불투명도를 0.3, 그렇지 않으면 0
# mag(지진규모)가 6이상이면 배경색을 red, 그렇지 않고 5.5 이상이면 green, 그렇지 않으면 색 없이(NA)
m = leaflet(data = quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~ifelse(mag >= 6, 10, ifelse(mag >= 5.5, 5, 0)), stroke = TRUE, weight = ~ifelse(mag >= 5.5, 1, 0), color = "brown", fillColor = ~ifelse(mag >= 6, 'red', ifelse(mag >= 5.5, 'green', NA)), fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0))
m

# 행정경계 데이터셋을 사용한 지도 시각화
library(ggplot2)
install.packages("sf")
library(sf)

# 행정경계 데이터셋(shape[.shape] 파일) 읽어오기
df_map = st_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/map_datasets/Z_NGII_N3A_G0010000.shp")

ggplot(data = df_map) +
  geom_sf(fill="white", color="black")

# 행정경계의 시도의 배경색을 다르게 지정
# id 설정
if(!"id"%in%names(df_map)) {
  df_map$id = 1:nrow(df_map)
}

ggplot(data = df_map) +
  geom_sf(aes(fill=id), alpha=0.3, color="black") +
  theme(legend.position = "none") +
  labs(x="경도", y="위도")

# 지진분포를 지도로 출력
# 데이터셋은 엑셀 파일로 읽어와서 사용
install.packages("openxlsx")
library(openxlsx)

df = read.xlsx("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/map_datasets/국내지진목록.xlsx")
head(df)

# X8열에서 북한으로 시작하는 데이터의 행번호 추출
idx = grep("^북한", df$X8)

# 북한지역의 X8열의 데이터를 확인
df[idx, 'X8']
# X8열에 북한으로 시작하는 행 삭제
df = df[-idx]
df

# df에 있는 6열과 7열의 데이터 중 N과 E를 삭제하는 방법
df[,6] = gsub("N", "", df[,6])
df[,7] = gsub("E", "", df[,7])

# 6, 7열의 값을 숫자형으로 변환
df[,6] = as.numeric(df[,6])
df[,7] = as.numeric(df[,7])

df[,6]