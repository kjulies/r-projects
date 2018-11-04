SSR_R <- 198.3
SSR_U <- 183.2
alpha <- 0.05
r = 2
n = 500
k = 4

#this test is one-sided hypotheses, so only one tail
f_critical_value = qf(alpha, r, n-(k+1), lower.tail = FALSE)
F_stat = ((SSR_R - SSR_U)/r)/(SSR_U/(n-(k+1)))

print(f_critical_value)
print(F_stat)

if (F_stat>f_critical_value){
  print("Reject de null")
}else{
  print("No reject de null")
}
