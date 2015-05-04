SLOWLOGS = \
bootstrapping.log \
msl31.log \
msl32simulation.log \
msl32simulation_cpp_mini.log \
simulationmodelicamsl22.log \
msl22electrical.log \
msl22mechanics.log \
msl22flattening.log \
msl22additions.log \
msl31simulation.log \
msl31mediasimulation.log \
siemens_nosim.log \
siemens_simulation.log \
SiemensPower.log \
hummod.log \
ThermoSysPro_simulation.log \
flatteningExercises.log \
flatteningPlanarMechanics.log \
TestMedia.log \
cppruntime.log \
cppruntimeHpcom.log \
taskGraph.log \
debugDumps.log \
dumpCruntime.log \
optimization.log \
xmlFiles.log \
resolveLoops.log \
evalConstFuncs.log \
flatteningBuildings.log \
buildings.log \
modelica3d.log

SIMULATIONLOGS = \
linearization.log \
modelicaML.log \
msl22electrical.log \
msl22mechanics.log \
simulationalgorithms-functions.log \
simulationarrays.log \
simulationasserts.log \
simulationbuilt-in-functions.log \
simulationconnectors.log \
simulationdeclarations.log \
simulationenums.log \
simulationequations.log \
simulationevents.log \
simulationsynchronous.log \
simulationexternal-functions.log \
simulationindexreduction.log \
simulationinheritances.log \
simulationjapaneselanguage.log \
simualtionlinear_system.log \
simulationnonlinear_system.log \
simulationothers.log \
simulationpackages.log \
simulationrecords.log \
simulationsolver.log \
simulationtypes.log \
simulationmodelicamsl22.log \
msl31mediasimulation.log \
msl31simulation.log \
flatteningExercises.log \
simulationExercises.log \
simulation-start-value-selection.log \
simulationinitialization.log \
simulationqss.log \
simulationunitcheck.log \
simulationtearing.log \
simulationDrModelica.log \
simulationPlanarMechanics.log \
simulationExercises.log \
simulation-start-value-selection.log \
TestMediaFrancesco.log \
ThermoPower.log \
MathematicalAspects_simulation.log \
PNlib_simulation.log \
parallel.log \
simoptions.log \
annex60.log \
gitlibraries.log

# Sorted by time it takes to run the tests...
# DO NOT ADD ANYTHING HERE THAT YOU EXPECT WILL TAKE MORE THAN 5 SECONDS TO RUN IN THE NEXT 18 YEARS
FASTLOGS= \
simulationalgorithms-functions.log \
simulationarrays.log \
simulationasserts.log \
simulationbuilt-in-functions.log \
simulationconnectors.log \
simulationdeclarations.log \
simulationenums.log \
simulationequations.log \
simulationevents.log \
simulationsynchronous.log \
simulationexternal-functions.log \
simulationindexreduction.log \
simulationinheritances.log \
simulationjapaneselanguage.log \
simualtionlinear_system.log \
simulationnonlinear_system.log \
simulationothers.log \
simulationpackages.log \
simulationrecords.log \
simulationsolver.log \
simulationtypes.log \
modelicaasserts.log \
modelicaalgorithms-functions.log \
modelicaarrays.log \
modelicaothers.log \
modelicaexternal-functions.log \
modelicaequations.log \
modelicabuilt-in-functions.log \
modelicaextends.log \
modelicaoperators.log \
modelicapackages.log \
modelicadeclarations.log \
modelicaenums.log \
modelicasynchronous.log \
modelicastatemachines.log \
modelicascoping.log \
modelicatypes.log \
modelicamodification.log \
modelicaconnectors.log \
modelicablocks.log \
parser.log \
meta.log \
biochem.log \
flatteningmodelicamsl.log \
mmdev.log \
flatteningmosfiles.log \
interactive-API.log \
typed-API.log \
records.log \
expandable.log \
linearization.log \
modelicaML.log \
streams.log \
redeclare.log \
fmi_me_10.log \
fmi_me_20.log \
fmi_cs_st.log \
uncertainties.log \
scodeinst.log \
xml.log \
xogeny.log

.PHONY : all omc-diff failingtest test fast fast.logs $(FASTLOGS) $(SLOWLOGS) $(SIMULATIONLOGS) slow.logs threaded

all : test

