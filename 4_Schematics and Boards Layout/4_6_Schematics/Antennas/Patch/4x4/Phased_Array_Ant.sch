<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="7.4.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="1" fill="3" visible="no" active="no"/>
<layer number="3" name="Route3" color="4" fill="3" visible="no" active="no"/>
<layer number="4" name="Route4" color="1" fill="4" visible="no" active="no"/>
<layer number="5" name="Route5" color="4" fill="4" visible="no" active="no"/>
<layer number="6" name="Route6" color="1" fill="8" visible="no" active="no"/>
<layer number="7" name="Route7" color="4" fill="8" visible="no" active="no"/>
<layer number="8" name="Route8" color="1" fill="2" visible="no" active="no"/>
<layer number="9" name="Route9" color="4" fill="2" visible="no" active="no"/>
<layer number="10" name="Route10" color="1" fill="7" visible="no" active="no"/>
<layer number="11" name="Route11" color="4" fill="7" visible="no" active="no"/>
<layer number="12" name="Route12" color="1" fill="5" visible="no" active="no"/>
<layer number="13" name="Route13" color="4" fill="5" visible="no" active="no"/>
<layer number="14" name="Route14" color="1" fill="6" visible="no" active="no"/>
<layer number="15" name="Route15" color="4" fill="6" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="24" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="Eagle_WR-SMP_rev21a">
<description>&lt;BR&gt;Wurth Elektronik - Connectors - Coaxial Connectors - WR-SMP &lt;br&gt;&lt;Hr&gt;

&lt;BR&gt;
&lt;TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0&gt;
&lt;TR&gt;   
&lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;&lt;BR&gt;&lt;br&gt;
      &amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; &amp;nbsp;&lt;BR&gt;
       &lt;BR&gt;
       &lt;BR&gt;
       &lt;BR&gt;&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
&lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;&lt;br&gt;
      -----&lt;BR&gt;
      -----&lt;BR&gt;
      -----&lt;BR&gt;
      -----&lt;BR&gt;
      -----&lt;BR&gt;&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt; &lt;FONT FACE=ARIAL SIZE=3&gt;&lt;br&gt;
      ---------------------------&lt;BR&gt;
&lt;B&gt;&lt;I&gt;&lt;span style='font-size:26pt;
  color:#FF6600;'&gt;WE &lt;/span&gt;&lt;/i&gt;&lt;/b&gt;
&lt;BR&gt;
      ---------------------------&lt;BR&gt;&lt;b&gt;Würth Elektronik&lt;/b&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;&lt;br&gt;
      ---------O---&lt;BR&gt;
      ----O--------&lt;BR&gt;
      ---------O---&lt;BR&gt;
      ----O--------&lt;BR&gt;
      ---------O---&lt;BR&gt;&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
   
&lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;&lt;BR&gt;
      &amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; &amp;nbsp;&lt;BR&gt;
       &lt;BR&gt;
       &lt;BR&gt;
       &lt;BR&gt;
       &lt;BR&gt;&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;

  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  
&lt;/TABLE&gt;
&lt;B&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;More than you expect&lt;BR&gt;&lt;BR&gt;&lt;BR&gt;&lt;/B&gt;

&lt;HR&gt;&lt;BR&gt;
&lt;b&gt;Würth Elektronik eiSos GmbH &amp; Co. KG&lt;/b&gt;&lt;br&gt;
EMC &amp; Inductive Solutions&lt;br&gt;

