def gosper_step3(a,b,c,n):
	deg_a = a.degree()
	deg_b = b.degree()
	deg_c = c.degree()
	lc_a = a.coefficients()[-1]
	lc_b = b.coefficients()[-1]
	
	if (deg_a != deg_b) or lc_a != lc_b:
		d = (deg_c - max(deg_a,deg_b),0)
	else:
		A = a.coefficients()[-2]
		B = b.coefficients()[-2]
		d = (deg_c - deg_a + 1, (B - A)/lc_a)
	
	if d[0] < 0 or int(d[1]) != d[1]:
		return "No polynomial solution exists"
	else:
		d = max(d[0],d[1])
		
	var_list = []
	for i in range(d+1):
		s = var("a" + str(i))
		var_list.append(s)
	#print var_list

	x = 0
	for i in range(len(var_list)):
		x += n**i * var_list[i]
	#print x
	
	relations = []
	for elem in (a*x(n=n+1) - b(n=n-1)*x - c).full_simplify().coefficients(n):
		relations.append(elem[0] == 0)

	solved = solve(relations,var_list)
	x = 0
	for i in range(len(var_list)):
		x += list(solved[i].iterator())[1]*n**i
	return x