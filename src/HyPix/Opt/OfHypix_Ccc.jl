# =============================================================
#		MODULE: ofHypix
# =============================================================
module ofHypix

	# =============================================================
	#		MODULE: θ
	# =============================================================
	module θof
		import ...tool, ...interpolate, ...stats
		import Statistics
		export WOF_θ, RMSE_θ

		const OFmodel ="CCC"

		# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#		FUNCTION : WOF_θ
		# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		function WOF_θ(∑T, Nit::Int, Nz::Int, obsθ, paramHypix, Hpond, θ, θSim)

			θSim = interpolate.INTERPOLATE_2D_LOOP(∑T, obsθ.∑T[1:obsθ.Nit], Nit, Nz, θSim, θ)

			θobs_Layer = fill(0.0::Float64, obsθ.Nit)
			θSim_Layer = fill(0.0::Float64, obsθ.Nit)

			Wof = 0.0::Float64

			for iZ=1:obsθ.Ndepth

				Wdepth = 2.0 * (Float64(obsθ.Ndepth) + 1.0 - Float64(iZ) ) / (Float64(obsθ.Ndepth) * (Float64(obsθ.Ndepth) + 1.0))

				iTgood = 1
				for iT=1:obsθ.Nit
					if θSim[iT,iZ] > 0.0 && obsθ.θobs[iT,iZ] > 0.0 # avoiding no data
						θobs_Layer[iTgood] = obsθ.θobs[iT,iZ]
						θSim_Layer[iTgood] = θSim[iT,obsθ.ithetaObs[iZ]]
						iTgood += 1
					end # if: obsθ.θobs[iT,iZ] > 0.0
				end # for iT

				iTgood -= 1

				Wof += Wdepth * stats.RMSE_CONCORDANCE_CORELATION_COEFICIENT(θobs_Layer[1:iTgood], θSim_Layer[1:iTgood])
			end # for iZ

			# Penalty if we have too much ponding
			 Wof_Pond = max(Hpond[Nz] - paramHypix.opt.ΔHpondMax, 0.0::Float64) / 100.0

		return Wof + Wof_Pond
		end # function WOF_θ


		# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#		FUNCTION : RMSE_θ
		# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			function RMSE_θ(∑T, obsθ, Nit::Int, Nz::Int, θ, θSim)

				θSim = interpolate.INTERPOLATE_2D_LOOP(∑T, obsθ.∑T[1:obsθ.Nit], Nit, Nz, θSim, θ)
				
				Rmse = 0.0
				iCount = 0
				for iZ=1:obsθ.Ndepth

					Wdepth = 2.0 * (Float64(obsθ.Ndepth) + 1.0 - Float64(iZ) ) / (Float64(obsθ.Ndepth) * (Float64(obsθ.Ndepth) + 1.0))

					for iT=1:obsθ.Nit 	
						if θSim[iT,iZ] > 0.0 && obsθ.θobs[iT,iZ] > 0.0 # avoiding no data
							Rmse +=  Wdepth * (obsθ.θobs[iT,iZ] - θSim[iT, obsθ.ithetaObs[iZ]]) ^ 2.0
							iCount += 1
						end # if: obsθ.θobs[iT,iZ] > 0.0
					end # for it

				end # for iZ

			return Rmse = √(Rmse / (Float64(iCount)))		
			end # function WOF_θ

	end  # module θof

	# ............................................................

end  # module ofHypix
# ............................................................