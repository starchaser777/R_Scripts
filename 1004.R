install.packages("dplyr")
install.packages("gapminder")

library(dplyr)
library(gapminder)
library(ggplot2)
library(gganimate)
library(gifski)

# 시계열데이터 그래프 애니메이션
# 전세계 국가(핀란드, 대한민국, 베트남)에 대한 연도별 기대수명과 국내총생산(GDP)과의 관계

# gapminder dataset 확인
gapminder

# 전세계 국가 중에서 3개국(핀란드, 대한민국, 베트남) 데이터만 필터링해서 추출
df = gapminder %>% filter(country == "Finland" | country == "Korea, Rep." | country == "Vietnam")

df

# 시계열데이터 그래프
# x축은 1인당 총생산, y축은 기대수명
anim = ggplot(df, aes(x=gdpPercap, y=lifeExp, size = pop, colour = country)) +
  geom_point(alpha=0.5) +
  scale_size(range = c(5, 15)) +
  labs(title = "연도: {frame_time}", x="1인당 GDP", y="기대수명") +
  transition_time(year) +
  shadow_wake(0.5)

animate(anim, width=500, height=400, duration = 10, renderer = gifski_renderer(loop = FALSE))

# 그림 애니메이션: 양궁
install.packages("magick")
library(magick)

# 스크립트와 동일 폴더에 있는 이미지를 읽어오기
bg = image_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/background.png") # 배경 이미지
target = image_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/target.png") # 과녁판 이미지
arrow = image_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/arrow.png") # 화살 이미지

print(bg)
print(target)
print(arrow)

# 이미지 크기 조정
bg = image_scale(bg, "600x300!")
target = image_scale(target, "80x170!")
arrow = image_scale(arrow, "100x25!")

# 이미지 회전
arrow = image_rotate(image_background(arrow, "none"), -11)
print(arrow)

# 이미지 합성: 배경 + 과녁판
bg2 = image_composite(bg, target, offset = geometry_point(450, 80))
print(bg2)

# 화살 위치 초기화
x = 0
y = 220

# 반복문을 사용하여 화살이 움직이는 애니메이션 설정
# 반목문이 수행될 때마다 x축의 값은 20 증가시키고 y축의 값은 -4

while (TRUE) {
  # 화살 이미지 위치(x, y)
  position = geometry_point(x, y)
  
  # 이미지 합성: bg2(배경+과녁판) + arrow(화살)
  img = image_composite(bg2, arrow, offset = position)
  
  print(img)
  
  Sys.sleep(0.1)
  
  # x축의 값이 400이 되면 반복문을 빠져나간다.
  if(x==400)
    break
  
  x = x+20
  y = y-4
}

# 그림 애니메이션을 이용하여 직선이 아닌 포물선으로 날아가도록 수정해보세요.
# 초기 각도와 화살이 움직이는 속력, 중력에 대한 곡선 형태는 검색하여 임의로 설정하여 자연스럽게 보이도록 하세요.

# 스크립트와 동일 폴더에 있는 이미지를 읽어오기
bg = image_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/background.png") # 배경 이미지
target = image_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/target.png") # 과녁판 이미지
arrow = image_read("C:/Users/AISW-509-183/Desktop/2024_2-2/강의/데이터분석실습/RScripts/arrow.png") # 화살 이미지

# 이미지 크기 조정
bg = image_scale(bg, "600x300!")
target = image_scale(target, "80x170!")
arrow = image_scale(arrow, "100x25!")

# 이미지 회전
arrow1 = image_rotate(image_background(arrow, "none"), -30)
arrow2 = image_rotate(image_background(arrow, "none"), 35)
print(arrow1)
print(arrow2)

print(arrow)

# 이미지 합성: 배경 + 과녁판
bg2 = image_composite(bg, target, offset = geometry_point(450, 80))
print(bg2)

# 화살 위치 초기화
x = 0
y = 210

# 반복문을 사용하여 화살이 움직이는 애니메이션 설정
# 반목문이 수행될 때마다 x축의 값은 20 증가시키고 y축의 값은 -4

while (TRUE) {
  # 화살 이미지 위치(x, y)
  position = geometry_point(x, y)
  
  # 이미지 합성: bg2(배경+과녁판) + arrow(화살)
  if(0<x | x<=200) {
    img = image_composite(bg2, arrow1, offset = position)
    x = x+10
    y = y-8
  }
  if(200<x & x<=260) {
    img = image_composite(bg2, arrow, offset = position)
    x = x+10
  }
  if(260<x & x<=420) {
    img = image_composite(bg2, arrow2, offset = position)
    x = x+10
    y = y+16
  }
  
  print(img)
  
  Sys.sleep(0.1)

  # x축의 값이 420이 되면 반복문을 빠져나간다.
  if(x==420)
    break
}