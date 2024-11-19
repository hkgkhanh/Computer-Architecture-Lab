.eqv MONITOR_SCREEN 0x10010000	#Dia chi bat dau cua bo nho man hinh
.eqv RED 0x00FF0000				#Cac gia tri mau thuong su dung
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.text
# Unit width and height is 8 pixels
# Display width is 512 pixels
# Display height is 256 pixels
	li $k0, MONITOR_SCREEN		#Nap dia chi bat dau cua man hinh
	
	li $t0, GREEN
	sw $t0, 260($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 516($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 772($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1028($k0)
	nop
 
	li $t0, GREEN
	sw $t0, 1284($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 520($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 780($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1040($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1300($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1044($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 788($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 532($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 276($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1308($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1320($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1060($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 804($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 548($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 296($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 300($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 560($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 816($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1072($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1332($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1324($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1068($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1340($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1348($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1092($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 836($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 580($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 324($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 840($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 588($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1100($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 336($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1360($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 344($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 600($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 856($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1112($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1368($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 860($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 864($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1124($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1380($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1388($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1132($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 880($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 620($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 624($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 884($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1140($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1396($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1392($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1404($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1148($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 892($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 896($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1156($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1412($k0)
	nop
	
	# h
	li $t0, GREEN
	sw $t0, 396($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 652($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 908($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1164($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1420($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 912($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 916($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1176($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 1432($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2308($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2312($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2316($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2568($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2824($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3080($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3336($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3332($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3340($k0)
	nop
	
	# T
	li $t0, GREEN
	sw $t0, 2324($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2328($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2332($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2584($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2840($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3096($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3352($k0)
	nop
	
	# -
	li $t0, GREEN
	sw $t0, 2852($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2856($k0)
	nop
	
	# E
	li $t0, GREEN
	sw $t0, 2352($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2608($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2864($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3120($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3376($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2356($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2360($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2868($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2872($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3380($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3384($k0)
	nop
	
	#P
	li $t0, GREEN
	sw $t0, 2368($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2372($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2376($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2632($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2624($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2880($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2884($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 2888($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3136($k0)
	nop
	
	li $t0, GREEN
	sw $t0, 3392($k0)
	nop
	
	# draw flag
	li $t0, RED
	sw $t0, 2392($k0)
	nop
	
	li $t0, RED
	sw $t0, 2396($k0)
	nop
	
	li $t0, RED
	sw $t0, 2400($k0)
	nop
	
	li $t0, RED
	sw $t0, 2404($k0)
	nop
	
	li $t0, RED
	sw $t0, 2408($k0)
	nop
	
	li $t0, BLUE
	sw $t0, 2424($k0)
	nop
	
	li $t0, BLUE
	sw $t0, 2428($k0)
	nop
	
	li $t0, WHITE
	sw $t0, 2432($k0)
	nop
	
	li $t0, WHITE
	sw $t0, 2436($k0)
	nop
	
	li $t0, RED
	sw $t0, 2440($k0)
	nop
	
	li $t0, RED
	sw $t0, 2444($k0)
	nop
	
	li $t0, RED
	sw $t0, 2648($k0)
	nop
	
	li $t0, RED
	sw $t0, 2652($k0)
	nop
	
	li $t0, YELLOW
	sw $t0, 2656($k0)
	nop
	
	li $t0, RED
	sw $t0, 2660($k0)
	nop
	
	li $t0, RED
	sw $t0, 2664($k0)
	nop
	
	li $t0, BLUE
	sw $t0, 2680($k0)
	nop
	
	li $t0, BLUE
	sw $t0, 2684($k0)
	nop
	
	li $t0, WHITE
	sw $t0, 2688($k0)
	nop
	
	li $t0, WHITE
	sw $t0, 2692($k0)
	nop
	
	li $t0, RED
	sw $t0, 2696($k0)
	nop
	
	li $t0, RED
	sw $t0, 2700($k0)
	nop
	
	li $t0, RED
	sw $t0, 2904($k0)
	nop
	
	li $t0, RED
	sw $t0, 2908($k0)
	nop
	
	li $t0, RED
	sw $t0, 2912($k0)
	nop
	
	li $t0, RED
	sw $t0, 2916($k0)
	nop
	
	li $t0, RED
	sw $t0, 2920($k0)
	nop
	
	li $t0, BLUE
	sw $t0, 2936($k0)
	nop
	
	li $t0, BLUE
	sw $t0, 2940($k0)
	nop
	
	li $t0, WHITE
	sw $t0, 2944($k0)
	nop
	
	li $t0, WHITE
	sw $t0, 2948($k0)
	nop
	
	li $t0, RED
	sw $t0, 2952($k0)
	nop
	
	li $t0, RED
	sw $t0, 2956($k0)
	nop