Max-Eyth-Str.1&lt;br&gt;
D-74638 Waldenburg&lt;br&gt;
&lt;br&gt;
Tel: +49 (0)7942-945-0&lt;br&gt;
Fax:+49 (0)7942-945-5000&lt;br&gt;
&lt;br&gt;
&lt;a href="http://www.we-online.com/web/en/electronic_components/produkte_pb/bauteilebibliotheken/eagle_4.php"&gt;www.we-online.com/eagle&lt;/a&gt;&lt;br&gt;
&lt;a href="mailto:libraries@we-online.com"&gt;libraries@we-online.com&lt;/a&gt; &lt;BR&gt;&lt;BR&gt;
&lt;br&gt;&lt;HR&gt;&lt;BR&gt;
Neither Autodesk nor Würth Elektronik eiSos does warrant that this library is error-free or &lt;br&gt;
that it meets your specific requirements.&lt;br&gt;&lt;BR&gt;
Please contact us for more information.&lt;br&gt;
&lt;HR&gt;
&lt;br&gt;Eagle Version 9, Library Revision 2021a, 2021-04-14&lt;br&gt;
&lt;HR&gt;
Copyright: Würth Elektronik</description>
<packages>
<package name="60124102122403">
<description>&lt;B&gt;WR-SMP Straight</description>
<smd name="1" x="0" y="-2.9" dx="0.48" dy="1.4" layer="1"/>
<smd name="3" x="0" y="2.45" dx="0.3" dy="4" layer="1" rot="R90" stop="no" cream="no"/>
<smd name="2" x="-2.45" y="0.1" dx="0.3" dy="4" layer="1" rot="R180" stop="no" cream="no"/>
<smd name="4" x="2.45" y="0.2" dx="0.3" dy="4" layer="1" rot="R180" stop="no" cream="no"/>
<polygon width="0.1" layer="39">
<vertex x="-2.8" y="2.8"/>
<vertex x="2.8" y="2.8"/>
<vertex x="2.8" y="-3.8"/>
<vertex x="-2.8" y="-3.8"/>
</polygon>
<polygon width="0.1" layer="31">
<vertex x="-1" y="-2.07"/>
<vertex x="-1" y="-2.6"/>
<vertex x="-2.6" y="-2.6"/>
<vertex x="-2.6" y="2.6"/>
<vertex x="2.6" y="2.6"/>
<vertex x="2.6" y="-2.6"/>
<vertex x="1" y="-2.6"/>
<vertex x="1" y="-2.07"/>
<vertex x="1.035" y="-2.055"/>
<vertex x="1.1" y="-2.02"/>
<vertex x="1.17" y="-1.98"/>
<vertex x="1.235" y="-1.94"/>
<vertex x="1.31" y="-1.89"/>
<vertex x="1.375" y="-1.845"/>
<vertex x="1.45" y="-1.785"/>
<vertex x="1.515" y="-1.73"/>
<vertex x="1.57" y="-1.68"/>
<vertex x="1.6" y="-1.65"/>
<vertex x="1.655" y="-1.595"/>
<vertex x="1.695" y="-1.555"/>
<vertex x="1.76" y="-1.48"/>
<vertex x="1.79" y="-1.445"/>
<vertex x="1.825" y="-1.4"/>
<vertex x="1.88" y="-1.325"/>
<vertex x="1.925" y="-1.26"/>
<vertex x="1.98" y="-1.17"/>
<vertex x="2.025" y="-1.09"/>
<vertex x="2.065" y="-1.015"/>
<vertex x="2.1" y="-0.94"/>
<vertex x="2.13" y="-0.87"/>
<vertex x="2.165" y="-0.78"/>
<vertex x="2.195" y="-0.69"/>
<vertex x="2.22" y="-0.6"/>
<vertex x="2.24" y="-0.525"/>
<vertex x="2.255" y="-0.455"/>
<vertex x="2.27" y="-0.37"/>
<vertex x="2.28" y="-0.305"/>
<vertex x="2.29" y="-0.21"/>
<vertex x="2.295" y="-0.145"/>
<vertex x="2.3" y="-0.06"/>
<vertex x="2.3" y="0" curve="90"/>
<vertex x="0" y="2.3" curve="90"/>
<vertex x="-2.3" y="0"/>
<vertex x="-2.3" y="-0.05"/>
<vertex x="-2.3" y="-0.07"/>
<vertex x="-2.295" y="-0.155"/>
<vertex x="-2.29" y="-0.21"/>
<vertex x="-2.285" y="-0.265"/>
<vertex x="-2.28" y="-0.305"/>
<vertex x="-2.27" y="-0.37"/>
<vertex x="-2.26" y="-0.43"/>
<vertex x="-2.24" y="-0.525"/>
<vertex x="-2.22" y="-0.605"/>
<vertex x="-2.2" y="-0.675"/>
<vertex x="-2.18" y="-0.735"/>
<vertex x="-2.165" y="-0.78"/>
<vertex x="-2.14" y="-0.845"/>
<vertex x="-2.11" y="-0.92"/>
<vertex x="-2.075" y="-0.995"/>
<vertex x="-2.045" y="-1.055"/>
<vertex x="-2.015" y="-1.11"/>
<vertex x="-1.99" y="-1.155"/>
<vertex x="-1.95" y="-1.22"/>
<vertex x="-1.915" y="-1.275"/>
<vertex x="-1.87" y="-1.34"/>
<vertex x="-1.825" y="-1.4"/>
<vertex x="-1.785" y="-1.45"/>
<vertex x="-1.76" y="-1.48"/>
<vertex x="-1.72" y="-1.525"/>
<vertex x="-1.675" y="-1.575"/>
<vertex x="-1.62" y="-1.63"/>
<vertex x="-1.585" y="-1.665"/>
<vertex x="-1.53" y="-1.715"/>
<vertex x="-1.49" y="-1.75"/>
<vertex x="-1.43" y="-1.8"/>
<vertex x="-1.385" y="-1.835"/>
<vertex x="-1.31" y="-1.89"/>
<vertex x="-1.235" y="-1.94"/>
<vertex x="-1.145" y="-1.995"/>
<vertex x="-1.08" y="-2.03"/>
<vertex x="-1.025" y="-2.06"/>
</polygon>
<polygon width="0.1" layer="29">
<vertex x="-0.9" y="-2.01"/>
<vertex x="-0.9" y="-2.7"/>
<vertex x="-2.7" y="-2.7"/>
<vertex x="-2.7" y="2.7"/>
<vertex x="2.7" y="2.7"/>
<vertex x="2.7" y="-2.7"/>
<vertex x="0.9" y="-2.7"/>
<vertex x="0.9" y="-2.01"/>
<vertex x="0.97" y="-1.975"/>
<vertex x="1.03" y="-1.945"/>
<vertex x="1.095" y="-1.91"/>
<vertex x="1.15" y="-1.875"/>
<vertex x="1.215" y="-1.835"/>
<vertex x="1.3" y="-1.775"/>
<vertex x="1.365" y="-1.725"/>
<vertex x="1.42" y="-1.68"/>
<vertex x="1.465" y="-1.64"/>
<vertex x="1.525" y="-1.585"/>
<vertex x="1.585" y="-1.525"/>
<vertex x="1.65" y="-1.455"/>
<vertex x="1.715" y="-1.38"/>
<vertex x="1.765" y="-1.315"/>
<vertex x="1.82" y="-1.235"/>
<vertex x="1.855" y="-1.185"/>
<vertex x="1.895" y="-1.12"/>
<vertex x="1.94" y="-1.04"/>
<vertex x="1.985" y="-0.95"/>
<vertex x="2.025" y="-0.86"/>
<vertex x="2.06" y="-0.775"/>
<vertex x="2.09" y="-0.69"/>
<vertex x="2.125" y="-0.575"/>
<vertex x="2.145" y="-0.49"/>
<vertex x="2.165" y="-0.395"/>
<vertex x="2.175" y="-0.335"/>
<vertex x="2.185" y="-0.255"/>
<vertex x="2.195" y="-0.155"/>
<vertex x="2.2" y="-0.055"/>
<vertex x="2.2" y="0" curve="90"/>
<vertex x="0" y="2.2" curve="90"/>
<vertex x="-2.2" y="0"/>
<vertex x="-2.2" y="-0.055"/>
<vertex x="-2.2" y="-0.07"/>
<vertex x="-2.195" y="-0.145"/>
<vertex x="-2.19" y="-0.21"/>
<vertex x="-2.18" y="-0.295"/>
<vertex x="-2.175" y="-0.335"/>
<vertex x="-2.16" y="-0.42"/>
<vertex x="-2.15" y="-0.465"/>
<vertex x="-2.14" y="-0.515"/>
<vertex x="-2.12" y="-0.59"/>
<vertex x="-2.1" y="-0.66"/>
<vertex x="-2.07" y="-0.75"/>
<vertex x="-2.04" y="-0.825"/>
<vertex x="-2" y="-0.92"/>
<vertex x="-1.955" y="-1.01"/>
<vertex x="-1.915" y="-1.085"/>
<vertex x="-1.86" y="-1.175"/>
<vertex x="-1.79" y="-1.28"/>
<vertex x="-1.74" y="-1.345"/>
<vertex x="-1.68" y="-1.42"/>
<vertex x="-1.615" y="-1.495"/>
<vertex x="-1.54" y="-1.57"/>
<vertex x="-1.46" y="-1.645"/>
<vertex x="-1.36" y="-1.73"/>
<vertex x="-1.28" y="-1.79"/>
<vertex x="-1.2" y="-1.845"/>
<vertex x="-1.11" y="-1.9"/>
<vertex x="-1" y="-1.96"/>
</polygon>
<polygon width="0.1" layer="1">
<vertex x="-1" y="-2.07"/>
<vertex x="-1" y="-2.6"/>
<vertex x="-2.6" y="-2.6"/>
<vertex x="-2.6" y="2.6"/>
<vertex x="2.6" y="2.6"/>
<vertex x="2.6" y="-2.6"/>
<vertex x="1" y="-2.6"/>
<vertex x="1" y="-2.07"/>
<vertex x="1.035" y="-2.055"/>
<vertex x="1.1" y="-2.02"/>
<vertex x="1.17" y="-1.98"/>
<vertex x="1.235" y="-1.94"/>
<vertex x="1.31" y="-1.89"/>
<vertex x="1.375" y="-1.845"/>
<vertex x="1.45" y="-1.785"/>
<vertex x="1.515" y="-1.73"/>
<vertex x="1.57" y="-1.68"/>
<vertex x="1.6" y="-1.65"/>
<vertex x="1.655" y="-1.595"/>
<vertex x="1.695" y="-1.555"/>
<vertex x="1.76" y="-1.48"/>
<vertex x="1.79" y="-1.445"/>
<vertex x="1.825" y="-1.4"/>
<vertex x="1.88" y="-1.325"/>
<vertex x="1.925" y="-1.26"/>
<vertex x="1.98" y="-1.17"/>
<vertex x="2.025" y="-1.09"/>
<vertex x="2.065" y="-1.015"/>
<vertex x="2.1" y="-0.94"/>
<vertex x="2.13" y="-0.87"/>
<vertex x="2.165" y="-0.78"/>
<vertex x="2.195" y="-0.69"/>
<vertex x="2.22" y="-0.6"/>
<vertex x="2.24" y="-0.525"/>
<vertex x="2.255" y="-0.455"/>
<vertex x="2.27" y="-0.37"/>
<vertex x="2.28" y="-0.305"/>
<vertex x="2.29" y="-0.21"/>
<vertex x="2.295" y="-0.145"/>
<vertex x="2.3" y="-0.06"/>
<vertex x="2.3" y="0" curve="90"/>
<vertex x="0" y="2.3" curve="90"/>
<vertex x="-2.3" y="0"/>
<vertex x="-2.3" y="-0.05"/>
<vertex x="-2.3" y="-0.07"/>
<vertex x="-2.295" y="-0.155"/>
<vertex x="-2.29" y="-0.21"/>
<vertex x="-2.285" y="-0.265"/>
<vertex x="-2.28" y="-0.305"/>
<vertex x="-2.27" y="-0.37"/>
<vertex x="-2.26" y="-0.43"/>
<vertex x="-2.24" y="-0.525"/>
<vertex x="-2.22" y="-0.605"/>
<vertex x="-2.2" y="-0.675"/>
<vertex x="-2.18" y="-0.735"/>
<vertex x="-2.165" y="-0.78"/>
<vertex x="-2.14" y="-0.845"/>
<vertex x="-2.11" y="-0.92"/>
<vertex x="-2.075" y="-0.995"/>
<vertex x="-2.045" y="-1.055"/>
<vertex x="-2.015" y="-1.11"/>
<vertex x="-1.99" y="-1.155"/>
<vertex x="-1.95" y="-1.22"/>
<vertex x="-1.915" y="-1.275"/>
<vertex x="-1.87" y="-1.34"/>
<vertex x="-1.825" y="-1.4"/>
<vertex x="-1.785" y="-1.45"/>
<vertex x="-1.76" y="-1.48"/>
<vertex x="-1.72" y="-1.525"/>
<vertex x="-1.675" y="-1.575"/>
<vertex x="-1.62" y="-1.63"/>
<vertex x="-1.585" y="-1.665"/>
<vertex x="-1.53" y="-1.715"/>
<vertex x="-1.49" y="-1.75"/>
<vertex x="-1.43" y="-1.8"/>
<vertex x="-1.385" y="-1.835"/>
<vertex x="-1.31" y="-1.89"/>
<vertex x="-1.235" y="-1.94"/>
<vertex x="-1.145" y="-1.995"/>
<vertex x="-1.08" y="-2.03"/>
<vertex x="-1.025" y="-2.06"/>
</polygon>
<wire x1="-2.5" y1="2.5" x2="2.5" y2="2.5" width="0.1" layer="51"/>
<wire x1="2.5" y1="2.5" x2="2.5" y2="-2.5" width="0.1" layer="51"/>
<wire x1="2.5" y1="-2.5" x2="0.2" y2="-2.5" width="0.1" layer="51"/>
<wire x1="0.2" y1="-2.5" x2="0.2" y2="-3.3" width="0.1" layer="51"/>
<wire x1="0.2" y1="-3.3" x2="-0.2" y2="-3.3" width="0.1" layer="51"/>
<wire x1="-0.2" y1="-3.3" x2="-0.2" y2="-2.5" width="0.1" layer="51"/>
<wire x1="-0.2" y1="-2.5" x2="-2.5" y2="-2.5" width="0.1" layer="51"/>
<wire x1="-2.5" y1="-2.5" x2="-2.5" y2="2.5" width="0.1" layer="51"/>
<text x="0" y="3.3" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="-3.5" y="-5.5" size="1.27" layer="27">&gt;VALUE</text>
</package>
</packages>
<symbols>
<symbol name="PLUG">
<circle x="0" y="0" radius="2.54" width="0.2" layer="94"/>
<circle x="0" y="0" radius="0.254" width="0.508" layer="94"/>
<pin name="1" x="7.62" y="0" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="2" x="7.62" y="-5.08" visible="pad" length="short" direction="pas" rot="R180"/>
<text x="0" y="3.54" size="1.778" layer="95" align="bottom-center">&gt;NAME</text>
<text x="-5.08" y="-8.08" size="1.778" layer="96">&gt;VALUE</text>
<wire x1="0" y1="-2.54" x2="0" y2="-5.08" width="0.254" layer="94"/>
<wire x1="0" y1="-5.08" x2="5.08" y2="-5.08" width="0.254" layer="94"/>
<wire x1="5.08" y1="0" x2="0.54" y2="0" width="0.254" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="60124102122403" prefix="J">
<description>&lt;b&gt; WR-SMP Straight&lt;/b&gt;
&lt;b&gt;&lt;br&gt;&lt;br&gt;
MATERIAL PROPERTIES 
&lt;br&gt;&lt;br&gt;
&lt;/b&gt;Insulator Material LCP 
&lt;br&gt;Center Contact Material Brass 
&lt;br&gt;Center Contact Plating Gold, min. 0.127 μm over Nickel 
&lt;br&gt;Body Material Brass 
&lt;br&gt;Body Plating Gold, min. 0.127 μm over Nickel 
&lt;br&gt;
&lt;br&gt;
&lt;b&gt;KIND PROPERTIES 
&lt;br&gt;&lt;br&gt;
&lt;/b&gt;Interface MIL-STD-348 
&lt;br&gt;Connector Type SMP 
&lt;br&gt;Gender Plug 
&lt;br&gt;Orientation Type Straight 
&lt;br&gt;
&lt;br&gt;
&lt;b&gt;GENERAL INFORMATION 
&lt;br&gt;&lt;br&gt;
&lt;/b&gt;Operating Temperature -65 up to +165 °C  
&lt;br&gt;
&lt;br&gt;
&lt;b&gt;ELECTRICAL PROPERTIES 
&lt;br&gt;&lt;br&gt;
&lt;/b&gt;f DC~12 GHz 
&lt;br&gt;
&lt;br&gt;
&lt;b&gt;MECHANICAL PROPERTIES 
&lt;br&gt;&lt;br&gt;
&lt;/b&gt;Mating Cycle 500 Cycles; 1000 Cycles 
&lt;br&gt;
&lt;br&gt;
&lt;b&gt;PACKAGING PROPERTIES 
&lt;br&gt;&lt;br&gt;
&lt;/b&gt;Packaging Tray 
&lt;br&gt;
 &lt;br&gt;

