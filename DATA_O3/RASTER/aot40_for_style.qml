<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" minScale="1e+08" styleCategories="AllStyleCategories" version="3.16.7-Hannover" hasScaleBasedVisibilityFlag="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal enabled="0" mode="0" fetchMode="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <customproperties>
    <property key="WMSBackgroundLayer" value="false"/>
    <property key="WMSPublishDataSourceUrl" value="false"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="identify/format" value="Value"/>
  </customproperties>
  <pipe>
    <provider>
      <resampling zoomedInResamplingMethod="nearestNeighbour" enabled="false" zoomedOutResamplingMethod="nearestNeighbour" maxOversampling="2"/>
    </provider>
    <rasterrenderer type="singlebandpseudocolor" alphaBand="-1" opacity="1" nodataColor="" band="1" classificationMax="9000" classificationMin="1353.36">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Exact</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <rastershader>
        <colorrampshader classificationMode="1" labelPrecision="6" colorRampType="DISCRETE" maximumValue="9000" clip="0" minimumValue="1353.36">
          <colorramp type="gradient" name="[source]">
            <prop v="230,97,1,255" k="color1"/>
            <prop v="94,60,153,255" k="color2"/>
            <prop v="0" k="discrete"/>
            <prop v="gradient" k="rampType"/>
            <prop v="0.25;253,184,99,255:0.5;247,247,247,255:0.75;178,171,210,255" k="stops"/>
          </colorramp>
          <item alpha="255" label="&lt;= 5000" value="5000" color="#2b83ba"/>
          <item alpha="255" label="5000 - 10000" value="10000" color="#abdda4"/>
          <item alpha="255" label="10000 - 15000" value="15000" color="#ffffbf"/>
          <item alpha="255" label="15000 - 25000" value="25000" color="#fdae61"/>
          <item alpha="255" label="> 25000" value="inf" color="#d7191c"/>
        </colorrampshader>
      </rastershader>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0" gamma="1"/>
    <huesaturation grayscaleMode="0" colorizeStrength="100" colorizeGreen="128" colorizeOn="0" colorizeRed="255" saturation="0" colorizeBlue="128"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
