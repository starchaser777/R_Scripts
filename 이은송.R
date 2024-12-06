# ★ 기말2_시뮬레이션
# 주제: 주사위 게임 시뮬레이션
# 설명: 두 개의 주사위를 던졌을 때, 반복 횟수에 따라 합이 7이 나오는 확률값이 이론값(약 16.67%)에 수렴하는 과정을 관찰
# 제가 7을 좋아해서 7로 선정했습니다.

# 변수 초기화
# 반복횟수 변수
iteration = 100
# 합이 7인 경우의 개수를 저장하는 변수
N.sum7 = 0
# 100개의 확률 값을 저장
prob = NULL
# 주사위 두 개의 값들을 저장
rolls = NULL

for (i in 1:iteration) {
  # 주사위 두 개의 값
  dice1 = sample(1:6, 1, replace = TRUE)
  dice2 = sample(1:6, 1, replace = TRUE)
  
  rolls = rbind(rolls, c(dice1, dice2))
  
  # 두 주사위 합 계산
  sum_dice = dice1 + dice2
  
  # 합이 7이면 카운트 증가
  if(sum_dice == 7) {
    N.sum7 = N.sum7 + 1
  }
  
  # 시행횟수까지의 확률 계산
  prob.sim = N.sum7 / i
  prob = c(prob, prob.sim)
}

# 계산된 확률 값이 저장된 데이터 프레임의 변환
df.prob = data.frame(반복수=1:iteration, 확률=prob)
theoretical_prob = 6 / 36  # 이론적인 확률 (합이 7일 확률)

# 확률 시뮬레이션 결과 시각화
library(ggplot2)

ggplot(data = df.prob, aes(x=반복수, y=확률, group = 1)) +
  geom_line(color="blue", size=1) +
  geom_point() +
  geom_hline(yintercept = theoretical_prob, color="red") +
  labs(title = "시행 횟수에 따른 확률의 변화")

# 시행횟수에 따른 주사위 결과 분포도
rolls.df = as.data.frame(rolls)
colnames(rolls.df) = c("주사위1", "주사위2")

# 실험결과 그래프
library(ggforce)

ggplot(data = rolls.df, aes(x=주사위1, y=주사위2)) +
  geom_point() +
  coord_cartesian(xlim = c(1,6), ylim = c(1,6)) +
  labs(title = "시행 횟수에 따른 주사위 결과 분포")