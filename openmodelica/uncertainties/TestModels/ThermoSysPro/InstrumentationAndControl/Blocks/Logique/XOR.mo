within ThermoSysPro.InstrumentationAndControl.Blocks.Logique;
block XOR
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={Rectangle(extent={{-100,-100},{100,100}}, lineColor={0,0,255}, pattern=LinePattern.Solid, lineThickness=0.25, fillColor={235,235,235}, fillPattern=FillPattern.Solid),Text(lineColor={0,0,255}, extent={{-54,20},{50,-20}}, fillColor={0,0,0}, textString="= 1"),Text(lineColor={0,0,255}, extent={{-150,150},{150,110}}, textString="%name")}), Diagram, Documentation(info="<html>
<p><b>Version 1.6</b></p>
</HTML>
"));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL1 annotation(Placement(transformation(x=-110.0, y=60.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false), iconTransformation(x=-110.0, y=60.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical uL2 annotation(Placement(transformation(x=-110.0, y=-60.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false), iconTransformation(x=-110.0, y=-60.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputLogical yL annotation(Placement(transformation(x=110.0, y=0.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false), iconTransformation(x=110.0, y=0.0, scale=0.1, aspectRatio=1.0, flipHorizontal=false, flipVertical=false)));
algorithm
  yL.signal:=if uL1.signal and uL2.signal or not uL1.signal and not uL2.signal then false else true;
end XOR;