# This will run the test with 5 threads (cores + 1)
# If you have more cores increase it.
# or just run "make -jN" on the command line if you have N-1 cores
threaded :
	@echo running the testsuite with multiple MAKE threads.
	@echo This is not an official OM test. Run the normal test before commites.
	@echo If some tests fail with this just run them individualy. Most probably
	@echo they will work.
	@echo This threaded version still have some issues. However if it succedes
	@echo then there is no need to run the serial one. Except when you are COMMITING changes.
	$(MAKE) -j5 clean
	$(MAKE) -j5 test

omc-diff :
	$(MAKE) -C difftool
test : slow.logs fast.logs
	@cat `ls $(FASTLOGS) $(SLOWLOGS) | sort`
	@rm -f {flattening/modelica/asserts,flattening/modelica/algorithms-functions,flattening/modelica/arrays,flattening/modelica/others,flattening/modelica/external-functions,flattening/modelica/equations,flattening/modelica/built-in-functions,flattening/modelica/extends,flattening/modelica/operators,flattening/modelica/packages,flattening/modelica/declarations,flattening/modelica/enums,flattening/modelica/synchronous,flattening/modelica/statemachines,flattening/modelica/scoping,flattening/modelica/types,flattening/modelica/modification,flattening/modelica/connectors,flattening/modelica/blocks,flattening/modelica/streams,flattening/libraries/msl22,flattening/modelica/msl,metamodelica/meta,flattening/modelica/records,openmodelica/java,openmodelica/interactive-API,flattening/modelica/mosfiles}/*.{dll,so,exe};
test-oldresult:
	@cat `ls $(FASTLOGS) $(SLOWLOGS) | sort`
test-oldresult-summary:
	@cat `ls $(FASTLOGS) $(SLOWLOGS) | sort` > test.log
	@cat test.log
	@grep ^== test.log | grep failed | gawk '{ fail += $$2; sum += $$5 } END {printf "== Total: %d out of %d failed\n",fail,sum}'
fast : omc-diff fast.logs
	@cat `ls $(FASTLOGS) | sort`
	@rm -f {flattening/modelica/asserts,flattening/modelica/algorithms-functions,flattening/modelica/arrays,flattening/modelica/others,flattening/modelica/external-functions,flattening/modelica/equations,flattening/modelica/built-in-functions,flattening/modelica/extends,flattening/modelica/operators,flattening/modelica/packages,flattening/modelica/declarations,flattening/modelica/enums,flattening/modelica/synchronous,flattening/modelica/statemachines,flattening/modelica/scoping,flattening/modelica/types,flattening/modelica/modification,flattening/modelica/connectors,flattening/modelica/blocks,flattening/modelica/streams,flattening/modelica/msl,metamodelica/meta,flattening/modelica/records,openmodelica/java}/*.{dll,so,exe};
simulation: omc-diff simulation.logs
	@cat `ls $(SIMULATIONLOGS) | sort` > simulation.log
	@cat simulation.log
	@grep ^== simulation.log | grep failed | gawk '{ fail += $$2; sum += $$5 } END {printf "== Total: %d out of %d failed\n",fail,sum}'
fast.logs: $(FASTLOGS)
# java should probably also be part of 'fast'
slow.logs: $(SLOWLOGS)
simulation.logs: $(SIMULATIONLOGS)
streams.log: omc-diff
	$(MAKE) -C flattening/modelica/streams -f Makefile test > $@
	@echo $@ done
redeclare.log: omc-diff
	$(MAKE) -C flattening/modelica/redeclare -f Makefile test > $@
	@echo $@ done
modelicaasserts.log: omc-diff
	$(MAKE) -C flattening/modelica/asserts -f Makefile test > $@
	@echo $@ done
modelicaalgorithms-functions.log: omc-diff
	$(MAKE) -C flattening/modelica/algorithms-functions -f Makefile test > $@
	@echo $@ done
modelicaarrays.log: omc-diff
	$(MAKE) -C flattening/modelica/arrays -f Makefile test > $@
	@echo $@ done
modelicaothers.log: omc-diff
	$(MAKE) -C flattening/modelica/others -f Makefile test > $@
	@echo $@ done
modelicaexternal-functions.log: omc-diff
	$(MAKE) -C flattening/modelica/external-functions -f Makefile test > $@
	@echo $@ done
modelicaequations.log: omc-diff
	$(MAKE) -C flattening/modelica/equations -f Makefile test > $@
	@echo $@ done
modelicabuilt-in-functions.log: omc-diff
	$(MAKE) -C flattening/modelica/built-in-functions -f Makefile test > $@
	@echo $@ done
modelicaextends.log: omc-diff
	$(MAKE) -C flattening/modelica/extends -f Makefile test > $@
	@echo $@ done
modelicaoperators.log: omc-diff
	$(MAKE) -C flattening/modelica/operators -f Makefile test > $@
	@echo $@ done
modelicapackages.log: omc-diff
	$(MAKE) -C flattening/modelica/packages -f Makefile test > $@
	@echo $@ done
modelicadeclarations.log: omc-diff
	$(MAKE) -C flattening/modelica/declarations -f Makefile test > $@
	@echo $@ done
modelicaenums.log: omc-diff
	$(MAKE) -C flattening/modelica/enums -f Makefile test > $@
	@echo $@ done
modelicasynchronous.log: omc-diff
	$(MAKE) -C flattening/modelica/synchronous -f Makefile test > $@
	@echo $@ done
modelicastatemachines.log: omc-diff
	$(MAKE) -C flattening/modelica/statemachines -f Makefile test > $@
	@echo $@ done
modelicascoping.log: omc-diff
	$(MAKE) -C flattening/modelica/scoping -f Makefile test > $@
	@echo $@ done
modelicatypes.log: omc-diff
	$(MAKE) -C flattening/modelica/types -f Makefile test > $@
	@echo $@ done
modelicamodification.log: omc-diff
	$(MAKE) -C flattening/modelica/modification -f Makefile test > $@
	@echo $@ done
modelicaconnectors.log: omc-diff
	$(MAKE) -C flattening/modelica/connectors -f Makefile test > $@
	@echo $@ done
modelicablocks.log: omc-diff
	$(MAKE) -C flattening/modelica/blocks -f Makefile test > $@
	@echo $@ done
parser.log: omc-diff
	$(MAKE) -C openmodelica/parser -f Makefile test > $@
	@echo $@ done
uncertainties.log: omc-diff
	$(MAKE) -C openmodelica/uncertainties -f Makefile test > $@
	@echo $@ done
interactive-API.log: omc-diff
	$(MAKE) -C openmodelica/interactive-API -f Makefile test > $@
	@echo $@ done
typed-API.log: omc-diff
	$(MAKE) -C openmodelica/typed-API -f Makefile test > $@
	@echo $@ done
flatteningmodelicamsl.log: omc-diff
	$(MAKE) -C flattening/modelica/msl -f Makefile test > flatteningmodelicamsl.log
	@echo $@ done
simulationalgorithms-functions.log: omc-diff
	$(MAKE) -C simulation/modelica/algorithms_functions -f Makefile test > $@
	@echo $@ done
simulationarrays.log: omc-diff
	$(MAKE) -C simulation/modelica/arrays -f Makefile test > $@
	@echo $@ done
simulationasserts.log: omc-diff
	$(MAKE) -C simulation/modelica/asserts -f Makefile test > $@
	@echo $@ done
simulationbuilt-in-functions.log: omc-diff
	$(MAKE) -C simulation/modelica/built_in_functions -f Makefile test > $@
	@echo $@ done
simulationconnectors.log: omc-diff
	$(MAKE) -C simulation/modelica/connectors -f Makefile test > $@
	@echo $@ done
simulationdeclarations.log: omc-diff
	$(MAKE) -C simulation/modelica/declarations -f Makefile test > $@
	@echo $@ done
simulationenums.log: omc-diff
	$(MAKE) -C simulation/modelica/enums -f Makefile test > $@
	@echo $@ done
simulationequations.log: omc-diff
	$(MAKE) -C simulation/modelica/equations -f Makefile test > $@
	@echo $@ done
simulationevents.log: omc-diff
	$(MAKE) -C simulation/modelica/events -f Makefile test > $@
	@echo $@ done
simulationsynchronous.log: omc-diff
	$(MAKE) -C simulation/modelica/synchronous -f Makefile test > $@
	@echo $@ done
simulationexternal-functions.log: omc-diff
	$(MAKE) -C simulation/modelica/external_functions -f Makefile test > $@
	@echo $@ done
simulationindexreduction.log: omc-diff
	$(MAKE) -C simulation/modelica/indexreduction -f Makefile test > $@
	@echo $@ done
simulationinheritances.log: omc-diff
	$(MAKE) -C simulation/modelica/inheritances -f Makefile test > $@
	@echo $@ done
simulationjapaneselanguage.log: omc-diff
	$(MAKE) -C simulation/modelica/japaneselanguage -f Makefile test > $@
	@echo $@ done
simualtionlinear_system.log: omc-diff
	$(MAKE) -C simulation/modelica/linear_system -f Makefile test > $@
	@echo $@ done
simulationnonlinear_system.log: omc-diff
	$(MAKE) -C simulation/modelica/nonlinear_system -f Makefile test > $@
	@echo $@ done
simulationothers.log: omc-diff
	$(MAKE) -C simulation/modelica/others -f Makefile test > $@
	@echo $@ done
simulationpackages.log: omc-diff
	$(MAKE) -C simulation/modelica/packages -f Makefile test > $@
	@echo $@ done
simulationrecords.log: omc-diff
	$(MAKE) -C simulation/modelica/records -f Makefile test > $@
	@echo $@ done
simulationsolver.log: omc-diff
	$(MAKE) -C simulation/modelica/solver -f Makefile test > $@
	@echo $@ done
simulationtypes.log: omc-diff
	$(MAKE) -C simulation/modelica/types -f Makefile test > $@
	@echo $@ done
simulationmodelicamsl22.log: omc-diff
	$(MAKE) -C simulation/modelica/msl22 -f Makefile test > $@
	@echo $@ done
flatteningmosfiles.log: omc-diff
	$(MAKE) -C flattening/modelica/mosfiles -f Makefile test > $@
	@echo $@ done
meta.log: omc-diff
	$(MAKE) -C metamodelica/meta -f Makefile test > $@
	@echo $@ done
mmdev.log: omc-diff
	$(MAKE) -C metamodelica/MetaModelicaDev -f Makefile test > $@
	@echo $@ done
records.log: omc-diff
	$(MAKE) -C flattening/modelica/records -f Makefile test > $@
	@echo $@ done
expandable.log: omc-diff
	$(MAKE) -C flattening/modelica/expandable -f Makefile test > $@
	@echo $@ done
simulationinitialization.log: omc-diff
	$(MAKE) -C simulation/modelica/initialization -f Makefile test > $@
	@echo $@ done
simulationqss.log: omc-diff
	$(MAKE) -C simulation/modelica/qss -f Makefile test > $@
	@echo $@ done
simulationunitcheck.log: omc-diff
	$(MAKE) -C simulation/modelica/unitcheck -f Makefile test > $@
	@echo $@ done
simulationtearing.log: omc-diff
	$(MAKE) -C simulation/modelica/tearing -f Makefile test > $@
	@echo $@ done
cppruntime.log: omc-diff
	$(MAKE) -j1 -C openmodelica/cppruntime -f Makefile test  > $@
	@echo $@ done
cppruntimeHpcom.log: omc-diff
	$(MAKE) -j1 -C openmodelica/cppruntime/hpcom -f Makefile test  > $@
	@echo $@ done
linearization.log: omc-diff
	$(MAKE) -C openmodelica/linearization -f Makefile test > $@
	@echo $@ done
modelicaML.log: omc-diff
	$(MAKE) -C openmodelica/modelicaML -f Makefile test > $@
	@echo $@ done
openmodelicajava.log: omc-diff
	$(MAKE) -C openmodelica/java -f Makefile test > $@
	@echo $@ done
bootstrapping.log: omc-diff
	$(MAKE) -C openmodelica/bootstrapping -f Makefile test > $@
	@echo $@ done
msl22electrical.log: omc-diff
	$(MAKE) -C simulation/libraries/msl22/Electrical -f Makefile test > $@
	@echo $@ done
msl22mechanics.log: omc-diff
	$(MAKE) -C simulation/libraries/msl22/Mechanics -f Makefile test > $@
	@echo $@ done
msl22flattening.log: omc-diff
	$(MAKE) -C flattening/libraries/msl22 -f Makefile test > $@
	@echo $@ done
msl22additions.log: omc-diff
	$(MAKE) -C flattening/libraries/msl22/modelicaAdditions -f Makefile test > $@
	@echo $@ done
biochem.log: omc-diff
	$(MAKE) -C flattening/libraries/biochem -f Makefile test > $@
	@echo $@ done
msl31.log: omc-diff
	$(MAKE) -C flattening/libraries/msl31 -f Makefile test > $@
	@echo $@ done
msl32simulation.log: omc-diff
	$(MAKE) -C simulation/libraries/msl32 -f Makefile test > $@
	@echo $@ done
msl32simulation_cpp.log: omc-diff
	$(MAKE) -C simulation/libraries/msl32_cpp -f Makefile test > $@
	@echo $@ done
msl32simulation_cpp_mini.log: omc-diff
	$(MAKE) -C openmodelica/cppruntime/libraries/msl32 -f Makefile test > $@
	@echo $@ done
msl31simulation.log: omc-diff
	$(MAKE) -C simulation/libraries/msl31 -f Makefile test > $@
	@echo $@ done
msl31mediasimulation.log: omc-diff
	$(MAKE) -C simulation/libraries/msl31/media -f Makefile test > $@
	@echo $@ done
siemens_nosim.log: omc-diff
	$(MAKE) -C flattening/libraries/3rdParty/siemens -f Makefile test > $@
	@echo $@ done
siemens_simulation.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/siemens -f Makefile test > $@
	@echo $@ done
SiemensPower.log: omc-diff
	$(MAKE) -C flattening/libraries/3rdParty/SiemensPower -f Makefile test > $@
	@echo $@ done
hummod.log: omc-diff
	$(MAKE) -C flattening/libraries/3rdParty/HumMod -f Makefile test > $@
	@echo $@ done
ThermoSysPro_simulation.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/ThermoSysPro -f Makefile test > $@
	@echo $@ done
MathematicalAspects_simulation.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/MathematicalAspects -f Makefile test > $@
	@echo $@ done
PNlib_simulation.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/PNlib -f Makefile test > $@
	@echo $@ done
fmi_me_10.log: omc-diff
	$(MAKE) -C openmodelica/fmi/ModelExchange/1.0/ -f Makefile test > $@
	@echo $@ done
fmi_me_20.log: omc-diff
	$(MAKE) -C openmodelica/fmi/ModelExchange/2.0/ -f Makefile test > $@
	@echo $@ done
fmi_cs_st.log: omc-diff
	$(MAKE) -C openmodelica/fmi/CoSimulationStandAlone -f Makefile test > $@
	@echo $@ done
flatteningPlanarMechanics.log: omc-diff
	$(MAKE) -C flattening/libraries/3rdParty/PlanarMechanics -f Makefile test > $@
	@echo $@ done
simulationPlanarMechanics.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/PlanarMechanics -f Makefile test > $@
	@echo $@ done
flatteningExercises.log: omc-diff
	$(MAKE) -C flattening/libraries/3rdParty/Exercises -f Makefile test > $@
	@echo $@ done
simulationExercises.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/Exercises -f Makefile test > $@
	@echo $@ done
simulation-start-value-selection.log: omc-diff
	$(MAKE) -C simulation/modelica/start_value_selection -f Makefile test > $@
	@echo $@ done
TestMedia.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/TestMedia -f Makefile test > $@
	@echo $@ done
TestMediaFrancesco.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/TestMediaFrancesco -f Makefile test > $@
	@echo $@ done
ThermoPower.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/ThermoPower -f Makefile test > $@
	@echo $@ done
simulationDrModelica.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/DrModelica -f Makefile test > $@
	@echo $@ done
scodeinst.log: omc-diff
	$(MAKE) -C flattening/modelica/scodeinst -f Makefile test > $@
	@echo $@ done
xml.log: omc-diff
	$(MAKE) -C openmodelica/xml -f Makefile test > $@
	@echo $@ done
parallel.log: omc-diff
	$(MAKE) -C simulation/modelica/parallel -f Makefile test > $@
	@echo $@ done
taskGraph.log: omc-diff
	$(MAKE) -C simulation/modelica/hpcom -f Makefile test > $@
	@echo $@ done
debugDumps.log: omc-diff
	$(MAKE) -j1 -C openmodelica/debugDumps -f Makefile test  > $@
	@echo $@ done
optimization.log: omc-diff
	$(MAKE) -j1 -C openmodelica/cruntime/optimization/basic -f Makefile test  > $@
	$(MAKE) -j1 -C openmodelica/cruntime/optimization/benchmark -f Makefile test  > $@
	@echo $@ done
xmlFiles.log: omc-diff
	$(MAKE) -j1 -C openmodelica/cruntime/xmlFiles -f Makefile test  > $@
	@echo $@ done
simoptions.log: omc-diff
	$(MAKE) -j1 -C openmodelica/cruntime/simoptions -f Makefile test  > $@
	@echo $@ done
dumpCruntime.log: omc-diff
	$(MAKE) -j1 -C openmodelica/cruntime/debugDumps -f Makefile test  > $@
	@echo $@ done
resolveLoops.log: omc-diff
	$(MAKE) -C simulation/modelica/resolveLoops -f Makefile test > $@
	@echo $@ done
evalConstFuncs.log: omc-diff
	$(MAKE) -C simulation/modelica/functions_eval -f Makefile test > $@
	@echo $@ done
xogeny.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/Xogeny -f Makefile test > $@
	@echo $@ done
flatteningBuildings.log: omc-diff
	$(MAKE) -C flattening/libraries/3rdParty/Buildings -f Makefile test > $@
	@echo $@ done
buildings.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/Buildings -f Makefile test > $@
	@echo $@ done
annex60.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/Annex60 -f Makefile test > $@
	@echo $@ done
gitlibraries.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/GitLibraries -f Makefile test > $@
	@echo $@ done
cse.log: omc-diff
	$(MAKE) -C simulation/modelica/commonSubExp -f Makefile test > $@
	@echo $@ done
modelica3d.log: omc-diff
	$(MAKE) -C simulation/libraries/3rdParty/Modelica3D -f Makefile test > $@
	@echo $@ done

failingtest: omc-diff
	cd mofiles; $(MAKE) -f Makefile failingtest; \
	cd mosfiles; $(MAKE) -f Makefile failingtest; \
	cd ../flattening/modelica/msl; $(MAKE) -f Makefile failingtest; \
	cd ../flattening/libraries/msl22; $(MAKE) -f Makefile failingtest; \
	cd ../flattening/libraries/msl22; $(MAKE) -f Makefile failingtest; \
	cd ../msl22/modelicaAdditions; $(MAKE) -f Makefile failingtest; \
	cd ../../biochem; $(MAKE) -f Makefile failingtest; \
	cd ../multibody; $(MAKE) -f Makefile failingtest; \
	cd ../msl31; $(MAKE) -f Makefile failingtest;
	cd ../msl32; $(MAKE) -f Makefile failingtest;

clean: clean_g_1 clean_g_2 clean_g_3 clean_g_4

clean_g_1  :
	$(MAKE) -C flattening/modelica/algorithms-functions -f Makefile clean
	$(MAKE) -C flattening/modelica/arrays -f Makefile clean
	$(MAKE) -C flattening/modelica/asserts -f Makefile clean
	$(MAKE) -C flattening/modelica/blocks -f Makefile clean
	$(MAKE) -C flattening/modelica/built-in-functions -f Makefile clean
	$(MAKE) -C flattening/modelica/connectors -f Makefile clean
	$(MAKE) -C flattening/modelica/declarations -f Makefile clean
	$(MAKE) -C flattening/modelica/enums -f Makefile clean
	$(MAKE) -C flattening/modelica/synchronous -f Makefile clean
	$(MAKE) -C flattening/modelica/statemachines -f Makefile clean
	$(MAKE) -C flattening/modelica/equations -f Makefile clean
	$(MAKE) -C flattening/modelica/extends -f Makefile clean
	$(MAKE) -C flattening/modelica/external-functions -f Makefile clean
	$(MAKE) -C flattening/modelica/modification -f Makefile clean
	$(MAKE) -C flattening/modelica/operators -f Makefile clean
	$(MAKE) -C flattening/modelica/others -f Makefile clean
	$(MAKE) -C flattening/modelica/packages -f Makefile clean
	$(MAKE) -C flattening/modelica/redeclare -f Makefile clean
	$(MAKE) -C flattening/modelica/scoping -f Makefile clean
	$(MAKE) -C flattening/modelica/streams -f Makefile clean
	$(MAKE) -C flattening/modelica/types -f Makefile clean

clean_g_2 :
	$(MAKE) -C flattening/modelica/expandable -f Makefile clean
	$(MAKE) -C flattening/modelica/mosfiles -f Makefile clean
	$(MAKE) -C flattening/modelica/msl -f Makefile clean
	$(MAKE) -C flattening/modelica/records -f Makefile clean
	$(MAKE) -C metamodelica/meta -f Makefile clean
	$(MAKE) -C openmodelica/cppruntime -f Makefile clean
	$(MAKE) -C openmodelica/cppruntime/hpcom -f Makefile clean
	$(MAKE) -C openmodelica/cruntime/optimization/basic -f Makefile clean
	$(MAKE) -C openmodelica/cruntime/xmlFiles -f Makefile clean
	$(MAKE) -C openmodelica/debugDumps -f Makefile clean
	$(MAKE) -C openmodelica/dependency -f Makefile clean
	$(MAKE) -C openmodelica/interactive-API -f Makefile clean
	$(MAKE) -C openmodelica/parser -f Makefile clean
	$(MAKE) -C openmodelica/typed-API -f Makefile clean
	$(MAKE) -C openmodelica/xml -f Makefile clean
	$(MAKE) -C simulation/modelica/algorithms_functions -f Makefile clean
	$(MAKE) -C simulation/modelica/arrays -f Makefile clean
	$(MAKE) -C simulation/modelica/asserts -f Makefile clean
	$(MAKE) -C simulation/modelica/built_in_functions -f Makefile clean
	$(MAKE) -C simulation/modelica/connectors -f Makefile clean
	$(MAKE) -C simulation/modelica/declarations -f Makefile clean
	$(MAKE) -C simulation/modelica/enums -f Makefile clean
	$(MAKE) -C simulation/modelica/equations -f Makefile clean
	$(MAKE) -C simulation/modelica/events -f Makefile clean
	$(MAKE) -C simulation/modelica/synchronous -f Makefile clean
	$(MAKE) -C simulation/modelica/external_functions -f Makefile clean
	$(MAKE) -C simulation/modelica/inheritances -f Makefile clean
	$(MAKE) -C simulation/modelica/initialization -f Makefile clean
	$(MAKE) -C simulation/modelica/qss -f Makefile clean
	$(MAKE) -C simulation/modelica/unitcheck -f Makefile clean
	$(MAKE) -C simulation/modelica/tearing -f Makefile clean
	$(MAKE) -C simulation/modelica/japaneselanguage -f Makefile clean
	$(MAKE) -C simulation/modelica/linear_system -f Makefile clean
	$(MAKE) -C simulation/modelica/msl22 -f Makefile clean
	$(MAKE) -C simulation/modelica/nonlinear_system -f Makefile clean
	$(MAKE) -C simulation/modelica/others -f Makefile clean
	$(MAKE) -C simulation/modelica/packages -f Makefile clean
	$(MAKE) -C simulation/modelica/records -f Makefile clean
	$(MAKE) -C simulation/modelica/types -f Makefile clean

clean_g_3 :
	$(MAKE) -C flattening/ibraries/msl22/modelicaAdditions -f Makefile clean
	$(MAKE) -C flattening/libraries/biochem -f Makefile clean
	$(MAKE) -C flattening/libraries/msl22 -f Makefile clean
	$(MAKE) -C openmodelica/bootstrapping -f Makefile clean
	$(MAKE) -C openmodelica/linearization -f Makefile clean
	$(MAKE) -C openmodelica/modelicaML -f Makefile clean
	$(MAKE) -C simulation/libraries/msl22/Electrical -f Makefile clean
	$(MAKE) -C simulation/libraries/msl22/Mechanics -f Makefile clean

clean_g_4:
	$(MAKE) -C flattening/libraries/3rdParty/PlanarMechanics -f Makefile clean
	$(MAKE) -C flattening/libraries/3rdParty/siemens -f Makefile clean
	$(MAKE) -C flattening/libraries/3rdParty/SiemensPower -f Makefile clean
	$(MAKE) -C flattening/libraries/msl31 -f Makefile clean
	$(MAKE) -C flattening/libraries/msl31/multibody -f Makefile clean
	$(MAKE) -C flattening/libraries/msl32 -f Makefile clean
	$(MAKE) -C flattening/libraries/msl32_cpp -f Makefile clean
	$(MAKE) -C openmodelica/cppruntime/libraries/msl32 -f Makefile clean
	$(MAKE) -C openmodelica/fmi/CoSimulationStandAlone -f Makefile clean
	$(MAKE) -C openmodelica/fmi/ModelExchange/1.0 -f Makefile clean
	$(MAKE) -C openmodelica/fmi/ModelExchange/2.0 -f Makefile clean
	$(MAKE) -C simulation/libraries/3rdParty/PlanarMechanics -f Makefile clean
	$(MAKE) -C simulation/libraries/3rdParty/siemens -f Makefile clean
	$(MAKE) -C simulation/libraries/msl32 -f Makefile clean