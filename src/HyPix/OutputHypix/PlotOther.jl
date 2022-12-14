# =============================================================
#		module: plotOther
# =============================================================
module plotOther
	

	# =============================================================
	#		module: plots
	# =============================================================
	module plots
		import ...tool
		using Plots, Plots.PlotMeasures, LaTeXStrings
		using Plots; pgfplotsx()
		# using PGFPlots

		# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#		FUNCTION : WOF_STEPS
		# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			function WOF_STEPS(path)

				Path_Output = pathHypix.Plot_OfStep * "Multiplestep.svg"

				rm(Path_Output, force=true, recursive=true)	

				Label = ["Waitoa";"Waihou";"Taupo";"Otorohanga";"Hamilton"]

				Plot1=Plots.plot(layout=(2,2), size=(1000,600), bottom_margin=20px, grid=:x)

				# TICKS 
					Ticks =[ "1","2a","2b","3a","3b","4a","4b","5a","5b"]

				# OF STEP
					Path = pathHypix.Input_OfStep * "Of_Step.CSV"

					Of_Waitoa, N_Waitoa = tool.readWrite.READ_HEADER(Path, "Waitoa")
					Of_Waihou, N_Waihou = tool.readWrite.READ_HEADER(Path, "Waihou")
					Of_Taupo, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Taupo")
					Of_Otorohanga, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Otorohanga")
					Of_Hamilton, N_Hamilton = tool.readWrite.READ_HEADER(Path, "Hamilton")
					
					Id=1:N_Waitoa

					Of = [Of_Waitoa Of_Waihou Of_Taupo Of_Otorohanga Of_Hamilton]

					for i=1:5
						Plots.plot!(Plot1, subplot=1, Id, Of[1:N_Waitoa, i], palette=:darkrainbow,  marker=(:circle, 4, 1.0), line=(2.0,:solid))
					end
					Plots.plot!(Plot1, subplot=1,  xlabel="", ylabel=L"WOF _{\theta} \ [mm^{3} \ mm^{-3}]", xticks=(1:1:9, Ticks), xtickfont=(12, :white), legend=false, title="(a) Weighted Objective Function", titlelocation = :left)

				# GROUNDWATER STEP
					Path = pathHypix.Input_OfStep * "Groundwater_Step.csv"

					Groundwater_Waitoa, N_Waitoa = tool.readWrite.READ_HEADER(Path, "Waitoa")
					Groundwater_Waihou, N_Waihou = tool.readWrite.READ_HEADER(Path, "Waihou")
					Groundwater_Taupo, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Taupo")
					Groundwater_Otorohanga, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Otorohanga")
					Groundwater_Hamilton, N_Hamilton = tool.readWrite.READ_HEADER(Path, "Hamilton")

					Groundwater = [Groundwater_Waitoa Groundwater_Waihou Groundwater_Taupo Groundwater_Otorohanga Groundwater_Hamilton]

					for i=1:5
						Plots.plot!(Plot1, subplot=2, Id, Groundwater[1:N_Waitoa, i], palette=:darkrainbow,  marker=(:circle, 4, 1.0), line=(2.0,:solid))
					end
					# Plots.plot!(Plot1, subplot=2, xlabel=L"Multistep \ Optimisation \ Steps", ylabel=L"\zeta _{Q} ", xticks=(1:1:8, Ticks), legend=false, title="Groundwater", titlelocation = :left)

					Plots.plot!(Plot1, subplot=2,  xlabel="", ylabel=L"\zeta _{Q} \ [\%]", xticks=(1:1:9, Ticks), xtickfont=(12, :white), legend=false, title="(b) Drainage", titlelocation = :left)


				# EvapoTranspiration STEP
					Path = pathHypix.Input_OfStep * "Sink_Step.csv"

					Sink_Waitoa, N_Waitoa = tool.readWrite.READ_HEADER(Path, "Waitoa")
					Sink_Waihou, N_Waihou = tool.readWrite.READ_HEADER(Path, "Waihou")
					Sink_Taupo, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Taupo")
					Sink_Otorohanga, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Otorohanga")
					Sink_Hamilton, N_Hamilton = tool.readWrite.READ_HEADER(Path, "Hamilton")

					Sink = [Sink_Waitoa Sink_Waihou Sink_Taupo Sink_Otorohanga Sink_Hamilton]

					for i=1:5
						Plots.plot!(Plot1, subplot=3, Id, Sink[1:N_Waitoa, i],  palette=:darkrainbow,  marker=(:circle, 4, 1.0), line=(2.0,:solid))
					end
					# Plots.plot!(Plot1, subplot=3, xlabel=L"Multistep \ Optimisation \ Steps?", ylabel=L"\zeta _{et} ", xticks=(1:1:8, Ticks), legend=false, title="EvaopoTranspiration", titlelocation = :left)

					Plots.plot!(Plot1, subplot=3, xlabel=L"Multistep \ optimization \ [Layers]", ylabel=L"\zeta _{et}  \ [\%]", xticks=(1:1:9, Ticks), tickfont=(12, :black), legend=false, title="(c) Evapotranspiration", titlelocation = :left)

				# Soil Water Content STEP
					Path = pathHypix.Input_OfStep * "Swc_Step.csv"

					Swc_Waitoa, N_Waitoa = tool.readWrite.READ_HEADER(Path, "Waitoa")
					Swc_Waihou, N_Waihou = tool.readWrite.READ_HEADER(Path, "Waihou")
					Swc_Taupo, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Taupo")
					Swc_Otorohanga, N_Otorohanga = tool.readWrite.READ_HEADER(Path, "Otorohanga")
					Swc_Hamilton, N_Hamilton = tool.readWrite.READ_HEADER(Path, "Hamilton")

					Swc = [Swc_Waitoa Swc_Waihou Swc_Taupo Swc_Otorohanga Swc_Hamilton]

					for i=1:5
						Plots.plot!(Plot1, subplot=4, Id, Swc[1:N_Waitoa, i], palette=:darkrainbow, marker=(:circle, 4, 1.0), label=Label[i], line=(2.0,:solid))
					end
					# Plots.plot!(Plot1, subplot=4, xlabel=L"Multistep \ Optimisation \ Steps", ylabel=L"\zeta _{\theta} ", xticks=(1:1:8, Ticks), legend=(-0.15,-0.18), title="Soil Water Content", titlelocation = :left)

					Plots.plot!(Plot1, subplot=4, xlabel=L"Multistep \ optimization \ [Layers]", ylabel=L"\zeta_{swc}  \ [\%]", xticks=(1:1:9, Ticks), tickfont=(12, :black), legend=(0.75,1.0), title="(d) Root zone soil water content", titlelocation = :left)

					Plots.savefig(Plot1, Path_Output)
					println("			 ~ ", Path_Output, "~")
			end  # function: WGroundwater_STEPS


	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#		FUNCTION : ROOTDENSITY
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		# function VEG_FUNCTIONS(discret, iMultistep, N_iRoot, veg, Z, ??RootDensity, pathHyPix)

		# 	Plot_All = PGFPlots.GroupPlot(2, 1, groupStyle = "horizontal sep = 3cm, vertical sep = 3cm")

		# 	# PLOT VEG_FUNCTIONS
		# 		??RootDensity_Norm = fill(0.0::Float64, N_iRoot)
		# 		# Taking accoung the tickness of the discretisation
		# 		# for iZ=1:N_iRoot
		# 		# 		??RootDensity_Norm[iZ] = Z[N_iRoot] * ??RootDensity[iZ] / discret.??Z[iZ]
		# 		# end

		# 		# Plotting
		# 			Plot_RootDensity = PGFPlots.Plots.Linear(??RootDensity[1:N_iRoot], discret.Znode[1:N_iRoot], style=" smooth, green, very thick", mark="none")

		# 			Plot = [Plot_RootDensity]

		# 			push!(Plot_All, PGFPlots.Axis(Plot, style="width=12cm, height=8cm", xlabel=L"$ \Delta Rdf \ [\%] $", ylabel=L"$Z \ [mm]$", title="(a)"))
			
		# 	# PLOT StressReduction
		# 		# Data	
		# 		N_Se = 6
		# 		??stress = fill(0.0::Float64, 2, N_Se) 
		# 		??stress[1,1] = -veg.??feddes1 / 10.0
		# 		??stress[1,2] = -veg.??feddes1
		# 		??stress[1,3] = -veg.??feddes2
		# 		??stress[1,4] = -veg.??feddes3
		# 		??stress[1,5] = -veg.??feddes4
		# 		??stress[1,6] = -veg.??feddes4 * 2.0

		# 		Wsf = fill(0.0::Float64, N_Se)
		# 		for i?? ??? 1:N_Se
		# 			Wsf[i??] = rootWaterUptake.stressReduction.WATER_STRESS_FUNCTION(2, i??, veg, ??stress)
		# 		end

		# 		Plot_Wsf = PGFPlots.Plots.Linear(-??stress[1,1:N_Se] .* cst.Mm_2_kPa, Wsf[1:N_Se], style="violet, very thick", mark="none")

		# 		Plot = [Plot_Wsf]

		# 		push!(Plot_All, PGFPlots.Axis(Plot, style="width=12cm, height=8cm", xlabel=L"$ \Psi \ [kPa]$", xmode="log", ylabel=L"$ F_{waterStress} \ [-]$", title="(b)"))

		# 	Path = pathHyPix.Vegetation * "_" * string(iMultistep) * ".svg"
		# 	PGFPlots.save(Path, Plot_All)	
		# end  # function ROOTDENSITY
		
	end  # module: plots
	# ............................................................



	

	# =============================================================
	#		module: makkie
	# =============================================================
	module makkie

	import ...hydroStruct, ...hydroRelation, ...wrc, ...timeStep
	using CairoMakie
	export PLOT_????_??, DRY_METHOD

	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#		FUNCTION : PLOT_????
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		function PLOT_????_????(hydro, pathHyPix, paramHypix, optionHypix, paramHypix)
			N_Se = 100

			option??? = optionHypix

			hydroHorizon??? = hydroStruct.HYDROSTRUCT(option???, 1)
			
			hydroHorizon???.??s[1] = 0.5
			hydroHorizon???.??sMacMat[1] = 0.5
			hydroHorizon???.??r[1] = 0.00
			hydroHorizon???.??[1] = 2.0
			???? = (paramHypix.hydro.??macMat + ???(paramHypix.hydro.??macMat)) / 2.0
			hydroHorizon???.??m[1] = hydroRelation.??_2_??m(hydroHorizon???.??[1], ????,  hydro.??m_Min[1],  hydro.??m_Max[1])
			hydroHorizon???.??mMac[1] = 100.0
			hydroHorizon???.??Mac[1] = 2.0

			# Feasible range 
				??_Max= exp(16.0)
				??_Min= 0.0
			# Plotting the curve
				??plot = exp.(range(log(??_Min), stop=log(??_Max), length=N_Se)) 
				??plot = fill(0.0::Float64, N_Se)
				for i?? = 1:N_Se
					??plot[i??] = wrc.??_2_??Dual(option???, ??plot[i??], 1, hydroHorizon???)			
				end # for i??

			# INITIALIZING PLOT
				CairoMakie.activate!()
				Makie.inline!(true)

				# AX1
	
				Fig = Figure(resolution = (2000, 800))
				
				Title = L"Time-stepping: $\Delta \theta$"
					Ax1 = Axis(Fig[1,1], title=Title, xlabel= L"ln $\psi$ $[mm]$", ylabel=  L"$\theta$ $[m^{3}  m^{-3}]$",  font="Computer Modern", titlesize=30, fontsize=30, xlabelsize=30, ylabelsize=30 , xgridvisible=false, ygridvisible=false, ytickalign=0.1)

					noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")
					Label(Fig[1, 1, TopLeft()], "    (A)", textsize = 24, font = noto_sans_bold, padding = (0, 5, 5, 0), halign = :right)

					# xlims!(Ax1, log(??_Min), log(??_Max))
					xlims!(Ax1, -log(??_Max), -log(??_Min))
					ylims!(Ax1, 0.0, hydroHorizon???.??s[1]+0.1)
					Ax1.yticks=0:0.1:hydroHorizon???.??s[1]

					lines!(Ax1, -log.(??plot), ??plot, linewidth=2, color=:red)
					# Plotting points on the curve
						N_???? = 6
						# ??_???? = fill(0.0::Float64, N_????)
						# ???? = range(hydroHorizon???.??r[1], hydroHorizon???.??s[1] , length=N_????)

						??half = (hydroHorizon???.??s[1] - hydroHorizon???.??r[1]) / 2.0
						????= 1.0E-2