&lt;br&gt;&lt;a href="https://www.we-online.com/catalog/media/o176648v209%20Family_WR-SMP_60114102122403.jpg" title="Enlarge picture"&gt;
&lt;img src="https://www.we-online.com/catalog/media/o176648v209%20Family_WR-SMP_60114102122403.jpg"  width="320"&gt;&lt;/a&gt;&lt;p&gt;
Details see: &lt;a href="https://www.we-online.com/catalog/en/SMP_SMT_STRAIGHT/"&gt;https://www.we-online.com/catalog/en/SMP_SMT_STRAIGHT/&lt;/a&gt;&lt;p&gt;
Updated by Ella Wu 2020-05-29&lt;br&gt;
2020(C) Würth Elektronik</description>
<gates>
<gate name="G$1" symbol="PLUG" x="0" y="0"/>
</gates>
<devices>
<device name="" package="60124102122403">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2 3 4" route="any"/>
</connects>
<technologies>
<technology name="">
<attribute name="DATASHEET-URL" value="https://www.we-online.com/catalog/datasheet/60124102122403.pdf"/>
<attribute name="GENDER" value="Plug"/>
<attribute name="INTERFACE" value="MIL-STD-348"/>
<attribute name="MOUNT" value="SMT"/>
<attribute name="ORIENTATION-TYPE" value="Straight"/>
<attribute name="PART-NUMBER" value="60124102122403"/>
<attribute name="VALUE" value="60124102122403"/>
<attribute name="Z" value="50Ohm"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply1">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
 GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
 Please keep in mind, that these devices are necessary for the
 automatic wiring of the supply signals.&lt;p&gt;
 The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
 In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
 &lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="GND">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" prefix="GND">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="My_Library_RADAR">
<packages>
<package name="10.5GHZ_ANT">
<smd name="P$1" x="0" y="0" dx="9.538" dy="7.636" layer="1"/>
</package>
</packages>
<symbols>
<symbol name="10.5GHZ_ANT">
<wire x1="-5.08" y1="7.62" x2="5.08" y2="7.62" width="0.254" layer="94"/>
<wire x1="5.08" y1="7.62" x2="5.08" y2="-7.62" width="0.254" layer="94"/>
<wire x1="5.08" y1="-7.62" x2="-5.08" y2="-7.62" width="0.254" layer="94"/>
<wire x1="-5.08" y1="-7.62" x2="-5.08" y2="7.62" width="0.254" layer="94"/>
<pin name="P$1" x="-10.16" y="2.54" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="10.5GHZ_ANT">
<gates>
<gate name="G$1" symbol="10.5GHZ_ANT" x="0" y="0"/>
</gates>
<devices>
<device name="" package="10.5GHZ_ANT">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="J1" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="4_1"/>
<part name="J2" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="4_2"/>
<part name="J3" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="4_3"/>
<part name="J4" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="4_4"/>
<part name="J5" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="3_1"/>
<part name="J6" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="3_2"/>
<part name="J7" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="3_3"/>
<part name="J8" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="3_4"/>
<part name="J9" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="2_1"/>
<part name="J10" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="2_2"/>
<part name="J11" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="2_3"/>
<part name="J12" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="2_4"/>
<part name="J13" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="1_1"/>
<part name="J14" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="1_2"/>
<part name="J15" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="1_3"/>
<part name="J16" library="Eagle_WR-SMP_rev21a" deviceset="60124102122403" device="" value="1_4"/>
<part name="GND1" library="supply1" deviceset="GND" device=""/>
<part name="GND2" library="supply1" deviceset="GND" device=""/>
<part name="GND3" library="supply1" deviceset="GND" device=""/>
<part name="GND4" library="supply1" deviceset="GND" device=""/>
<part name="GND5" library="supply1" deviceset="GND" device=""/>
<part name="GND6" library="supply1" deviceset="GND" device=""/>
<part name="GND7" library="supply1" deviceset="GND" device=""/>
<part name="GND8" library="supply1" deviceset="GND" device=""/>
<part name="GND9" library="supply1" deviceset="GND" device=""/>
<part name="GND10" library="supply1" deviceset="GND" device=""/>
<part name="GND11" library="supply1" deviceset="GND" device=""/>
<part name="GND12" library="supply1" deviceset="GND" device=""/>
<part name="GND13" library="supply1" deviceset="GND" device=""/>
<part name="GND14" library="supply1" deviceset="GND" device=""/>
<part name="GND15" library="supply1" deviceset="GND" device=""/>
<part name="GND16" library="supply1" deviceset="GND" device=""/>
<part name="U$1" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$2" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$3" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$4" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$5" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$6" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$7" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$8" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$9" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$10" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$11" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$12" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$13" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$14" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$15" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
<part name="U$16" library="My_Library_RADAR" deviceset="10.5GHZ_ANT" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="J1" gate="G$1" x="12.7" y="83.82"/>
<instance part="J2" gate="G$1" x="12.7" y="63.5"/>
<instance part="J3" gate="G$1" x="12.7" y="43.18"/>
<instance part="J4" gate="G$1" x="12.7" y="22.86"/>
<instance part="J5" gate="G$1" x="60.96" y="83.82"/>
<instance part="J6" gate="G$1" x="60.96" y="63.5"/>
<instance part="J7" gate="G$1" x="60.96" y="43.18"/>
<instance part="J8" gate="G$1" x="60.96" y="22.86"/>
<instance part="J9" gate="G$1" x="106.68" y="83.82"/>
<instance part="J10" gate="G$1" x="106.68" y="63.5"/>
<instance part="J11" gate="G$1" x="106.68" y="43.18"/>
<instance part="J12" gate="G$1" x="106.68" y="22.86"/>
<instance part="J13" gate="G$1" x="154.94" y="83.82"/>
<instance part="J14" gate="G$1" x="154.94" y="63.5"/>
<instance part="J15" gate="G$1" x="154.94" y="43.18"/>
<instance part="J16" gate="G$1" x="154.94" y="22.86"/>
<instance part="GND1" gate="1" x="20.32" y="76.2"/>
<instance part="GND2" gate="1" x="20.32" y="55.88"/>
<instance part="GND3" gate="1" x="20.32" y="35.56"/>
<instance part="GND4" gate="1" x="20.32" y="15.24"/>
<instance part="GND5" gate="1" x="78.74" y="76.2"/>
<instance part="GND6" gate="1" x="78.74" y="55.88"/>
<instance part="GND7" gate="1" x="78.74" y="35.56"/>
<instance part="GND8" gate="1" x="78.74" y="15.24"/>
<instance part="GND9" gate="1" x="124.46" y="15.24"/>
<instance part="GND10" gate="1" x="124.46" y="35.56"/>
<instance part="GND11" gate="1" x="124.46" y="55.88"/>
<instance part="GND12" gate="1" x="124.46" y="76.2"/>
<instance part="GND13" gate="1" x="172.72" y="76.2"/>
<instance part="GND14" gate="1" x="172.72" y="55.88"/>
<instance part="GND15" gate="1" x="172.72" y="35.56"/>
<instance part="GND16" gate="1" x="172.72" y="15.24"/>
<instance part="U$1" gate="G$1" x="30.48" y="81.28"/>
<instance part="U$2" gate="G$1" x="30.48" y="60.96"/>
<instance part="U$3" gate="G$1" x="30.48" y="40.64"/>
<instance part="U$4" gate="G$1" x="30.48" y="20.32"/>
<instance part="U$5" gate="G$1" x="86.36" y="81.28"/>
<instance part="U$6" gate="G$1" x="86.36" y="60.96"/>
<instance part="U$7" gate="G$1" x="86.36" y="40.64"/>
<instance part="U$8" gate="G$1" x="86.36" y="20.32"/>
<instance part="U$9" gate="G$1" x="132.08" y="81.28"/>
<instance part="U$10" gate="G$1" x="132.08" y="60.96"/>
<instance part="U$11" gate="G$1" x="132.08" y="40.64"/>
<instance part="U$12" gate="G$1" x="132.08" y="20.32"/>
<instance part="U$13" gate="G$1" x="180.34" y="81.28"/>
<instance part="U$14" gate="G$1" x="180.34" y="60.96"/>
<instance part="U$15" gate="G$1" x="180.34" y="40.64"/>
<instance part="U$16" gate="G$1" x="180.34" y="20.32"/>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="0">
<segment>
<pinref part="J1" gate="G$1" pin="2"/>
<pinref part="GND1" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="J2" gate="G$1" pin="2"/>
<pinref part="GND2" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="J3" gate="G$1" pin="2"/>
<pinref part="GND3" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="J4" gate="G$1" pin="2"/>
<pinref part="GND4" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="J5" gate="G$1" pin="2"/>
<pinref part="GND5" gate="1" pin="GND"/>
<wire x1="78.74" y1="78.74" x2="68.58" y2="78.74" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J6" gate="G$1" pin="2"/>
<pinref part="GND6" gate="1" pin="GND"/>
<wire x1="78.74" y1="58.42" x2="68.58" y2="58.42" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J7" gate="G$1" pin="2"/>
<pinref part="GND7" gate="1" pin="GND"/>
<wire x1="78.74" y1="38.1" x2="68.58" y2="38.1" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J8" gate="G$1" pin="2"/>
<pinref part="GND8" gate="1" pin="GND"/>
<wire x1="78.74" y1="17.78" x2="68.58" y2="17.78" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J12" gate="G$1" pin="2"/>
<pinref part="GND9" gate="1" pin="GND"/>
<wire x1="124.46" y1="17.78" x2="114.3" y2="17.78" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J11" gate="G$1" pin="2"/>
<pinref part="GND10" gate="1" pin="GND"/>
<wire x1="124.46" y1="38.1" x2="114.3" y2="38.1" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J10" gate="G$1" pin="2"/>
<pinref part="GND11" gate="1" pin="GND"/>
<wire x1="124.46" y1="58.42" x2="114.3" y2="58.42" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J9" gate="G$1" pin="2"/>
<pinref part="GND12" gate="1" pin="GND"/>
<wire x1="124.46" y1="78.74" x2="114.3" y2="78.74" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J13" gate="G$1" pin="2"/>
<pinref part="GND13" gate="1" pin="GND"/>
<wire x1="172.72" y1="78.74" x2="162.56" y2="78.74" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J14" gate="G$1" pin="2"/>
<pinref part="GND14" gate="1" pin="GND"/>
<wire x1="172.72" y1="58.42" x2="162.56" y2="58.42" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J15" gate="G$1" pin="2"/>
<pinref part="GND15" gate="1" pin="GND"/>
<wire x1="172.72" y1="38.1" x2="162.56" y2="38.1" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J16" gate="G$1" pin="2"/>
<pinref part="GND16" gate="1" pin="GND"/>
<wire x1="172.72" y1="17.78" x2="162.56" y2="17.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="J1" gate="G$1" pin="1"/>
<pinref part="U$1" gate="G$1" pin="P$1"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="J2" gate="G$1" pin="1"/>
<pinref part="U$2" gate="G$1" pin="P$1"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="J3" gate="G$1" pin="1"/>
<pinref part="U$3" gate="G$1" pin="P$1"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="J4" gate="G$1" pin="1"/>
<pinref part="U$4" gate="G$1" pin="P$1"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="J5" gate="G$1" pin="1"/>
<pinref part="U$5" gate="G$1" pin="P$1"/>
<wire x1="68.58" y1="83.82" x2="76.2" y2="83.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="J6" gate="G$1" pin="1"/>
<pinref part="U$6" gate="G$1" pin="P$1"/>
<wire x1="68.58" y1="63.5" x2="76.2" y2="63.5" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="J7" gate="G$1" pin="1"/>
<pinref part="U$7" gate="G$1" pin="P$1"/>
<wire x1="68.58" y1="43.18" x2="76.2" y2="43.18" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="J8" gate="G$1" pin="1"/>
<pinref part="U$8" gate="G$1" pin="P$1"/>
<wire x1="68.58" y1="22.86" x2="76.2" y2="22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="J9" gate="G$1" pin="1"/>
<pinref part="U$9" gate="G$1" pin="P$1"/>
<wire x1="114.3" y1="83.82" x2="121.92" y2="83.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="J10" gate="G$1" pin="1"/>
<pinref part="U$10" gate="G$1" pin="P$1"/>
<wire x1="114.3" y1="63.5" x2="121.92" y2="63.5" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="J11" gate="G$1" pin="1"/>
<pinref part="U$11" gate="G$1" pin="P$1"/>
<wire x1="114.3" y1="43.18" x2="121.92" y2="43.18" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="J12" gate="G$1" pin="1"/>
<pinref part="U$12" gate="G$1" pin="P$1"/>
<wire x1="114.3" y1="22.86" x2="121.92" y2="22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="J13" gate="G$1" pin="1"/>
<pinref part="U$13" gate="G$1" pin="P$1"/>
<wire x1="162.56" y1="83.82" x2="170.18" y2="83.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="J14" gate="G$1" pin="1"/>
<pinref part="U$14" gate="G$1" pin="P$1"/>
<wire x1="162.56" y1="63.5" x2="170.18" y2="63.5" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="J15" gate="G$1" pin="1"/>
<pinref part="U$15" gate="G$1" pin="P$1"/>
<wire x1="162.56" y1="43.18" x2="170.18" y2="43.18" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="J16" gate="G$1" pin="1"/>
<pinref part="U$16" gate="G$1" pin="P$1"/>
<wire x1="162.56" y1="22.86" x2="170.18" y2="22.86" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