7
						???? = [??half-????, ??half+????, hydroHorizon???.??s[1], hydroHorizon???.??s[1]-????, hydroHorizon???.??r[1], hydroHorizon???.??r[1]+????]

						for i?? = 1:N_????
							??_???? = wrc.??_2_??Dual(option???, ????[i??], 1, hydroHorizon???)

							scatter!(Ax1, [-log(??_????),-log(??_????)], [????[i??],????[i??]], markersize=10, color=:blue)
							# scatter!(Ax1, [log(hydroHorizon???.??m[1])], [0.5 * (hydroHorizon???.??sMacMat[1]+hydroHorizon???.??r[1])], markersize=20,  color=:red)
							lines!(Ax1, [-log(??_????), -log(??_????)], [0.0, ????[i??]], linestyle=:dash, linewidth=2, color=:grey)
							lines!(Ax1, [-log(??_????), -log(??_Min)], [????[i??], ????[i??]], linestyle=:dash, linewidth=2, color=:grey)
						end

				# AX2 ============================================
				Title = L"Time-stepping: $\Delta \Psi$"

				Ax2 = Axis(Fig[1,2], title=Title, xlabel= L"ln $\psi$ $[mm]$",  font="Computer Modern", titlesize=25, fontsize=16, xlabelsize=22, ylabelsize=22 , xgridvisible=false, ygridvisible=false,  ytickalign=0.1)

				noto_sans_bold = assetpath("fonts", "NotoSans-Bold.ttf")
				Label(Fig[1, 2, TopLeft()], "(B)", textsize = 24, font = noto_sans_bold, padding = (5, 5, 5, 5), halign = :right)

				xlims!(Ax2, -log(??_Max), -log(??_Min))
				ylims!(Ax2, 0.0, hydroHorizon???.??s[1])
				Ax2.yticks=0:0.1:hydroHorizon???.??s[1]

				hideydecorations!(Ax2, ticks=false, grid=false)

				lines!(Ax2, -log.(??plot), ??plot, linewidth=2, color=:red)

				# ??Ln??max = fill(0.0: 1)
				# ??Ln??max = timeStep.????MAX!(hydroHorizon???, 1, optionHypix, paramHypix, ??Ln??max)

				# timeStep.????MAX(hydro, 1, 1, optionHypix, ??Ln??max, ??)
				# Plotting points on the curve
					N_?? = 5
					???? = fill(0.0::Float64, N_??)

					??Log?? = range(2.0, 16.0 , length=N_??)


					for i?? = 1:N_??
						??_???? = exp(??Log??[i??])

						????[i??] = wrc.??_2_??Dual(option???, ??_????, 1, hydroHorizon???)

						scatter!(Ax2, [-log(??_????),-log(??_????)], [????[i??],????[i??]], markersize=10,  color=:blue)
						# scatter!(Ax2, [log(hydroHorizon???.??m[1])], [0.5 * (hydroHorizon???.??sMacMat[1]+hydroHorizon???.??r[1])], marker = "x", markersize=15,  color=:red)
						lines!(Ax2, [-log(??_????), -log(??_????)], [0.0, ????[i??]], linestyle=:dash, linewidth=2, color=:grey)
						lines!(Ax2, [-log(??_????), -log(??_Min)], [????[i??], ????[i??]], linestyle=:dash, linewidth=2, color=:grey)
					end

				trim!(Fig.layout)
				colgap!(Fig.layout, 1)
				rowgap!(Fig.layout, 1)

				save( pathHyPix.Plot_????_????, Fig)
				println("			 ~ ", pathHyPix.Plot_????_????, "~")
				display(Fig)

		return nothing
		end  # function: PLOT_????


	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#		FUNCTION : name
	# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		function DRY_METHOD()

		??obs=	[0.767528364,
					0.84759782,
					1.154454689,
					1.56910817,
					1.959401769,
					1.850609728,
					1.554592632,
					2.084719856,
					2.436491598,
					2.416681323,
					3.24090118,
					3.253171388]

		??wet_Obs =	[26,
					23,
					23,
					21,
					17,
					18,
					9,
					8,
					5,
					2,
					0.01,
					0.01]	

		??dry_Obs = [2090,
					3550,
					8010,
					18650,
					35270,
					29420,
					15770,
					28230,
					34260,
					24410,
					19490,
					20750]

			N = 100
			??mat = range(0.8, 4, length=N)

			??wet = fill(0.0, N)
			??dry =  fill(0.0, N)

			for  (i , ??) in enumerate(??mat)
				??wet[i] =  max(-2.3116 * ?? ^ 2.0 - 2.9372 * ?? + 27.83, 0.0)

				??dry[i] = exp(1.6216 * log(??) + 8.7268)
			end

			# INITIALIZING PLOT
				CairoMakie.activate!()
				Makie.inline!(true)


				Fig = Figure(resolution = (1000, 600))

				Ax1 = Axis(Fig[1,1], xlabel= L"$\sigma$ $[-]$", ylabel=  L"$\Psi$ $[mm]$",  font="Computer Modern", titlesize=35, fontsize=35, xlabelsize=35, ylabelsize=35 , xgridvisible=false, ygridvisible=false, yscale = log10, yminorticksvisible = true, yminorgridvisible = true,
				yminorticks = IntervalsBetween(10))

				Ax1.yticks=[0, -1, -100,-1000,-10000,-100000]
				Ax1.yscale = Makie.pseudolog10

				lines!(Ax1, ??mat, -??wet, linewidth=3, color=:blue, label = L"\Psi _{wet} Model")
				lines!(Ax1, ??mat, -??dry, linewidth=3, color=:red, label = L"\Psi _{dry} Model")
				scatter!(Ax1, ??obs, -??wet_Obs, markersize=10, color=:blue, label = L"\Psi _{wet} Zhu")
				scatter!(Ax1, ??obs, -??dry_Obs, markersize=10, color=:red, label = L"\Psi _{dry} Zhu")

				Leg = Legend(Fig[2,1], Ax1, framevisible=true, orientation=:horizontal, tellheight=true, nbanks=1, framecolor = (:grey,0.5), labelsize=20)

				trim!(Fig.layout)

				display(Fig)
				save( "D:/Main/MODELS/SoilWater_ToolBox/data/OUTPUT/Hypix/RESULTS/Fig3 Zhu_DryMethod.svg", Fig)
		return nothing
		end  # function: name
		# ------------------------------------------------------------------
		
	end  # module: makkie
	# ............................................................

	
	
end  # module: plotOther
# ............................................................