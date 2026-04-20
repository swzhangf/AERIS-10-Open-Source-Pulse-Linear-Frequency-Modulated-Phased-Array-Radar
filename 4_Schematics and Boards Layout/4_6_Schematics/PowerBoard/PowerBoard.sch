<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
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
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
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
<library name="My_Library_RADAR">
<packages>
<package name="DDC0006A_N">
<smd name="1" x="-1.375" y="0.95" dx="0.6" dy="1" layer="1" rot="R90"/>
<smd name="2" x="-1.375" y="0" dx="0.6" dy="1" layer="1" rot="R90"/>
<smd name="3" x="-1.375" y="-0.949996875" dx="0.6" dy="1" layer="1" rot="R90"/>
<smd name="4" x="1.375" y="-0.949996875" dx="0.6" dy="1" layer="1" rot="R90"/>
<smd name="5" x="1.375" y="0" dx="0.6" dy="1" layer="1" rot="R90"/>
<smd name="6" x="1.375" y="0.95" dx="0.6" dy="1" layer="1" rot="R90"/>
<wire x1="-1.7526" y1="1.524" x2="0.5588" y2="1.524" width="0.2032" layer="21"/>
<wire x1="-0.7112" y1="-1.524" x2="0.7112" y2="-1.524" width="0.2032" layer="21"/>
<text x="-1.9812" y="2.2098" size="1.27" layer="21" ratio="6" rot="SR0">Designator9</text>
<wire x1="0.7874" y1="-0.7366" x2="0.8128" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.7366" x2="1.4224" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="-1.143" x2="1.4224" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-1.143" x2="0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-1.143" x2="1.4224" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="0.2032" x2="0.8128" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.2032" x2="1.4224" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="-0.1778" x2="1.4224" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-0.1778" x2="0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.1778" x2="1.4224" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="1.1684" x2="0.8128" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="1.1684" x2="1.4224" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="0.762" x2="1.4224" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="0.762" x2="0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.762" x2="1.4224" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-1.143" x2="-0.8382" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-1.143" x2="-0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-1.143" x2="-1.4478" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.7366" x2="-0.8382" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.7366" x2="-0.8128" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.1778" x2="-0.8382" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.1778" x2="-0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.1778" x2="-1.4478" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.2032" x2="-0.8382" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.2032" x2="-0.8128" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.762" x2="-0.8382" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.762" x2="-0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.762" x2="-1.4478" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="1.1684" x2="-0.8382" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="1.1684" x2="-0.8128" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="1.1684" x2="-0.8382" y2="1.4224" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.2032" x2="-0.8382" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.7366" x2="-0.8382" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-1.397" x2="-0.8382" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.762" y1="1.4986" x2="0.7366" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-0.762" y1="-1.4732" x2="0.7366" y2="-1.4732" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="1.1684" x2="0.8128" y2="1.4224" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.2032" x2="0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.7366" x2="0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-1.397" x2="0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.2794" y1="1.016" x2="-0.5842" y2="1.016" width="0.1524" layer="51" curve="-180"/>
<wire x1="-0.5842" y1="1.016" x2="-0.2794" y2="1.016" width="0.1524" layer="51" curve="-180"/>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
</package>
<package name="DDC0006A_M">
<smd name="1" x="-1.475" y="0.95" dx="0.65" dy="1.2" layer="1" rot="R90"/>
<smd name="2" x="-1.475" y="0" dx="0.65" dy="1.2" layer="1" rot="R90"/>
<smd name="3" x="-1.475" y="-0.949996875" dx="0.65" dy="1.2" layer="1" rot="R90"/>
<smd name="4" x="1.474996875" y="-0.949996875" dx="0.65" dy="1.2" layer="1" rot="R90"/>
<smd name="5" x="1.474996875" y="0" dx="0.65" dy="1.2" layer="1" rot="R90"/>
<smd name="6" x="1.474996875" y="0.95" dx="0.65" dy="1.2" layer="1" rot="R90"/>
<wire x1="-0.7112" y1="-1.524" x2="0.7112" y2="-1.524" width="0.2032" layer="21"/>
<wire x1="-1.9304" y1="1.524" x2="0.508" y2="1.524" width="0.2032" layer="21"/>
<text x="-2.413" y="2.4638" size="1.27" layer="21" ratio="6" rot="SR0">Designator9</text>
<wire x1="0.7874" y1="-0.7366" x2="0.8128" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.7366" x2="1.4224" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="-1.143" x2="1.4224" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-1.143" x2="0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-1.143" x2="1.4224" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="0.2032" x2="0.8128" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.2032" x2="1.4224" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="-0.1778" x2="1.4224" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-0.1778" x2="0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.1778" x2="1.4224" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="1.1684" x2="0.8128" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="1.1684" x2="1.4224" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="0.762" x2="1.4224" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="0.762" x2="0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.762" x2="1.4224" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-1.143" x2="-0.8382" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-1.143" x2="-0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-1.143" x2="-1.4478" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.7366" x2="-0.8382" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.7366" x2="-0.8128" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.1778" x2="-0.8382" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.1778" x2="-0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.1778" x2="-1.4478" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.2032" x2="-0.8382" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.2032" x2="-0.8128" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.762" x2="-0.8382" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.762" x2="-0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.762" x2="-1.4478" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="1.1684" x2="-0.8382" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="1.1684" x2="-0.8128" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="1.1684" x2="-0.8382" y2="1.4224" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.2032" x2="-0.8382" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.7366" x2="-0.8382" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-1.397" x2="-0.8382" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.762" y1="1.4986" x2="0.7366" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-0.762" y1="-1.4732" x2="0.7366" y2="-1.4732" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="1.1684" x2="0.8128" y2="1.4224" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.2032" x2="0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.7366" x2="0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-1.397" x2="0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.2794" y1="1.016" x2="-0.5842" y2="1.016" width="0.1524" layer="51" curve="-180"/>
<wire x1="-0.5842" y1="1.016" x2="-0.2794" y2="1.016" width="0.1524" layer="51" curve="-180"/>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
</package>
<package name="DDC0006A_L">
<smd name="1" x="-1.275" y="0.95" dx="0.55" dy="0.8" layer="1" rot="R90"/>
<smd name="2" x="-1.275" y="0" dx="0.55" dy="0.8" layer="1" rot="R90"/>
<smd name="3" x="-1.275" y="-0.949996875" dx="0.55" dy="0.8" layer="1" rot="R90"/>
<smd name="4" x="1.275" y="-0.949996875" dx="0.55" dy="0.8" layer="1" rot="R90"/>
<smd name="5" x="1.275" y="0" dx="0.55" dy="0.8" layer="1" rot="R90"/>
<smd name="6" x="1.275" y="0.95" dx="0.55" dy="0.8" layer="1" rot="R90"/>
<wire x1="-1.6002" y1="1.524" x2="0.4572" y2="1.524" width="0.2032" layer="21"/>
<wire x1="-0.7112" y1="-1.524" x2="0.7112" y2="-1.524" width="0.2032" layer="21"/>
<text x="-1.6256" y="2.0574" size="1.27" layer="21" ratio="6" rot="SR0">Designator9</text>
<wire x1="0.8128" y1="-1.397" x2="0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="-0.7366" x2="0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="0.2032" x2="0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="0.8128" y1="1.1684" x2="0.8128" y2="1.4224" width="0.1524" layer="51"/>
<wire x1="-0.762" y1="-1.4732" x2="0.7366" y2="-1.4732" width="0.1524" layer="51"/>
<wire x1="-0.762" y1="1.4986" x2="0.7366" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-1.397" x2="-0.8382" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="-0.7366" x2="-0.8382" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="0.2032" x2="-0.8382" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-0.8382" y1="1.1684" x2="-0.8382" y2="1.4224" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="1.1684" x2="-0.8128" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.762" x2="-0.8128" y2="0.762" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.762" x2="-1.4478" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="0.2032" x2="-0.8128" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.1778" x2="-0.8128" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.1778" x2="-1.4478" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-0.7366" x2="-0.8128" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-1.143" x2="-0.8128" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="-1.4478" y1="-1.143" x2="-1.4478" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="0.762" x2="1.4224" y2="0.762" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="1.1684" x2="1.4224" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="0.762" x2="1.4224" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-0.1778" x2="1.4224" y2="-0.1778" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="0.2032" x2="1.4224" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="-0.1778" x2="1.4224" y2="0.2032" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-1.143" x2="1.4224" y2="-1.143" width="0.1524" layer="51"/>
<wire x1="0.7874" y1="-0.7366" x2="1.4224" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="1.4224" y1="-1.143" x2="1.4224" y2="-0.7366" width="0.1524" layer="51"/>
<wire x1="-0.5842" y1="1.016" x2="-0.2794" y2="1.016" width="0.1524" layer="51" curve="-180"/>
<wire x1="-0.2794" y1="1.016" x2="-0.5842" y2="1.016" width="0.1524" layer="51" curve="-180"/>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
</package>
<package name="IND_VLP8040T-1R0N_TDK">
<smd name="1" x="-2.35" y="0" dx="3.302" dy="8.2042" layer="1"/>
<smd name="2" x="2.35" y="0" dx="3.302" dy="8.2042" layer="1"/>
<wire x1="-2.3622" y1="0" x2="-2.3622" y2="-6.8834" width="0.1524" layer="48"/>
<wire x1="2.3622" y1="0" x2="2.3622" y2="-6.8834" width="0.1524" layer="48"/>
<wire x1="4.318" y1="4.3434" x2="6.858" y2="4.3434" width="0.1524" layer="48"/>
<wire x1="4.318" y1="-4.3434" x2="6.858" y2="-4.3434" width="0.1524" layer="48"/>
<wire x1="-4.318" y1="-4.3434" x2="-4.318" y2="-9.4234" width="0.1524" layer="48"/>
<wire x1="4.318" y1="-4.3434" x2="4.318" y2="-9.4234" width="0.1524" layer="48"/>
<text x="-16.3576" y="-13.2334" size="1.27" layer="48" ratio="6" rot="SR0">Default Padstyle: RX130Y323D0T</text>
<text x="-14.8082" y="-15.1384" size="1.27" layer="48" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-17.0434" size="1.27" layer="48" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-3.4544" y="-8.0264" size="0.635" layer="48" ratio="4" rot="SR0">0.185in/4.7mm</text>
<text x="7.366" y="4.0132" size="0.635" layer="48" ratio="4" rot="SR0">0.342in/8.687mm</text>
<text x="-4.0386" y="-10.5664" size="0.635" layer="48" ratio="4" rot="SR0">0.339in/8.611mm</text>
<text x="-5.8928" y="-1.27" size="1.27" layer="21" ratio="6" rot="SR0">*</text>
<text x="-4.3688" y="-1.27" size="1.27" layer="51" ratio="6" rot="SR0">*</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
<wire x1="-2.3622" y1="-6.8834" x2="-2.3622" y2="-7.2644" width="0.1524" layer="48"/>
<wire x1="2.3622" y1="-6.8834" x2="2.3622" y2="-7.2644" width="0.1524" layer="48"/>
<wire x1="-2.3622" y1="-6.8834" x2="2.3622" y2="-6.8834" width="0.1524" layer="48"/>
<wire x1="-2.3622" y1="-6.8834" x2="-2.1082" y2="-6.7564" width="0.1524" layer="48"/>
<wire x1="-2.3622" y1="-6.8834" x2="-2.1082" y2="-7.0104" width="0.1524" layer="48"/>
<wire x1="-2.1082" y1="-6.7564" x2="-2.1082" y2="-7.0104" width="0.1524" layer="48"/>
<wire x1="2.3622" y1="-6.8834" x2="2.1082" y2="-6.7564" width="0.1524" layer="48"/>
<wire x1="2.3622" y1="-6.8834" x2="2.1082" y2="-7.0104" width="0.1524" layer="48"/>
<wire x1="2.1082" y1="-6.7564" x2="2.1082" y2="-7.0104" width="0.1524" layer="48"/>
<wire x1="6.858" y1="4.3434" x2="7.2136" y2="4.3434" width="0.1524" layer="48"/>
<wire x1="6.858" y1="-4.3434" x2="7.2136" y2="-4.3434" width="0.1524" layer="48"/>
<wire x1="6.858" y1="4.3434" x2="6.858" y2="-4.3434" width="0.1524" layer="48"/>
<wire x1="6.858" y1="4.3434" x2="6.7056" y2="4.0894" width="0.1524" layer="48"/>
<wire x1="6.858" y1="4.3434" x2="6.9596" y2="4.0894" width="0.1524" layer="48"/>
<wire x1="6.7056" y1="4.0894" x2="6.9596" y2="4.0894" width="0.1524" layer="48"/>
<wire x1="6.858" y1="-4.3434" x2="6.7056" y2="-4.0894" width="0.1524" layer="48"/>
<wire x1="6.858" y1="-4.3434" x2="6.9596" y2="-4.0894" width="0.1524" layer="48"/>
<wire x1="6.7056" y1="-4.0894" x2="6.9596" y2="-4.0894" width="0.1524" layer="48"/>
<wire x1="-4.318" y1="-9.4234" x2="-4.318" y2="-9.8044" width="0.1524" layer="48"/>
<wire x1="4.318" y1="-9.4234" x2="4.318" y2="-9.8044" width="0.1524" layer="48"/>
<wire x1="-4.318" y1="-9.4234" x2="4.318" y2="-9.4234" width="0.1524" layer="48"/>
<wire x1="-4.318" y1="-9.4234" x2="-4.064" y2="-9.2964" width="0.1524" layer="48"/>
<wire x1="-4.318" y1="-9.4234" x2="-4.064" y2="-9.5504" width="0.1524" layer="48"/>
<wire x1="-4.064" y1="-9.2964" x2="-4.064" y2="-9.5504" width="0.1524" layer="48"/>
<wire x1="4.318" y1="-9.4234" x2="4.064" y2="-9.2964" width="0.1524" layer="48"/>
<wire x1="4.318" y1="-9.4234" x2="4.064" y2="-9.5504" width="0.1524" layer="48"/>
<wire x1="4.064" y1="-9.2964" x2="4.064" y2="-9.5504" width="0.1524" layer="48"/>
<text x="-16.3576" y="-13.2334" size="1.27" layer="48" ratio="6" rot="SR0">Default Padstyle: RX130Y323D0T</text>
<text x="-14.8082" y="-15.1384" size="1.27" layer="48" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-17.0434" size="1.27" layer="48" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-3.4544" y="-8.0264" size="0.635" layer="48" ratio="4" rot="SR0">0.185in/4.7mm</text>
<text x="7.366" y="4.0132" size="0.635" layer="48" ratio="4" rot="SR0">0.342in/8.687mm</text>
<text x="-4.0386" y="-10.5664" size="0.635" layer="48" ratio="4" rot="SR0">0.339in/8.611mm</text>
<wire x1="-4.4196" y1="2.286" x2="-4.4196" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="-4.4704" x2="2.286" y2="-4.4704" width="0.1524" layer="21"/>
<wire x1="4.4196" y1="-2.286" x2="4.4196" y2="2.286" width="0.1524" layer="21"/>
<wire x1="2.286" y1="4.4704" x2="-2.286" y2="4.4704" width="0.1524" layer="21"/>
<text x="-5.8928" y="-1.27" size="1.27" layer="21" ratio="6" rot="SR0">*</text>
<wire x1="-2.159" y1="4.3434" x2="-4.318" y2="2.1844" width="0.1524" layer="51"/>
<wire x1="-4.318" y1="2.1844" x2="-4.318" y2="-2.1844" width="0.1524" layer="51"/>
<wire x1="-4.318" y1="-2.1844" x2="-2.159" y2="-4.3434" width="0.1524" layer="51"/>
<wire x1="-2.159" y1="-4.3434" x2="2.159" y2="-4.3434" width="0.1524" layer="51"/>
<wire x1="2.159" y1="-4.3434" x2="4.318" y2="-2.1844" width="0.1524" layer="51"/>
<wire x1="4.318" y1="-2.1844" x2="4.318" y2="2.1844" width="0.1524" layer="51"/>
<wire x1="4.318" y1="2.1844" x2="2.159" y2="4.3434" width="0.1524" layer="51"/>
<wire x1="2.159" y1="4.3434" x2="-2.159" y2="4.3434" width="0.1524" layer="51"/>
<text x="-4.3688" y="-1.27" size="1.27" layer="51" ratio="6" rot="SR0">*</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
<package name="CP_8_11_ADI">
<smd name="1" x="-1.4024" y="0.75" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="2" x="-1.4024" y="0.25" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="3" x="-1.4024" y="-0.25" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="4" x="-1.4024" y="-0.75" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="5" x="1.4024" y="-0.75" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="6" x="1.4024" y="-0.25" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="7" x="1.4024" y="0.25" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="8" x="1.4024" y="0.75" dx="0.8048" dy="0.2492" layer="1"/>
<smd name="9" x="0" y="0" dx="1.7" dy="2.44" layer="1"/>
<wire x1="-1.4986" y1="0.762" x2="-1.4986" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.4986" y2="7.112" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.4986" y2="7.493" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="0.762" x2="1.4986" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="1.4986" x2="1.4986" y2="7.112" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.4986" y2="7.493" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-2.7686" y2="7.112" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="2.7686" y2="7.112" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.7526" y2="7.239" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="7.239" x2="-1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.7526" y2="7.239" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="1.7526" y1="7.239" x2="1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="0.762" x2="-0.9906" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.9906" y2="3.683" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-2.7686" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="0.2794" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.7526" y2="3.429" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.7526" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="3.429" x2="-1.7526" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.7366" y2="3.429" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.7366" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-0.7366" y1="3.429" x2="-0.7366" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-1.397" y1="0.762" x2="-3.937" y2="0.762" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.762" x2="-4.318" y2="0.762" width="0.1524" layer="48"/>
<wire x1="-1.397" y1="0.254" x2="-3.937" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.254" x2="-4.318" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.762" x2="-3.937" y2="2.032" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.254" x2="-3.937" y2="-1.016" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.762" x2="-4.064" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.762" x2="-3.81" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-4.064" y1="1.016" x2="-3.81" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.254" x2="-4.064" y2="0" width="0.1524" layer="48"/>
<wire x1="-3.937" y1="0.254" x2="-3.81" y2="0" width="0.1524" layer="48"/>
<wire x1="-4.064" y1="0" x2="-3.81" y2="0" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="1.4986" x2="3.937" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="3.937" y1="1.4986" x2="4.318" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-1.4986" x2="3.937" y2="-1.4986" width="0.1524" layer="48"/>
<wire x1="3.937" y1="-1.4986" x2="4.318" y2="-1.4986" width="0.1524" layer="48"/>
<wire x1="3.937" y1="1.4986" x2="3.937" y2="2.7686" width="0.1524" layer="48"/>
<wire x1="3.937" y1="-1.4986" x2="3.937" y2="-2.7686" width="0.1524" layer="48"/>
<wire x1="3.937" y1="1.4986" x2="3.81" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.937" y1="1.4986" x2="4.064" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.81" y1="1.7526" x2="4.064" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.937" y1="-1.4986" x2="3.81" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="3.937" y1="-1.4986" x2="4.064" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="3.81" y1="-1.7526" x2="4.064" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-1.4986" x2="-1.4986" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.4986" y2="-4.4196" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-1.4986" x2="1.4986" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.4986" y2="-4.4196" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-2.7686" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="2.7686" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.7526" y2="-3.9116" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="-3.9116" x2="-1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.7526" y2="-3.9116" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="1.7526" y1="-3.9116" x2="1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<text x="-18.0848" y="-10.8966" size="1.27" layer="48" ratio="6" rot="SR0">Default Padstyle: RX31p69Y9p81D0T</text>
<text x="-19.6088" y="-12.4206" size="1.27" layer="48" ratio="6" rot="SR0">Heat Tab Padstyle: RX66p93Y96p06D0T</text>
<text x="-14.8082" y="-15.4686" size="1.27" layer="48" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-16.9926" size="1.27" layer="48" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-2.9718" y="7.62" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<text x="-4.4196" y="3.81" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="-10.795" y="0.1778" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="4.445" y="-0.3048" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<text x="-2.9718" y="-5.1816" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<wire x1="-1.6256" y1="-1.6256" x2="1.6256" y2="-1.6256" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="-1.6256" x2="1.6256" y2="-1.2192" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="1.6256" x2="-1.6256" y2="1.6256" width="0.1524" layer="21"/>
<wire x1="-1.6256" y1="1.6256" x2="-1.6256" y2="1.2192" width="0.1524" layer="21"/>
<wire x1="-1.6256" y1="-1.2192" x2="-1.6256" y2="-1.6256" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="1.2192" x2="1.6256" y2="1.6256" width="0.1524" layer="21"/>
<wire x1="-2.1336" y1="0.6858" x2="-2.1336" y2="0.8128" width="0.1524" layer="21" curve="-209"/>
<wire x1="-1.4986" y1="-1.4986" x2="1.4986" y2="-1.4986" width="0.1524" layer="51"/>
<wire x1="1.4986" y1="-1.4986" x2="1.4986" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="1.4986" y1="1.4986" x2="0.3048" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="1.4986" x2="-0.3048" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-0.3048" y1="1.4986" x2="-1.4986" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-1.4986" y1="1.4986" x2="-1.4986" y2="-1.4986" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="1.4986" x2="-0.3048" y2="1.4986" width="0.1524" layer="51" curve="-180"/>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
<package name="CP_8_11_ADI-M">
<smd name="1" x="-1.4532" y="0.75" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="2" x="-1.4532" y="0.25" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="3" x="-1.4532" y="-0.25" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="4" x="-1.4532" y="-0.75" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="5" x="1.4532" y="-0.75" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="6" x="1.4532" y="-0.25" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="7" x="1.4532" y="0.25" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="8" x="1.4532" y="0.75" dx="0.9064" dy="0.2492" layer="1"/>
<smd name="9" x="0" y="0" dx="1.7" dy="2.44" layer="1"/>
<wire x1="-1.4986" y1="0.762" x2="-1.4986" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.4986" y2="7.112" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.4986" y2="7.493" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="0.762" x2="1.4986" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="1.4986" x2="1.4986" y2="7.112" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.4986" y2="7.493" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-2.7686" y2="7.112" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="2.7686" y2="7.112" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.7526" y2="7.239" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="7.239" x2="-1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.7526" y2="7.239" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="1.7526" y1="7.239" x2="1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="0.762" x2="-0.9906" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.9906" y2="3.683" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-2.7686" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="0.2794" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.7526" y2="3.429" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.7526" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="3.429" x2="-1.7526" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.7366" y2="3.429" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.7366" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-0.7366" y1="3.429" x2="-0.7366" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-1.4478" y1="0.762" x2="-3.9878" y2="0.762" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.762" x2="-4.3688" y2="0.762" width="0.1524" layer="48"/>
<wire x1="-1.4478" y1="0.254" x2="-3.9878" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.254" x2="-4.3688" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.762" x2="-3.9878" y2="2.032" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.254" x2="-3.9878" y2="-1.016" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.762" x2="-4.1148" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.762" x2="-3.8608" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-4.1148" y1="1.016" x2="-3.8608" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.254" x2="-4.1148" y2="0" width="0.1524" layer="48"/>
<wire x1="-3.9878" y1="0.254" x2="-3.8608" y2="0" width="0.1524" layer="48"/>
<wire x1="-4.1148" y1="0" x2="-3.8608" y2="0" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="1.4986" x2="3.9878" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="1.4986" x2="4.3688" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-1.4986" x2="3.9878" y2="-1.4986" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="-1.4986" x2="4.3688" y2="-1.4986" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="1.4986" x2="3.9878" y2="2.7686" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="-1.4986" x2="3.9878" y2="-2.7686" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="1.4986" x2="3.8608" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="1.4986" x2="4.1148" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.8608" y1="1.7526" x2="4.1148" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="-1.4986" x2="3.8608" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="3.9878" y1="-1.4986" x2="4.1148" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="3.8608" y1="-1.7526" x2="4.1148" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-1.4986" x2="-1.4986" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.4986" y2="-4.4196" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-1.4986" x2="1.4986" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.4986" y2="-4.4196" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-2.7686" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="2.7686" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.7526" y2="-3.9116" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="-3.9116" x2="-1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.7526" y2="-3.9116" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="1.7526" y1="-3.9116" x2="1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<text x="-18.0848" y="-10.8966" size="1.27" layer="48" ratio="6" rot="SR0">Default Padstyle: RX35p69Y9p81D0T</text>
<text x="-19.6088" y="-12.4206" size="1.27" layer="48" ratio="6" rot="SR0">Heat Tab Padstyle: RX66p93Y96p06D0T</text>
<text x="-14.8082" y="-15.4686" size="1.27" layer="48" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-16.9926" size="1.27" layer="48" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-2.9718" y="7.62" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<text x="-4.4196" y="3.81" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="-10.8458" y="0.1778" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="4.4958" y="-0.3048" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<text x="-2.9718" y="-5.1816" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<wire x1="-1.6256" y1="-1.6256" x2="1.6256" y2="-1.6256" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="-1.6256" x2="1.6256" y2="-1.2192" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="1.6256" x2="-1.6256" y2="1.6256" width="0.1524" layer="21"/>
<wire x1="-1.6256" y1="1.6256" x2="-1.6256" y2="1.2192" width="0.1524" layer="21"/>
<wire x1="-1.6256" y1="-1.2192" x2="-1.6256" y2="-1.6256" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="1.2192" x2="1.6256" y2="1.6256" width="0.1524" layer="21"/>
<wire x1="-1.4986" y1="-1.4986" x2="1.4986" y2="-1.4986" width="0.1524" layer="51"/>
<wire x1="1.4986" y1="-1.4986" x2="1.4986" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="1.4986" y1="1.4986" x2="0.3048" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="1.4986" x2="-0.3048" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-0.3048" y1="1.4986" x2="-1.4986" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-1.4986" y1="1.4986" x2="-1.4986" y2="-1.4986" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="1.4986" x2="-0.3048" y2="1.4986" width="0.1524" layer="51" curve="-180"/>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
<package name="CP_8_11_ADI-L">
<smd name="1" x="-1.3516" y="0.75" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="2" x="-1.3516" y="0.25" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="3" x="-1.3516" y="-0.25" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="4" x="-1.3516" y="-0.75" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="5" x="1.3516" y="-0.75" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="6" x="1.3516" y="-0.25" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="7" x="1.3516" y="0.25" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="8" x="1.3516" y="0.75" dx="0.7032" dy="0.2492" layer="1"/>
<smd name="9" x="0" y="0" dx="1.7" dy="2.44" layer="1"/>
<wire x1="-1.4986" y1="0.762" x2="-1.4986" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.4986" y2="7.112" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.4986" y2="7.493" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="0.762" x2="1.4986" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="1.4986" x2="1.4986" y2="7.112" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.4986" y2="7.493" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-2.7686" y2="7.112" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="2.7686" y2="7.112" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.7526" y2="7.239" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="7.112" x2="-1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="7.239" x2="-1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.7526" y2="7.239" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="7.112" x2="1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="1.7526" y1="7.239" x2="1.7526" y2="6.985" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="0.762" x2="-0.9906" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.9906" y2="3.683" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-2.7686" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="0.2794" y2="3.302" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.7526" y2="3.429" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="3.302" x2="-1.7526" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="3.429" x2="-1.7526" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.7366" y2="3.429" width="0.1524" layer="48"/>
<wire x1="-0.9906" y1="3.302" x2="-0.7366" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-0.7366" y1="3.429" x2="-0.7366" y2="3.175" width="0.1524" layer="48"/>
<wire x1="-1.3462" y1="0.762" x2="-3.8862" y2="0.762" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.762" x2="-4.2672" y2="0.762" width="0.1524" layer="48"/>
<wire x1="-1.3462" y1="0.254" x2="-3.8862" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.254" x2="-4.2672" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.762" x2="-3.8862" y2="2.032" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.254" x2="-3.8862" y2="-1.016" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.762" x2="-4.0132" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.762" x2="-3.7592" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-4.0132" y1="1.016" x2="-3.7592" y2="1.016" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.254" x2="-4.0132" y2="0" width="0.1524" layer="48"/>
<wire x1="-3.8862" y1="0.254" x2="-3.7592" y2="0" width="0.1524" layer="48"/>
<wire x1="-4.0132" y1="0" x2="-3.7592" y2="0" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="1.4986" x2="3.8862" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="1.4986" x2="4.2672" y2="1.4986" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-1.4986" x2="3.8862" y2="-1.4986" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="-1.4986" x2="4.2672" y2="-1.4986" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="1.4986" x2="3.8862" y2="2.7686" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="-1.4986" x2="3.8862" y2="-2.7686" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="1.4986" x2="3.7592" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="1.4986" x2="4.0132" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.7592" y1="1.7526" x2="4.0132" y2="1.7526" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="-1.4986" x2="3.7592" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="3.8862" y1="-1.4986" x2="4.0132" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="3.7592" y1="-1.7526" x2="4.0132" y2="-1.7526" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-1.4986" x2="-1.4986" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.4986" y2="-4.4196" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-1.4986" x2="1.4986" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.4986" y2="-4.4196" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-2.7686" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="2.7686" y2="-4.0386" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.7526" y2="-3.9116" width="0.1524" layer="48"/>
<wire x1="-1.4986" y1="-4.0386" x2="-1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="-1.7526" y1="-3.9116" x2="-1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.7526" y2="-3.9116" width="0.1524" layer="48"/>
<wire x1="1.4986" y1="-4.0386" x2="1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<wire x1="1.7526" y1="-3.9116" x2="1.7526" y2="-4.1656" width="0.1524" layer="48"/>
<text x="-18.0848" y="-10.8966" size="1.27" layer="48" ratio="6" rot="SR0">Default Padstyle: RX27p69Y9p81D0T</text>
<text x="-19.6088" y="-12.4206" size="1.27" layer="48" ratio="6" rot="SR0">Heat Tab Padstyle: RX66p93Y96p06D0T</text>
<text x="-14.8082" y="-15.4686" size="1.27" layer="48" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-16.9926" size="1.27" layer="48" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-2.9718" y="7.62" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<text x="-4.4196" y="3.81" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="-10.7442" y="0.1778" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="4.3942" y="-0.3048" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<text x="-2.9718" y="-5.1816" size="0.635" layer="48" ratio="4" rot="SR0">0.118in/3mm</text>
<wire x1="-1.6256" y1="-1.6256" x2="1.6256" y2="-1.6256" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="-1.6256" x2="1.6256" y2="-1.2192" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="1.6256" x2="-1.6256" y2="1.6256" width="0.1524" layer="21"/>
<wire x1="-1.6256" y1="1.6256" x2="-1.6256" y2="1.2192" width="0.1524" layer="21"/>
<wire x1="-1.6256" y1="-1.2192" x2="-1.6256" y2="-1.6256" width="0.1524" layer="21"/>
<wire x1="1.6256" y1="1.2192" x2="1.6256" y2="1.6256" width="0.1524" layer="21"/>
<wire x1="-1.4986" y1="-1.4986" x2="1.4986" y2="-1.4986" width="0.1524" layer="51"/>
<wire x1="1.4986" y1="-1.4986" x2="1.4986" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="1.4986" y1="1.4986" x2="0.3048" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="1.4986" x2="-0.3048" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-0.3048" y1="1.4986" x2="-1.4986" y2="1.4986" width="0.1524" layer="51"/>
<wire x1="-1.4986" y1="1.4986" x2="-1.4986" y2="-1.4986" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="1.4986" x2="-0.3048" y2="1.4986" width="0.1524" layer="51" curve="-180"/>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
<package name="RGR20_2P05X2P05_TEX">
<smd name="1" x="-1.725" y="1" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="2" x="-1.725" y="0.5" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="3" x="-1.725" y="0" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="4" x="-1.725" y="-0.5" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="5" x="-1.725" y="-1" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="6" x="-1.000253125" y="-1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="7" x="-0.500125" y="-1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="8" x="0" y="-1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="9" x="0.500125" y="-1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="10" x="1.000253125" y="-1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="11" x="1.725" y="-1" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="12" x="1.725" y="-0.5" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="13" x="1.725" y="0" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="14" x="1.725" y="0.5" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="15" x="1.725" y="1" dx="0.28" dy="0.85" layer="1" rot="R270"/>
<smd name="16" x="1.000253125" y="1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="17" x="0.500125" y="1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="18" x="0" y="1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="19" x="-0.500125" y="1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="20" x="-1.000253125" y="1.725" dx="0.28" dy="0.85" layer="1" rot="R180"/>
<smd name="21" x="0" y="0" dx="2.05" dy="2.05" layer="1" cream="no"/>
<pad name="V" x="-0.4064" y="-0.4064" drill="0.254" diameter="0.508"/>
<pad name="V_1" x="-0.4064" y="0.4064" drill="0.254" diameter="0.508"/>
<pad name="V_2" x="0.4064" y="-0.4064" drill="0.254" diameter="0.508"/>
<pad name="V_3" x="0.4064" y="0.4064" drill="0.254" diameter="0.508"/>
<wire x1="-2.2098" y1="-2.2098" x2="-1.4732" y2="-2.2098" width="0.1524" layer="21"/>
<wire x1="2.2098" y1="-2.2098" x2="2.2098" y2="-1.4732" width="0.1524" layer="21"/>
<wire x1="2.2098" y1="2.2098" x2="1.4732" y2="2.2098" width="0.1524" layer="21"/>
<wire x1="-2.2098" y1="2.2098" x2="-2.2098" y2="1.4732" width="0.1524" layer="21"/>
<wire x1="-2.2098" y1="-1.4732" x2="-2.2098" y2="-2.2098" width="0.1524" layer="21"/>
<wire x1="1.4732" y1="-2.2098" x2="2.2098" y2="-2.2098" width="0.1524" layer="21"/>
<wire x1="2.2098" y1="1.4732" x2="2.2098" y2="2.2098" width="0.1524" layer="21"/>
<wire x1="-1.4732" y1="2.2098" x2="-2.2098" y2="2.2098" width="0.1524" layer="21"/>
<polygon width="0.0254" layer="21">
<vertex x="0.809753125" y="-2.404"/>
<vertex x="0.809753125" y="-2.658"/>
<vertex x="1.190753125" y="-2.658"/>
<vertex x="1.190753125" y="-2.404"/>
</polygon>
<polygon width="0.0254" layer="21">
<vertex x="-1.190753125" y="2.404"/>
<vertex x="-1.190753125" y="2.658"/>
<vertex x="-0.809753125" y="2.658"/>
<vertex x="-0.809753125" y="2.404"/>
</polygon>
<text x="-3.3528" y="0.9906" size="1.27" layer="21" ratio="6" rot="SR0">*</text>
<polygon width="0.0254" layer="31">
<vertex x="-0.95006875" y="0.95006875"/>
<vertex x="-0.95006875" y="0.4937"/>
<vertex x="-0.635121875" y="0.4937"/>
<vertex x="-0.4937" y="0.635121875"/>
<vertex x="-0.4937" y="0.95006875"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="-0.95006875" y="0.2937"/>
<vertex x="-0.95006875" y="-0.2937"/>
<vertex x="-0.635121875" y="-0.2937"/>
<vertex x="-0.4937" y="-0.152278125"/>
<vertex x="-0.4937" y="0.152278125"/>
<vertex x="-0.635121875" y="0.2937"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="-0.95006875" y="-0.4937"/>
<vertex x="-0.95006875" y="-0.95006875"/>
<vertex x="-0.4937" y="-0.95006875"/>
<vertex x="-0.4937" y="-0.635121875"/>
<vertex x="-0.635121875" y="-0.4937"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="-0.2937" y="0.95006875"/>
<vertex x="-0.2937" y="0.635121875"/>
<vertex x="-0.152278125" y="0.4937"/>
<vertex x="0.152278125" y="0.4937"/>
<vertex x="0.2937" y="0.635121875"/>
<vertex x="0.2937" y="0.95006875"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="-0.152278125" y="0.2937"/>
<vertex x="-0.2937" y="0.152278125"/>
<vertex x="-0.2937" y="-0.152278125"/>
<vertex x="-0.152278125" y="-0.2937"/>
<vertex x="0.152278125" y="-0.2937"/>
<vertex x="0.2937" y="-0.152278125"/>
<vertex x="0.2937" y="0.152278125"/>
<vertex x="0.152278125" y="0.2937"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="-0.152278125" y="-0.4937"/>
<vertex x="-0.2937" y="-0.635121875"/>
<vertex x="-0.2937" y="-0.95006875"/>
<vertex x="0.2937" y="-0.95006875"/>
<vertex x="0.2937" y="-0.635121875"/>
<vertex x="0.152278125" y="-0.4937"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="0.4937" y="0.95006875"/>
<vertex x="0.4937" y="0.635121875"/>
<vertex x="0.635121875" y="0.4937"/>
<vertex x="0.95006875" y="0.4937"/>
<vertex x="0.95006875" y="0.95006875"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="0.635121875" y="0.2937"/>
<vertex x="0.4937" y="0.152278125"/>
<vertex x="0.4937" y="-0.152278125"/>
<vertex x="0.635121875" y="-0.2937"/>
<vertex x="0.95006875" y="-0.2937"/>
<vertex x="0.95006875" y="0.2937"/>
</polygon>
<polygon width="0.0254" layer="31">
<vertex x="0.635121875" y="-0.4937"/>
<vertex x="0.4937" y="-0.635121875"/>
<vertex x="0.4937" y="-0.95006875"/>
<vertex x="0.95006875" y="-0.95006875"/>
<vertex x="0.95006875" y="-0.4937"/>
</polygon>
<polygon width="0.0254" layer="29">
<vertex x="-1.0885" y="1.0885"/>
<vertex x="1.0885" y="1.0885"/>
<vertex x="1.0885" y="0.5937"/>
<vertex x="-1.0885" y="0.5937"/>
</polygon>
<polygon width="0.0254" layer="29">
<vertex x="-1.0885" y="0.1937"/>
<vertex x="1.0885" y="0.1937"/>
<vertex x="1.0885" y="-0.1937"/>
<vertex x="-1.0885" y="-0.1937"/>
</polygon>
<polygon width="0.0254" layer="29">
<vertex x="-1.0885" y="-0.5937"/>
<vertex x="1.0885" y="-0.5937"/>
<vertex x="1.0885" y="-1.0885"/>
<vertex x="-1.0885" y="-1.0885"/>
</polygon>
<polygon width="0.0254" layer="29">
<vertex x="-1.0885" y="1.0885"/>
<vertex x="-0.5937" y="1.0885"/>
<vertex x="-0.5937" y="-1.0885"/>
<vertex x="-1.0885" y="-1.0885"/>
</polygon>
<polygon width="0.0254" layer="29">
<vertex x="0.1937" y="1.0885"/>
<vertex x="-0.1937" y="1.0885"/>
<vertex x="-0.1937" y="-1.0885"/>
<vertex x="0.1937" y="-1.0885"/>
</polygon>
<polygon width="0.0254" layer="29">
<vertex x="0.5937" y="1.0885"/>
<vertex x="1.0885" y="1.0885"/>
<vertex x="1.0885" y="-1.0885"/>
<vertex x="0.5937" y="-1.0885"/>
</polygon>
<wire x1="1.7272" y1="0.9906" x2="4.5466" y2="0.9906" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.9906" x2="4.9276" y2="0.9906" width="0.1524" layer="48"/>
<wire x1="1.7272" y1="0.508" x2="4.5466" y2="0.508" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.508" x2="4.9276" y2="0.508" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.9906" x2="4.5466" y2="2.2606" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.508" x2="4.5466" y2="-0.762" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.9906" x2="4.4196" y2="1.2446" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.9906" x2="4.6736" y2="1.2446" width="0.1524" layer="48"/>
<wire x1="4.4196" y1="1.2446" x2="4.6736" y2="1.2446" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.508" x2="4.4196" y2="0.254" width="0.1524" layer="48"/>
<wire x1="4.5466" y1="0.508" x2="4.6736" y2="0.254" width="0.1524" layer="48"/>
<wire x1="4.4196" y1="0.254" x2="4.6736" y2="0.254" width="0.1524" layer="48"/>
<wire x1="-1.7272" y1="0.9906" x2="-1.7272" y2="6.4516" width="0.1524" layer="48"/>
<wire x1="-1.7272" y1="6.4516" x2="-1.7272" y2="6.8326" width="0.1524" layer="48"/>
<wire x1="1.7272" y1="0.9906" x2="1.7272" y2="6.4516" width="0.1524" layer="48"/>
<wire x1="1.7272" y1="6.4516" x2="1.7272" y2="6.8326" width="0.1524" layer="48"/>
<wire x1="-1.7272" y1="6.4516" x2="-2.9972" y2="6.4516" width="0.1524" layer="48"/>
<wire x1="1.7272" y1="6.4516" x2="2.9972" y2="6.4516" width="0.1524" layer="48"/>
<wire x1="-1.7272" y1="6.4516" x2="-1.9812" y2="6.5786" width="0.1524" layer="48"/>
<wire x1="-1.7272" y1="6.4516" x2="-1.9812" y2="6.3246" width="0.1524" layer="48"/>
<wire x1="-1.9812" y1="6.5786" x2="-1.9812" y2="6.3246" width="0.1524" layer="48"/>
<wire x1="1.7272" y1="6.4516" x2="1.9812" y2="6.5786" width="0.1524" layer="48"/>
<wire x1="1.7272" y1="6.4516" x2="1.9812" y2="6.3246" width="0.1524" layer="48"/>
<wire x1="1.9812" y1="6.5786" x2="1.9812" y2="6.3246" width="0.1524" layer="48"/>
<wire x1="0.9906" y1="1.7272" x2="6.4516" y2="1.7272" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="1.7272" x2="6.8326" y2="1.7272" width="0.1524" layer="48"/>
<wire x1="0.9906" y1="-1.7272" x2="6.4516" y2="-1.7272" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="-1.7272" x2="6.8326" y2="-1.7272" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="1.7272" x2="6.4516" y2="2.9972" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="-1.7272" x2="6.4516" y2="-2.9972" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="1.7272" x2="6.3246" y2="1.9812" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="1.7272" x2="6.5786" y2="1.9812" width="0.1524" layer="48"/>
<wire x1="6.3246" y1="1.9812" x2="6.5786" y2="1.9812" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="-1.7272" x2="6.3246" y2="-1.9812" width="0.1524" layer="48"/>
<wire x1="6.4516" y1="-1.7272" x2="6.5786" y2="-1.9812" width="0.1524" layer="48"/>
<wire x1="6.3246" y1="-1.9812" x2="6.5786" y2="-1.9812" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="1.8288" x2="-1.8288" y2="1.8288" width="0.1524" layer="48"/>
<wire x1="-1.8288" y1="1.8288" x2="-5.1816" y2="1.8288" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="1.8288" x2="-5.5626" y2="1.8288" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="-1.8288" x2="-5.1816" y2="-1.8288" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="-1.8288" x2="-5.5626" y2="-1.8288" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="1.8288" x2="-5.1816" y2="3.0988" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="-1.8288" x2="-5.1816" y2="-3.0988" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="1.8288" x2="-5.3086" y2="2.0828" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="1.8288" x2="-5.0546" y2="2.0828" width="0.1524" layer="48"/>
<wire x1="-5.3086" y1="2.0828" x2="-5.0546" y2="2.0828" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="-1.8288" x2="-5.3086" y2="-2.0828" width="0.1524" layer="48"/>
<wire x1="-5.1816" y1="-1.8288" x2="-5.0546" y2="-2.0828" width="0.1524" layer="48"/>
<wire x1="-5.3086" y1="-2.0828" x2="-5.0546" y2="-2.0828" width="0.1524" layer="48"/>
<wire x1="-1.8288" y1="1.8288" x2="-1.8288" y2="-5.1816" width="0.1524" layer="48"/>
<wire x1="-1.8288" y1="-5.1816" x2="-1.8288" y2="-5.5626" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="1.8288" x2="1.8288" y2="-5.1816" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="-5.1816" x2="1.8288" y2="-5.5626" width="0.1524" layer="48"/>
<wire x1="-1.8288" y1="-5.1816" x2="-3.0988" y2="-5.1816" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="-5.1816" x2="3.0988" y2="-5.1816" width="0.1524" layer="48"/>
<wire x1="-1.8288" y1="-5.1816" x2="-2.0828" y2="-5.0546" width="0.1524" layer="48"/>
<wire x1="-1.8288" y1="-5.1816" x2="-2.0828" y2="-5.3086" width="0.1524" layer="48"/>
<wire x1="-2.0828" y1="-5.0546" x2="-2.0828" y2="-5.3086" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="-5.1816" x2="2.0828" y2="-5.0546" width="0.1524" layer="48"/>
<wire x1="1.8288" y1="-5.1816" x2="2.0828" y2="-5.3086" width="0.1524" layer="48"/>
<wire x1="2.0828" y1="-5.0546" x2="2.0828" y2="-5.3086" width="0.1524" layer="48"/>
<text x="-18.669" y="-8.3566" size="1.27" layer="48" ratio="6" rot="SR0">Default Padstyle: RX11p02Y33p46D0T</text>
<text x="-19.6088" y="-9.8806" size="1.27" layer="48" ratio="6" rot="SR0">Heat Tab Padstyle: RX80p71Y80p71D0T</text>
<text x="-13.843" y="-11.4046" size="1.27" layer="48" ratio="6" rot="SR0">Via Padstyle: EX20Y20D10P</text>
<text x="-14.8082" y="-12.9286" size="1.27" layer="48" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-14.4526" size="1.27" layer="48" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="5.0546" y="0.4318" size="0.635" layer="48" ratio="4" rot="SR0">0.02in/0.5mm</text>
<text x="-3.7592" y="6.9596" size="0.635" layer="48" ratio="4" rot="SR0">0.136in/3.45mm</text>
<text x="6.9596" y="-0.3048" size="0.635" layer="48" ratio="4" rot="SR0">0.136in/3.45mm</text>
<text x="-13.7668" y="-0.3048" size="0.635" layer="48" ratio="4" rot="SR0">0.144in/3.658mm</text>
<text x="-4.0386" y="-6.3246" size="0.635" layer="48" ratio="4" rot="SR0">0.144in/3.658mm</text>
<wire x1="-1.8288" y1="0.5588" x2="-0.5588" y2="1.8288" width="0.1524" layer="51"/>
<wire x1="-1.8288" y1="-1.8288" x2="1.8288" y2="-1.8288" width="0.1524" layer="51"/>
<wire x1="1.8288" y1="-1.8288" x2="1.8288" y2="1.8288" width="0.1524" layer="51"/>
<wire x1="1.8288" y1="1.8288" x2="-1.8288" y2="1.8288" width="0.1524" layer="51"/>
<wire x1="-1.8288" y1="1.8288" x2="-1.8288" y2="-1.8288" width="0.1524" layer="51"/>
<text x="-1.6256" y="0.6096" size="1.27" layer="51" ratio="6" rot="SR0">*</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
</packages>
<symbols>
<symbol name="TPS562208DDCR">
<pin name="GND" x="17.78" y="-12.7" length="middle" direction="pwr" rot="R180"/>
<pin name="SW" x="17.78" y="10.16" length="middle" direction="pwr" rot="R180"/>
<pin name="VIN" x="-17.78" y="10.16" length="middle" direction="pwr"/>
<pin name="VFB" x="17.78" y="-7.62" length="middle" direction="in" rot="R180"/>
<pin name="EN" x="-17.78" y="2.54" length="middle" direction="in"/>
<pin name="VBST" x="17.78" y="2.54" length="middle" direction="pwr" rot="R180"/>
<wire x1="-12.7" y1="-15.24" x2="12.7" y2="-15.24" width="0.2032" layer="94"/>
<wire x1="12.7" y1="-15.24" x2="12.7" y2="15.24" width="0.2032" layer="94"/>
<wire x1="12.7" y1="15.24" x2="-12.7" y2="15.24" width="0.2032" layer="94"/>
<wire x1="-12.7" y1="15.24" x2="-12.7" y2="-15.24" width="0.2032" layer="94"/>
<text x="-4.7244" y="1.4986" size="2.0828" layer="95" ratio="6" rot="SR0">&gt;Name</text>
<text x="-5.3594" y="-1.0414" size="2.0828" layer="96" ratio="6" rot="SR0">&gt;Value</text>
<text x="-5.3594" y="-1.0414" size="2.0828" layer="96" ratio="6" rot="SR0">&gt;Value</text>
</symbol>
<symbol name="IND">
<pin name="1" x="15.24" y="0" visible="off" length="short" direction="pas" rot="R180"/>
<pin name="2" x="0" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
<wire x1="5.08" y1="1.27" x2="7.62" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<wire x1="2.54" y1="1.27" x2="5.08" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<wire x1="7.62" y1="1.27" x2="10.16" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<wire x1="10.16" y1="1.27" x2="12.7" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<text x="-1.9812" y="-4.2672" size="3.4798" layer="96" ratio="10" rot="SR0">&gt;Value</text>
<text x="-0.9144" y="3.3528" size="3.4798" layer="95" ratio="10" rot="SR0">&gt;Name</text>
<wire x1="5.08" y1="0" x2="5.08" y2="1.27" width="0.2032" layer="94"/>
<wire x1="7.62" y1="0" x2="7.62" y2="1.27" width="0.2032" layer="94"/>
<wire x1="12.7" y1="0" x2="12.7" y2="1.27" width="0.2032" layer="94"/>
<wire x1="2.54" y1="0" x2="2.54" y2="1.27" width="0.2032" layer="94"/>
<wire x1="10.16" y1="0" x2="10.16" y2="1.27" width="0.2032" layer="94"/>
<wire x1="5.08" y1="1.27" x2="7.62" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<wire x1="2.54" y1="1.27" x2="5.08" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<wire x1="7.62" y1="1.27" x2="10.16" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<wire x1="10.16" y1="1.27" x2="12.7" y2="1.27" width="0.1524" layer="94" curve="-180"/>
<text x="-1.9812" y="-4.2672" size="3.4798" layer="96" ratio="10" rot="SR0">&gt;Value</text>
<text x="-0.9144" y="3.3528" size="3.4798" layer="95" ratio="10" rot="SR0">&gt;Name</text>
</symbol>
<symbol name="ADM7151ACPZ-04-R7">
<pin name="VREG" x="0" y="0" direction="pwr"/>
<pin name="VOUT" x="0" y="-2.54" direction="out"/>
<pin name="BYP" x="0" y="-5.08" direction="pas"/>
<pin name="GND" x="0" y="-7.62" direction="pas"/>
<pin name="REF_SENSE" x="50.8" y="-10.16" direction="pas" rot="R180"/>
<pin name="REF" x="50.8" y="-7.62" direction="out" rot="R180"/>
<pin name="EN" x="50.8" y="-5.08" direction="in" rot="R180"/>
<pin name="VIN" x="50.8" y="-2.54" direction="in" rot="R180"/>
<pin name="EPAD" x="50.8" y="0" direction="pas" rot="R180"/>
<wire x1="7.62" y1="5.08" x2="7.62" y2="-15.24" width="0.1524" layer="94"/>
<wire x1="7.62" y1="-15.24" x2="43.18" y2="-15.24" width="0.1524" layer="94"/>
<wire x1="43.18" y1="-15.24" x2="43.18" y2="5.08" width="0.1524" layer="94"/>
<wire x1="43.18" y1="5.08" x2="7.62" y2="5.08" width="0.1524" layer="94"/>
<text x="20.6756" y="9.1186" size="2.0828" layer="95" ratio="6" rot="SR0">&gt;Name</text>
<text x="20.0406" y="6.5786" size="2.0828" layer="96" ratio="6" rot="SR0">&gt;Value</text>
</symbol>
<symbol name="TPS7A8300RGRR">
<pin name="OUT_2" x="0" y="0" direction="out"/>
<pin name="SNS" x="0" y="-2.54" direction="in"/>
<pin name="FB" x="0" y="-5.08" direction="in"/>
<pin name="PG" x="0" y="-7.62" direction="out"/>
<pin name="50MV" x="0" y="-10.16" direction="in"/>
<pin name="100MV" x="0" y="-12.7" direction="in"/>
<pin name="200MV" x="0" y="-15.24" direction="in"/>
<pin name="GND_2" x="0" y="-17.78" direction="pwr"/>
<pin name="400MV" x="0" y="-20.32" direction="in"/>
<pin name="800MV" x="0" y="-22.86" direction="in"/>
<pin name="1.6V" x="45.72" y="-25.4" direction="in" rot="R180"/>
<pin name="BIAS" x="45.72" y="-22.86" direction="in" rot="R180"/>
<pin name="NR/SS" x="45.72" y="-20.32" direction="pas" rot="R180"/>
<pin name="EN" x="45.72" y="-17.78" direction="in" rot="R180"/>
<pin name="IN_2" x="45.72" y="-15.24" direction="in" rot="R180"/>
<pin name="IN_3" x="45.72" y="-12.7" direction="in" rot="R180"/>
<pin name="IN" x="45.72" y="-10.16" direction="in" rot="R180"/>
<pin name="GND" x="45.72" y="-7.62" direction="pwr" rot="R180"/>
<pin name="OUT_3" x="45.72" y="-5.08" direction="out" rot="R180"/>
<pin name="OUT" x="45.72" y="-2.54" direction="out" rot="R180"/>
<pin name="EPAD" x="45.72" y="0" direction="pas" rot="R180"/>
<wire x1="7.62" y1="5.08" x2="7.62" y2="-30.48" width="0.1524" layer="94"/>
<wire x1="7.62" y1="-30.48" x2="38.1" y2="-30.48" width="0.1524" layer="94"/>
<wire x1="38.1" y1="-30.48" x2="38.1" y2="5.08" width="0.1524" layer="94"/>
<wire x1="38.1" y1="5.08" x2="7.62" y2="5.08" width="0.1524" layer="94"/>
<text x="18.1356" y="9.1186" size="2.0828" layer="95" ratio="6" rot="SR0">&gt;Name</text>
<text x="17.5006" y="6.5786" size="2.0828" layer="96" ratio="6" rot="SR0">&gt;Value</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="TPS562208DDCT" prefix="U">
<gates>
<gate name="A" symbol="TPS562208DDCR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="DDC0006A_N">
<connects>
<connect gate="A" pin="EN" pad="5"/>
<connect gate="A" pin="GND" pad="1"/>
<connect gate="A" pin="SW" pad="2"/>
<connect gate="A" pin="VBST" pad="6"/>
<connect gate="A" pin="VFB" pad="4"/>
<connect gate="A" pin="VIN" pad="3"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.ti.com/lit/gpn/tps562208" constant="no"/>
<attribute name="DESCRIPTION" value="4.5 V to 17 V input, 2 A output, synchronous step-down converter in FCCM mode 6-SOT-23-THIN -40 to 125" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Texas Instruments" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="TPS562208DDCT" constant="no"/>
<attribute name="REFDES" value="RefDes" constant="no"/>
<attribute name="TYPE" value="TYPE" constant="no"/>
</technology>
</technologies>
</device>
<device name="DDC0006A_M" package="DDC0006A_M">
<connects>
<connect gate="A" pin="EN" pad="5"/>
<connect gate="A" pin="GND" pad="1"/>
<connect gate="A" pin="SW" pad="2"/>
<connect gate="A" pin="VBST" pad="6"/>
<connect gate="A" pin="VFB" pad="4"/>
<connect gate="A" pin="VIN" pad="3"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.ti.com/lit/gpn/tps562208" constant="no"/>
<attribute name="DESCRIPTION" value="4.5 V to 17 V input, 2 A output, synchronous step-down converter in FCCM mode 6-SOT-23-THIN -40 to 125" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Texas Instruments" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="TPS562208DDCT" constant="no"/>
<attribute name="REFDES" value="RefDes" constant="no"/>
<attribute name="TYPE" value="TYPE" constant="no"/>
</technology>
</technologies>
</device>
<device name="DDC0006A_L" package="DDC0006A_L">
<connects>
<connect gate="A" pin="EN" pad="5"/>
<connect gate="A" pin="GND" pad="1"/>
<connect gate="A" pin="SW" pad="2"/>
<connect gate="A" pin="VBST" pad="6"/>
<connect gate="A" pin="VFB" pad="4"/>
<connect gate="A" pin="VIN" pad="3"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.ti.com/lit/gpn/tps562208" constant="no"/>
<attribute name="DESCRIPTION" value="4.5 V to 17 V input, 2 A output, synchronous step-down converter in FCCM mode 6-SOT-23-THIN -40 to 125" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Texas Instruments" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="TPS562208DDCT" constant="no"/>
<attribute name="REFDES" value="RefDes" constant="no"/>
<attribute name="TYPE" value="TYPE" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="POWER_INDUCTOR">
<gates>
<gate name="A" symbol="IND" x="-7.62" y="-2.54"/>
</gates>
<devices>
<device name="" package="IND_VLP8040T-1R0N_TDK">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="ADM7151ACPZ-04-R7" prefix="U">
<gates>
<gate name="A" symbol="ADM7151ACPZ-04-R7" x="0" y="0"/>
</gates>
<devices>
<device name="" package="CP_8_11_ADI">
<connects>
<connect gate="A" pin="BYP" pad="3"/>
<connect gate="A" pin="EN" pad="7"/>
<connect gate="A" pin="EPAD" pad="9"/>
<connect gate="A" pin="GND" pad="4"/>
<connect gate="A" pin="REF" pad="6"/>
<connect gate="A" pin="REF_SENSE" pad="5"/>
<connect gate="A" pin="VIN" pad="8"/>
<connect gate="A" pin="VOUT" pad="2"/>
<connect gate="A" pin="VREG" pad="1"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.analog.com/media/en/technical-documentation/data-sheets/ADM7151.pdf" constant="no"/>
<attribute name="DESCRIPTION" value="800 mA Ultralow Noise, High PSRR, RF Linear Regulator" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Analog Devices Inc" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="ADM7151ACPZ-04-R7" constant="no"/>
</technology>
</technologies>
</device>
<device name="CP_8_11_ADI-M" package="CP_8_11_ADI-M">
<connects>
<connect gate="A" pin="BYP" pad="3"/>
<connect gate="A" pin="EN" pad="7"/>
<connect gate="A" pin="EPAD" pad="9"/>
<connect gate="A" pin="GND" pad="4"/>
<connect gate="A" pin="REF" pad="6"/>
<connect gate="A" pin="REF_SENSE" pad="5"/>
<connect gate="A" pin="VIN" pad="8"/>
<connect gate="A" pin="VOUT" pad="2"/>
<connect gate="A" pin="VREG" pad="1"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.analog.com/media/en/technical-documentation/data-sheets/ADM7151.pdf" constant="no"/>
<attribute name="DESCRIPTION" value="800 mA Ultralow Noise, High PSRR, RF Linear Regulator" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Analog Devices Inc" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="ADM7151ACPZ-04-R7" constant="no"/>
</technology>
</technologies>
</device>
<device name="CP_8_11_ADI-L" package="CP_8_11_ADI-L">
<connects>
<connect gate="A" pin="BYP" pad="3"/>
<connect gate="A" pin="EN" pad="7"/>
<connect gate="A" pin="EPAD" pad="9"/>
<connect gate="A" pin="GND" pad="4"/>
<connect gate="A" pin="REF" pad="6"/>
<connect gate="A" pin="REF_SENSE" pad="5"/>
<connect gate="A" pin="VIN" pad="8"/>
<connect gate="A" pin="VOUT" pad="2"/>
<connect gate="A" pin="VREG" pad="1"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.analog.com/media/en/technical-documentation/data-sheets/ADM7151.pdf" constant="no"/>
<attribute name="DESCRIPTION" value="800 mA Ultralow Noise, High PSRR, RF Linear Regulator" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Analog Devices Inc" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="ADM7151ACPZ-04-R7" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="TPS7A8300RGRR" prefix="U">
<gates>
<gate name="A" symbol="TPS7A8300RGRR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="RGR20_2P05X2P05_TEX">
<connects>
<connect gate="A" pin="1.6V" pad="11"/>
<connect gate="A" pin="100MV" pad="6"/>
<connect gate="A" pin="200MV" pad="7"/>
<connect gate="A" pin="400MV" pad="9"/>
<connect gate="A" pin="50MV" pad="5"/>
<connect gate="A" pin="800MV" pad="10"/>
<connect gate="A" pin="BIAS" pad="12"/>
<connect gate="A" pin="EN" pad="14"/>
<connect gate="A" pin="EPAD" pad="21"/>
<connect gate="A" pin="FB" pad="3"/>
<connect gate="A" pin="GND" pad="18"/>
<connect gate="A" pin="GND_2" pad="8"/>
<connect gate="A" pin="IN" pad="17"/>
<connect gate="A" pin="IN_2" pad="15"/>
<connect gate="A" pin="IN_3" pad="16"/>
<connect gate="A" pin="NR/SS" pad="13"/>
<connect gate="A" pin="OUT" pad="20"/>
<connect gate="A" pin="OUT_2" pad="1"/>
<connect gate="A" pin="OUT_3" pad="19"/>
<connect gate="A" pin="PG" pad="4"/>
<connect gate="A" pin="SNS" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2025 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="DATASHEET" value="https://www.ti.com/lit/gpn/tps7a8300" constant="no"/>
<attribute name="DESCRIPTION" value="2-A, low-VIN, low-2-A, low-VIN, low-noise, ultra-low-dropout voltage regulator with power good wi 20-VQFN -40 to 125" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="Texas Instruments" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="TPS7A8300RGRR" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply1" urn="urn:adsk.eagle:library:371">
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
<symbol name="GND" urn="urn:adsk.eagle:symbol:26925/1" library_version="1">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.254" layer="94"/>
<text x="-2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" urn="urn:adsk.eagle:component:26954/1" prefix="GND" library_version="1">
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
<library name="rcl" urn="urn:adsk.eagle:library:334">
<description>&lt;b&gt;Resistors, Capacitors, Inductors&lt;/b&gt;&lt;p&gt;
Based on the previous libraries:
&lt;ul&gt;
&lt;li&gt;r.lbr
&lt;li&gt;cap.lbr 
&lt;li&gt;cap-fe.lbr
&lt;li&gt;captant.lbr
&lt;li&gt;polcap.lbr
&lt;li&gt;ipc-smd.lbr
&lt;/ul&gt;
All SMD packages are defined according to the IPC specifications and  CECC&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;&lt;p&gt;
&lt;p&gt;
for Electrolyt Capacitors see also :&lt;p&gt;
www.bccomponents.com &lt;p&gt;
www.panasonic.com&lt;p&gt;
www.kemet.com&lt;p&gt;
http://www.secc.co.jp/pdf/os_e/2004/e_os_all.pdf &lt;b&gt;(SANYO)&lt;/b&gt;
&lt;p&gt;
for trimmer refence see : &lt;u&gt;www.electrospec-inc.com/cross_references/trimpotcrossref.asp&lt;/u&gt;&lt;p&gt;

&lt;table border=0 cellspacing=0 cellpadding=0 width="100%" cellpaddding=0&gt;
&lt;tr valign="top"&gt;

&lt;! &lt;td width="10"&gt;&amp;nbsp;&lt;/td&gt;
&lt;td width="90%"&gt;

&lt;b&gt;&lt;font color="#0000FF" size="4"&gt;TRIM-POT CROSS REFERENCE&lt;/font&gt;&lt;/b&gt;
&lt;P&gt;
&lt;TABLE BORDER=0 CELLSPACING=1 CELLPADDING=2&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;RECTANGULAR MULTI-TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;BOURNS&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;BI&amp;nbsp;TECH&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;DALE-VISHAY&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;PHILIPS/MEPCO&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;MURATA&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;PANASONIC&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;SPECTROL&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;MILSPEC&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;&lt;TD&gt;&amp;nbsp;&lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3 &gt;
      3005P&lt;BR&gt;
      3006P&lt;BR&gt;
      3006W&lt;BR&gt;
      3006Y&lt;BR&gt;
      3009P&lt;BR&gt;
      3009W&lt;BR&gt;
      3009Y&lt;BR&gt;
      3057J&lt;BR&gt;
      3057L&lt;BR&gt;
      3057P&lt;BR&gt;
      3057Y&lt;BR&gt;
      3059J&lt;BR&gt;
      3059L&lt;BR&gt;
      3059P&lt;BR&gt;
      3059Y&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      89P&lt;BR&gt;
      89W&lt;BR&gt;
      89X&lt;BR&gt;
      89PH&lt;BR&gt;
      76P&lt;BR&gt;
      89XH&lt;BR&gt;
      78SLT&lt;BR&gt;
      78L&amp;nbsp;ALT&lt;BR&gt;
      56P&amp;nbsp;ALT&lt;BR&gt;
      78P&amp;nbsp;ALT&lt;BR&gt;
      T8S&lt;BR&gt;
      78L&lt;BR&gt;
      56P&lt;BR&gt;
      78P&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      T18/784&lt;BR&gt;
      783&lt;BR&gt;
      781&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      2199&lt;BR&gt;
      1697/1897&lt;BR&gt;
      1680/1880&lt;BR&gt;
      2187&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      8035EKP/CT20/RJ-20P&lt;BR&gt;
      -&lt;BR&gt;
      RJ-20X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      1211L&lt;BR&gt;
      8012EKQ&amp;nbsp;ALT&lt;BR&gt;
      8012EKR&amp;nbsp;ALT&lt;BR&gt;
      1211P&lt;BR&gt;
      8012EKJ&lt;BR&gt;
      8012EKL&lt;BR&gt;
      8012EKQ&lt;BR&gt;
      8012EKR&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      2101P&lt;BR&gt;
      2101W&lt;BR&gt;
      2101Y&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      2102L&lt;BR&gt;
      2102S&lt;BR&gt;
      2102Y&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      EVMCOG&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      43P&lt;BR&gt;
      43W&lt;BR&gt;
      43Y&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      40L&lt;BR&gt;
      40P&lt;BR&gt;
      40Y&lt;BR&gt;
      70Y-T602&lt;BR&gt;
      70L&lt;BR&gt;
      70P&lt;BR&gt;
      70Y&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      RT/RTR12&lt;BR&gt;
      RT/RTR12&lt;BR&gt;
      RT/RTR12&lt;BR&gt;
      -&lt;BR&gt;
      RJ/RJR12&lt;BR&gt;
      RJ/RJR12&lt;BR&gt;
      RJ/RJR12&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SQUARE MULTI-TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
   &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MURATA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;SPECTROL&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MILSPEC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3250L&lt;BR&gt;
      3250P&lt;BR&gt;
      3250W&lt;BR&gt;
      3250X&lt;BR&gt;
      3252P&lt;BR&gt;
      3252W&lt;BR&gt;
      3252X&lt;BR&gt;
      3260P&lt;BR&gt;
      3260W&lt;BR&gt;
      3260X&lt;BR&gt;
      3262P&lt;BR&gt;
      3262W&lt;BR&gt;
      3262X&lt;BR&gt;
      3266P&lt;BR&gt;
      3266W&lt;BR&gt;
      3266X&lt;BR&gt;
      3290H&lt;BR&gt;
      3290P&lt;BR&gt;
      3290W&lt;BR&gt;
      3292P&lt;BR&gt;
      3292W&lt;BR&gt;
      3292X&lt;BR&gt;
      3296P&lt;BR&gt;
      3296W&lt;BR&gt;
      3296X&lt;BR&gt;
      3296Y&lt;BR&gt;
      3296Z&lt;BR&gt;
      3299P&lt;BR&gt;
      3299W&lt;BR&gt;
      3299X&lt;BR&gt;
      3299Y&lt;BR&gt;
      3299Z&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      66P&amp;nbsp;ALT&lt;BR&gt;
      66W&amp;nbsp;ALT&lt;BR&gt;
      66X&amp;nbsp;ALT&lt;BR&gt;
      66P&amp;nbsp;ALT&lt;BR&gt;
      66W&amp;nbsp;ALT&lt;BR&gt;
      66X&amp;nbsp;ALT&lt;BR&gt;
      -&lt;BR&gt;
      64W&amp;nbsp;ALT&lt;BR&gt;
      -&lt;BR&gt;
      64P&amp;nbsp;ALT&lt;BR&gt;
      64W&amp;nbsp;ALT&lt;BR&gt;
      64X&amp;nbsp;ALT&lt;BR&gt;
      64P&lt;BR&gt;
      64W&lt;BR&gt;
      64X&lt;BR&gt;
      66X&amp;nbsp;ALT&lt;BR&gt;
      66P&amp;nbsp;ALT&lt;BR&gt;
      66W&amp;nbsp;ALT&lt;BR&gt;
      66P&lt;BR&gt;
      66W&lt;BR&gt;
      66X&lt;BR&gt;
      67P&lt;BR&gt;
      67W&lt;BR&gt;
      67X&lt;BR&gt;
      67Y&lt;BR&gt;
      67Z&lt;BR&gt;
      68P&lt;BR&gt;
      68W&lt;BR&gt;
      68X&lt;BR&gt;
      67Y&amp;nbsp;ALT&lt;BR&gt;
      67Z&amp;nbsp;ALT&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      5050&lt;BR&gt;
      5091&lt;BR&gt;
      5080&lt;BR&gt;
      5087&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      T63YB&lt;BR&gt;
      T63XB&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      5887&lt;BR&gt;
      5891&lt;BR&gt;
      5880&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      T93Z&lt;BR&gt;
      T93YA&lt;BR&gt;
      T93XA&lt;BR&gt;
      T93YB&lt;BR&gt;
      T93XB&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      8026EKP&lt;BR&gt;
      8026EKW&lt;BR&gt;
      8026EKM&lt;BR&gt;
      8026EKP&lt;BR&gt;
      8026EKB&lt;BR&gt;
      8026EKM&lt;BR&gt;
      1309X&lt;BR&gt;
      1309P&lt;BR&gt;
      1309W&lt;BR&gt;
      8024EKP&lt;BR&gt;
      8024EKW&lt;BR&gt;
      8024EKN&lt;BR&gt;
      RJ-9P/CT9P&lt;BR&gt;
      RJ-9W&lt;BR&gt;
      RJ-9X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3103P&lt;BR&gt;
      3103Y&lt;BR&gt;
      3103Z&lt;BR&gt;
      3103P&lt;BR&gt;
      3103Y&lt;BR&gt;
      3103Z&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3105P/3106P&lt;BR&gt;
      3105W/3106W&lt;BR&gt;
      3105X/3106X&lt;BR&gt;
      3105Y/3106Y&lt;BR&gt;
      3105Z/3105Z&lt;BR&gt;
      3102P&lt;BR&gt;
      3102W&lt;BR&gt;
      3102X&lt;BR&gt;
      3102Y&lt;BR&gt;
      3102Z&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMCBG&lt;BR&gt;
      EVMCCG&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      55-1-X&lt;BR&gt;
      55-4-X&lt;BR&gt;
      55-3-X&lt;BR&gt;
      55-2-X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      50-2-X&lt;BR&gt;
      50-4-X&lt;BR&gt;
      50-3-X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      64P&lt;BR&gt;
      64W&lt;BR&gt;
      64X&lt;BR&gt;
      64Y&lt;BR&gt;
      64Z&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      RT/RTR22&lt;BR&gt;
      RT/RTR22&lt;BR&gt;
      RT/RTR22&lt;BR&gt;
      RT/RTR22&lt;BR&gt;
      RJ/RJR22&lt;BR&gt;
      RJ/RJR22&lt;BR&gt;
      RJ/RJR22&lt;BR&gt;
      RT/RTR26&lt;BR&gt;
      RT/RTR26&lt;BR&gt;
      RT/RTR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RT/RTR24&lt;BR&gt;
      RT/RTR24&lt;BR&gt;
      RT/RTR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SINGLE TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MURATA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;SPECTROL&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MILSPEC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3323P&lt;BR&gt;
      3323S&lt;BR&gt;
      3323W&lt;BR&gt;
      3329H&lt;BR&gt;
      3329P&lt;BR&gt;
      3329W&lt;BR&gt;
      3339H&lt;BR&gt;
      3339P&lt;BR&gt;
      3339W&lt;BR&gt;
      3352E&lt;BR&gt;
      3352H&lt;BR&gt;
      3352K&lt;BR&gt;
      3352P&lt;BR&gt;
      3352T&lt;BR&gt;
      3352V&lt;BR&gt;
      3352W&lt;BR&gt;
      3362H&lt;BR&gt;
      3362M&lt;BR&gt;
      3362P&lt;BR&gt;
      3362R&lt;BR&gt;
      3362S&lt;BR&gt;
      3362U&lt;BR&gt;
      3362W&lt;BR&gt;
      3362X&lt;BR&gt;
      3386B&lt;BR&gt;
      3386C&lt;BR&gt;
      3386F&lt;BR&gt;
      3386H&lt;BR&gt;
      3386K&lt;BR&gt;
      3386M&lt;BR&gt;
      3386P&lt;BR&gt;
      3386S&lt;BR&gt;
      3386W&lt;BR&gt;
      3386X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      25P&lt;BR&gt;
      25S&lt;BR&gt;
      25RX&lt;BR&gt;
      82P&lt;BR&gt;
      82M&lt;BR&gt;
      82PA&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      91E&lt;BR&gt;
      91X&lt;BR&gt;
      91T&lt;BR&gt;
      91B&lt;BR&gt;
      91A&lt;BR&gt;
      91V&lt;BR&gt;
      91W&lt;BR&gt;
      25W&lt;BR&gt;
      25V&lt;BR&gt;
      25P&lt;BR&gt;
      -&lt;BR&gt;
      25S&lt;BR&gt;
      25U&lt;BR&gt;
      25RX&lt;BR&gt;
      25X&lt;BR&gt;
      72XW&lt;BR&gt;
      72XL&lt;BR&gt;
      72PM&lt;BR&gt;
      72RX&lt;BR&gt;
      -&lt;BR&gt;
      72PX&lt;BR&gt;
      72P&lt;BR&gt;
      72RXW&lt;BR&gt;
      72RXL&lt;BR&gt;
      72X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      T7YB&lt;BR&gt;
      T7YA&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      TXD&lt;BR&gt;
      TYA&lt;BR&gt;
      TYP&lt;BR&gt;
      -&lt;BR&gt;
      TYD&lt;BR&gt;
      TX&lt;BR&gt;
      -&lt;BR&gt;
      150SX&lt;BR&gt;
      100SX&lt;BR&gt;
      102T&lt;BR&gt;
      101S&lt;BR&gt;
      190T&lt;BR&gt;
      150TX&lt;BR&gt;
      101&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      101SX&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      ET6P&lt;BR&gt;
      ET6S&lt;BR&gt;
      ET6X&lt;BR&gt;
      RJ-6W/8014EMW&lt;BR&gt;
      RJ-6P/8014EMP&lt;BR&gt;
      RJ-6X/8014EMX&lt;BR&gt;
      TM7W&lt;BR&gt;
      TM7P&lt;BR&gt;
      TM7X&lt;BR&gt;
      -&lt;BR&gt;
      8017SMS&lt;BR&gt;
      -&lt;BR&gt;
      8017SMB&lt;BR&gt;
      8017SMA&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      CT-6W&lt;BR&gt;
      CT-6H&lt;BR&gt;
      CT-6P&lt;BR&gt;
      CT-6R&lt;BR&gt;
      -&lt;BR&gt;
      CT-6V&lt;BR&gt;
      CT-6X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      8038EKV&lt;BR&gt;
      -&lt;BR&gt;
      8038EKX&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      8038EKP&lt;BR&gt;
      8038EKZ&lt;BR&gt;
      8038EKW&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3321H&lt;BR&gt;
      3321P&lt;BR&gt;
      3321N&lt;BR&gt;
      1102H&lt;BR&gt;
      1102P&lt;BR&gt;
      1102T&lt;BR&gt;
      RVA0911V304A&lt;BR&gt;
      -&lt;BR&gt;
      RVA0911H413A&lt;BR&gt;
      RVG0707V100A&lt;BR&gt;
      RVA0607V(H)306A&lt;BR&gt;
      RVA1214H213A&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3104B&lt;BR&gt;
      3104C&lt;BR&gt;
      3104F&lt;BR&gt;
      3104H&lt;BR&gt;
      -&lt;BR&gt;
      3104M&lt;BR&gt;
      3104P&lt;BR&gt;
      3104S&lt;BR&gt;
      3104W&lt;BR&gt;
      3104X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      EVMQ0G&lt;BR&gt;
      EVMQIG&lt;BR&gt;
      EVMQ3G&lt;BR&gt;
      EVMS0G&lt;BR&gt;
      EVMQ0G&lt;BR&gt;
      EVMG0G&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMK4GA00B&lt;BR&gt;
      EVM30GA00B&lt;BR&gt;
      EVMK0GA00B&lt;BR&gt;
      EVM38GA00B&lt;BR&gt;
      EVMB6&lt;BR&gt;
      EVLQ0&lt;BR&gt;
      -&lt;BR&gt;
      EVMMSG&lt;BR&gt;
      EVMMBG&lt;BR&gt;
      EVMMAG&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMMCS&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMM1&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMM0&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMM3&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      62-3-1&lt;BR&gt;
      62-1-2&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      67R&lt;BR&gt;
      -&lt;BR&gt;
      67P&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      67X&lt;BR&gt;
      63V&lt;BR&gt;
      63S&lt;BR&gt;
      63M&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      63H&lt;BR&gt;
      63P&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      63X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      RJ/RJR50&lt;BR&gt;
      RJ/RJR50&lt;BR&gt;
      RJ/RJR50&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
&lt;/TABLE&gt;
&lt;P&gt;&amp;nbsp;&lt;P&gt;
&lt;TABLE BORDER=0 CELLSPACING=1 CELLPADDING=3&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;
      &lt;FONT color="#0000FF" SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SMD TRIM-POT CROSS REFERENCE&lt;/B&gt;&lt;/FONT&gt;
      &lt;P&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;MULTI-TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURNS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;TOCOS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;AUX/KYOCERA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3224G&lt;BR&gt;
      3224J&lt;BR&gt;
      3224W&lt;BR&gt;
      3269P&lt;BR&gt;
      3269W&lt;BR&gt;
      3269X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      44G&lt;BR&gt;
      44J&lt;BR&gt;
      44W&lt;BR&gt;
      84P&lt;BR&gt;
      84W&lt;BR&gt;
      84X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      ST63Z&lt;BR&gt;
      ST63Y&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      ST5P&lt;BR&gt;
      ST5W&lt;BR&gt;
      ST5X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SINGLE TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURNS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;TOCOS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;AUX/KYOCERA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3314G&lt;BR&gt;
      3314J&lt;BR&gt;
      3364A/B&lt;BR&gt;
      3364C/D&lt;BR&gt;
      3364W/X&lt;BR&gt;
      3313G&lt;BR&gt;
      3313J&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      23B&lt;BR&gt;
      23A&lt;BR&gt;
      21X&lt;BR&gt;
      21W&lt;BR&gt;
      -&lt;BR&gt;
      22B&lt;BR&gt;
      22A&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      ST5YL/ST53YL&lt;BR&gt;
      ST5YJ/5T53YJ&lt;BR&gt;
      ST-23A&lt;BR&gt;
      ST-22B&lt;BR&gt;
      ST-22&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      ST-4B&lt;BR&gt;
      ST-4A&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      ST-3B&lt;BR&gt;
      ST-3A&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      EVM-6YS&lt;BR&gt;
      EVM-1E&lt;BR&gt;
      EVM-1G&lt;BR&gt;
      EVM-1D&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      G4B&lt;BR&gt;
      G4A&lt;BR&gt;
      TR04-3S1&lt;BR&gt;
      TRG04-2S1&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      DVR-43A&lt;BR&gt;
      CVR-42C&lt;BR&gt;
      CVR-42A/C&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
&lt;/TABLE&gt;
&lt;P&gt;
&lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;ALT =&amp;nbsp;ALTERNATE&lt;/B&gt;&lt;/FONT&gt;
&lt;P&gt;

&amp;nbsp;
&lt;P&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;</description>
<packages>
<package name="C0402" urn="urn:adsk.eagle:footprint:23121/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-0.245" y1="0.224" x2="0.245" y2="0.224" width="0.1524" layer="51"/>
<wire x1="0.245" y1="-0.224" x2="-0.245" y2="-0.224" width="0.1524" layer="51"/>
<wire x1="-1.473" y1="0.483" x2="1.473" y2="0.483" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.483" x2="1.473" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.483" x2="-1.473" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.483" x2="-1.473" y2="0.483" width="0.0508" layer="39"/>
<smd name="1" x="-0.65" y="0" dx="0.7" dy="0.9" layer="1"/>
<smd name="2" x="0.65" y="0" dx="0.7" dy="0.9" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.554" y1="-0.3048" x2="-0.254" y2="0.2951" layer="51"/>
<rectangle x1="0.2588" y1="-0.3048" x2="0.5588" y2="0.2951" layer="51"/>
<rectangle x1="-0.1999" y1="-0.3" x2="0.1999" y2="0.3" layer="35"/>
</package>
<package name="C0504" urn="urn:adsk.eagle:footprint:23122/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-1.473" y1="0.983" x2="1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.983" x2="1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.983" x2="-1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.983" x2="-1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.294" y1="0.559" x2="0.294" y2="0.559" width="0.1016" layer="51"/>
<wire x1="-0.294" y1="-0.559" x2="0.294" y2="-0.559" width="0.1016" layer="51"/>
<smd name="1" x="-0.7" y="0" dx="1" dy="1.3" layer="1"/>
<smd name="2" x="0.7" y="0" dx="1" dy="1.3" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.6604" y1="-0.6223" x2="-0.2804" y2="0.6276" layer="51"/>
<rectangle x1="0.2794" y1="-0.6223" x2="0.6594" y2="0.6276" layer="51"/>
<rectangle x1="-0.1001" y1="-0.4001" x2="0.1001" y2="0.4001" layer="35"/>
</package>
<package name="C0603" urn="urn:adsk.eagle:footprint:23123/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-1.473" y1="0.983" x2="1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.983" x2="1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.983" x2="-1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.983" x2="-1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.356" y1="0.432" x2="0.356" y2="0.432" width="0.1016" layer="51"/>
<wire x1="-0.356" y1="-0.419" x2="0.356" y2="-0.419" width="0.1016" layer="51"/>
<smd name="1" x="-0.85" y="0" dx="1.1" dy="1" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1.1" dy="1" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.8382" y1="-0.4699" x2="-0.3381" y2="0.4801" layer="51"/>
<rectangle x1="0.3302" y1="-0.4699" x2="0.8303" y2="0.4801" layer="51"/>
<rectangle x1="-0.1999" y1="-0.3" x2="0.1999" y2="0.3" layer="35"/>
</package>
<package name="C0805" urn="urn:adsk.eagle:footprint:23124/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.381" y1="0.66" x2="0.381" y2="0.66" width="0.1016" layer="51"/>
<wire x1="-0.356" y1="-0.66" x2="0.381" y2="-0.66" width="0.1016" layer="51"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0922" y1="-0.7239" x2="-0.3421" y2="0.7262" layer="51"/>
<rectangle x1="0.3556" y1="-0.7239" x2="1.1057" y2="0.7262" layer="51"/>
<rectangle x1="-0.1001" y1="-0.4001" x2="0.1001" y2="0.4001" layer="35"/>
</package>
<package name="C1206" urn="urn:adsk.eagle:footprint:23125/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-0.965" y1="0.787" x2="0.965" y2="0.787" width="0.1016" layer="51"/>
<wire x1="-0.965" y1="-0.787" x2="0.965" y2="-0.787" width="0.1016" layer="51"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-0.8509" x2="-0.9517" y2="0.8491" layer="51"/>
<rectangle x1="0.9517" y1="-0.8491" x2="1.7018" y2="0.8509" layer="51"/>
<rectangle x1="-0.1999" y1="-0.4001" x2="0.1999" y2="0.4001" layer="35"/>
</package>
<package name="C1210" urn="urn:adsk.eagle:footprint:23126/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="-0.9652" y1="1.2446" x2="0.9652" y2="1.2446" width="0.1016" layer="51"/>
<wire x1="-0.9652" y1="-1.2446" x2="0.9652" y2="-1.2446" width="0.1016" layer="51"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-1.2954" x2="-0.9517" y2="1.3045" layer="51"/>
<rectangle x1="0.9517" y1="-1.3045" x2="1.7018" y2="1.2954" layer="51"/>
<rectangle x1="-0.1999" y1="-0.4001" x2="0.1999" y2="0.4001" layer="35"/>
</package>
<package name="C1310" urn="urn:adsk.eagle:footprint:23127/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-1.473" y1="0.983" x2="1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.983" x2="1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.983" x2="-1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.983" x2="-1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.294" y1="0.559" x2="0.294" y2="0.559" width="0.1016" layer="51"/>
<wire x1="-0.294" y1="-0.559" x2="0.294" y2="-0.559" width="0.1016" layer="51"/>
<smd name="1" x="-0.7" y="0" dx="1" dy="1.3" layer="1"/>
<smd name="2" x="0.7" y="0" dx="1" dy="1.3" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.6604" y1="-0.6223" x2="-0.2804" y2="0.6276" layer="51"/>
<rectangle x1="0.2794" y1="-0.6223" x2="0.6594" y2="0.6276" layer="51"/>
<rectangle x1="-0.1001" y1="-0.3" x2="0.1001" y2="0.3" layer="35"/>
</package>
<package name="C1608" urn="urn:adsk.eagle:footprint:23128/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-1.473" y1="0.983" x2="1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.983" x2="1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.983" x2="-1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.983" x2="-1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.356" y1="0.432" x2="0.356" y2="0.432" width="0.1016" layer="51"/>
<wire x1="-0.356" y1="-0.419" x2="0.356" y2="-0.419" width="0.1016" layer="51"/>
<smd name="1" x="-0.85" y="0" dx="1.1" dy="1" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1.1" dy="1" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.8382" y1="-0.4699" x2="-0.3381" y2="0.4801" layer="51"/>
<rectangle x1="0.3302" y1="-0.4699" x2="0.8303" y2="0.4801" layer="51"/>
<rectangle x1="-0.1999" y1="-0.3" x2="0.1999" y2="0.3" layer="35"/>
</package>
<package name="C1812" urn="urn:adsk.eagle:footprint:23129/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.973" y1="1.983" x2="2.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-1.983" x2="-2.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-1.983" x2="-2.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="-1.4732" y1="1.6002" x2="1.4732" y2="1.6002" width="0.1016" layer="51"/>
<wire x1="-1.4478" y1="-1.6002" x2="1.4732" y2="-1.6002" width="0.1016" layer="51"/>
<wire x1="2.973" y1="1.983" x2="2.973" y2="-1.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.95" y="0" dx="1.9" dy="3.4" layer="1"/>
<smd name="2" x="1.95" y="0" dx="1.9" dy="3.4" layer="1"/>
<text x="-1.905" y="2.54" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.81" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.3876" y1="-1.651" x2="-1.4376" y2="1.649" layer="51"/>
<rectangle x1="1.4478" y1="-1.651" x2="2.3978" y2="1.649" layer="51"/>
<rectangle x1="-0.3" y1="-0.4001" x2="0.3" y2="0.4001" layer="35"/>
</package>
<package name="C1825" urn="urn:adsk.eagle:footprint:23130/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.973" y1="3.483" x2="2.973" y2="3.483" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-3.483" x2="-2.973" y2="-3.483" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-3.483" x2="-2.973" y2="3.483" width="0.0508" layer="39"/>
<wire x1="-1.4986" y1="3.2766" x2="1.4732" y2="3.2766" width="0.1016" layer="51"/>
<wire x1="-1.4732" y1="-3.2766" x2="1.4986" y2="-3.2766" width="0.1016" layer="51"/>
<wire x1="2.973" y1="3.483" x2="2.973" y2="-3.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.95" y="0" dx="1.9" dy="6.8" layer="1"/>
<smd name="2" x="1.95" y="0" dx="1.9" dy="6.8" layer="1"/>
<text x="-1.905" y="3.81" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-5.08" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.413" y1="-3.3528" x2="-1.463" y2="3.3472" layer="51"/>
<rectangle x1="1.4478" y1="-3.3528" x2="2.3978" y2="3.3472" layer="51"/>
<rectangle x1="-0.7" y1="-0.7" x2="0.7" y2="0.7" layer="35"/>
</package>
<package name="C2012" urn="urn:adsk.eagle:footprint:23131/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="-0.381" y1="0.66" x2="0.381" y2="0.66" width="0.1016" layer="51"/>
<wire x1="-0.356" y1="-0.66" x2="0.381" y2="-0.66" width="0.1016" layer="51"/>
<smd name="1" x="-0.85" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0922" y1="-0.7239" x2="-0.3421" y2="0.7262" layer="51"/>
<rectangle x1="0.3556" y1="-0.7239" x2="1.1057" y2="0.7262" layer="51"/>
<rectangle x1="-0.1001" y1="-0.4001" x2="0.1001" y2="0.4001" layer="35"/>
</package>
<package name="C3216" urn="urn:adsk.eagle:footprint:23132/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-0.965" y1="0.787" x2="0.965" y2="0.787" width="0.1016" layer="51"/>
<wire x1="-0.965" y1="-0.787" x2="0.965" y2="-0.787" width="0.1016" layer="51"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-0.8509" x2="-0.9517" y2="0.8491" layer="51"/>
<rectangle x1="0.9517" y1="-0.8491" x2="1.7018" y2="0.8509" layer="51"/>
<rectangle x1="-0.3" y1="-0.5001" x2="0.3" y2="0.5001" layer="35"/>
</package>
<package name="C3225" urn="urn:adsk.eagle:footprint:23133/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="-0.9652" y1="1.2446" x2="0.9652" y2="1.2446" width="0.1016" layer="51"/>
<wire x1="-0.9652" y1="-1.2446" x2="0.9652" y2="-1.2446" width="0.1016" layer="51"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-1.2954" x2="-0.9517" y2="1.3045" layer="51"/>
<rectangle x1="0.9517" y1="-1.3045" x2="1.7018" y2="1.2954" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5001" x2="0.1999" y2="0.5001" layer="35"/>
</package>
<package name="C4532" urn="urn:adsk.eagle:footprint:23134/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.973" y1="1.983" x2="2.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-1.983" x2="-2.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-1.983" x2="-2.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="-1.4732" y1="1.6002" x2="1.4732" y2="1.6002" width="0.1016" layer="51"/>
<wire x1="-1.4478" y1="-1.6002" x2="1.4732" y2="-1.6002" width="0.1016" layer="51"/>
<wire x1="2.973" y1="1.983" x2="2.973" y2="-1.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.95" y="0" dx="1.9" dy="3.4" layer="1"/>
<smd name="2" x="1.95" y="0" dx="1.9" dy="3.4" layer="1"/>
<text x="-1.905" y="2.54" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.81" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.3876" y1="-1.651" x2="-1.4376" y2="1.649" layer="51"/>
<rectangle x1="1.4478" y1="-1.651" x2="2.3978" y2="1.649" layer="51"/>
<rectangle x1="-0.4001" y1="-0.7" x2="0.4001" y2="0.7" layer="35"/>
</package>
<package name="C4564" urn="urn:adsk.eagle:footprint:23135/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<wire x1="-2.973" y1="3.483" x2="2.973" y2="3.483" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-3.483" x2="-2.973" y2="-3.483" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-3.483" x2="-2.973" y2="3.483" width="0.0508" layer="39"/>
<wire x1="-1.4986" y1="3.2766" x2="1.4732" y2="3.2766" width="0.1016" layer="51"/>
<wire x1="-1.4732" y1="-3.2766" x2="1.4986" y2="-3.2766" width="0.1016" layer="51"/>
<wire x1="2.973" y1="3.483" x2="2.973" y2="-3.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.95" y="0" dx="1.9" dy="6.8" layer="1"/>
<smd name="2" x="1.95" y="0" dx="1.9" dy="6.8" layer="1"/>
<text x="-1.905" y="3.81" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-5.08" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.413" y1="-3.3528" x2="-1.463" y2="3.3472" layer="51"/>
<rectangle x1="1.4478" y1="-3.3528" x2="2.3978" y2="3.3472" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="C025-024X044" urn="urn:adsk.eagle:footprint:23136/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 2.4 x 4.4 mm</description>
<wire x1="-2.159" y1="-0.635" x2="-2.159" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.159" y1="0.635" x2="-1.651" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.159" y1="-0.635" x2="-1.651" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="1.651" y1="1.143" x2="-1.651" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-0.635" x2="2.159" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.651" y1="-1.143" x2="-1.651" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="1.651" y1="1.143" x2="2.159" y2="0.635" width="0.1524" layer="21" curve="-90"/>
<wire x1="1.651" y1="-1.143" x2="2.159" y2="-0.635" width="0.1524" layer="21" curve="90"/>
<wire x1="-0.3048" y1="0.762" x2="-0.3048" y2="-0.762" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0.762" x2="0.3302" y2="-0.762" width="0.3048" layer="21"/>
<wire x1="1.27" y1="0" x2="0.3302" y2="0" width="0.1524" layer="51"/>
<wire x1="-1.27" y1="0" x2="-0.3048" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-1.778" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.778" y="-2.667" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025-025X050" urn="urn:adsk.eagle:footprint:23137/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 2.5 x 5 mm</description>
<wire x1="-2.159" y1="1.27" x2="2.159" y2="1.27" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-1.27" x2="-2.159" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.159" y1="1.27" x2="2.413" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="1.016" x2="-2.159" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-1.27" x2="2.413" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-1.016" x2="-2.159" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="1.524" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025-030X050" urn="urn:adsk.eagle:footprint:23138/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 3 x 5 mm</description>
<wire x1="-2.159" y1="1.524" x2="2.159" y2="1.524" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-1.524" x2="-2.159" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.27" x2="2.413" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.27" x2="-2.413" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="2.159" y1="1.524" x2="2.413" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="1.27" x2="-2.159" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-1.524" x2="2.413" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-1.27" x2="-2.159" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-3.048" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025-040X050" urn="urn:adsk.eagle:footprint:23139/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 4 x 5 mm</description>
<wire x1="-2.159" y1="1.905" x2="2.159" y2="1.905" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-1.905" x2="-2.159" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.651" x2="2.413" y2="-1.651" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.651" x2="-2.413" y2="-1.651" width="0.1524" layer="21"/>
<wire x1="2.159" y1="1.905" x2="2.413" y2="1.651" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="1.651" x2="-2.159" y2="1.905" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-1.905" x2="2.413" y2="-1.651" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-1.651" x2="-2.159" y2="-1.905" width="0.1524" layer="21" curve="90"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="2.159" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-3.429" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025-050X050" urn="urn:adsk.eagle:footprint:23140/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 5 x 5 mm</description>
<wire x1="-2.159" y1="2.286" x2="2.159" y2="2.286" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-2.286" x2="-2.159" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="2.413" y1="2.032" x2="2.413" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="2.032" x2="-2.413" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="2.159" y1="2.286" x2="2.413" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="2.032" x2="-2.159" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-2.286" x2="2.413" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-2.032" x2="-2.159" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="2.54" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-3.81" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025-060X050" urn="urn:adsk.eagle:footprint:23141/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm, outline 6 x 5 mm</description>
<wire x1="-2.159" y1="2.794" x2="2.159" y2="2.794" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-2.794" x2="-2.159" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="2.413" y1="2.54" x2="2.413" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="2.54" x2="-2.413" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="2.159" y1="2.794" x2="2.413" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="2.54" x2="-2.159" y2="2.794" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-2.794" x2="2.413" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-2.54" x2="-2.159" y2="-2.794" width="0.1524" layer="21" curve="90"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="3.048" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.032" y="-2.413" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025_050-024X070" urn="urn:adsk.eagle:footprint:23142/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 mm + 5 mm, outline 2.4 x 7 mm</description>
<wire x1="-2.159" y1="-0.635" x2="-2.159" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-2.159" y1="0.635" x2="-1.651" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.159" y1="-0.635" x2="-1.651" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="1.651" y1="1.143" x2="-1.651" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-0.635" x2="2.159" y2="0.635" width="0.1524" layer="51"/>
<wire x1="1.651" y1="-1.143" x2="-1.651" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="1.651" y1="1.143" x2="2.159" y2="0.635" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.191" y1="-1.143" x2="-3.9624" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-4.191" y1="1.143" x2="-3.9624" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="-0.635" x2="-4.191" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="1.651" y1="-1.143" x2="2.159" y2="-0.635" width="0.1524" layer="21" curve="90"/>
<wire x1="-4.699" y1="0.635" x2="-4.191" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.699" y1="-0.635" x2="-4.699" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="1.143" x2="-2.5654" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-1.143" x2="-2.5654" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-0.3048" y1="0.762" x2="-0.3048" y2="-0.762" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0.762" x2="0.3302" y2="-0.762" width="0.3048" layer="21"/>
<wire x1="1.27" y1="0" x2="0.3302" y2="0" width="0.1524" layer="51"/>
<wire x1="-1.27" y1="0" x2="-0.3048" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="3" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.81" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.81" y="-2.667" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025_050-025X075" urn="urn:adsk.eagle:footprint:23143/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 + 5 mm, outline 2.5 x 7.5 mm</description>
<wire x1="-2.159" y1="1.27" x2="2.159" y2="1.27" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-1.27" x2="-2.159" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.159" y1="1.27" x2="2.413" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="1.016" x2="-2.159" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-1.27" x2="2.413" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-1.016" x2="-2.159" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<wire x1="4.953" y1="1.016" x2="4.953" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="4.699" y1="1.27" x2="4.953" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="-1.27" x2="4.953" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="2.794" y1="1.27" x2="4.699" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-1.27" x2="2.794" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.413" y2="0.762" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-0.762" x2="2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="0.254" x2="2.413" y2="-0.254" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0" x2="2.286" y2="0" width="0.1524" layer="51"/>
<wire x1="2.286" y1="0" x2="2.794" y2="0" width="0.1524" layer="21"/>
<wire x1="2.794" y1="0" x2="3.302" y2="0" width="0.1524" layer="51"/>
<wire x1="0.762" y1="0" x2="0.381" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="3" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.159" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.159" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025_050-035X075" urn="urn:adsk.eagle:footprint:23144/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 + 5 mm, outline 3.5 x 7.5 mm</description>
<wire x1="-2.159" y1="1.778" x2="2.159" y2="1.778" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-1.778" x2="-2.159" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.524" x2="-2.413" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="2.159" y1="1.778" x2="2.413" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="1.524" x2="-2.159" y2="1.778" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-1.778" x2="2.413" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-1.524" x2="-2.159" y2="-1.778" width="0.1524" layer="21" curve="90"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<wire x1="4.953" y1="1.524" x2="4.953" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.699" y1="1.778" x2="4.953" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="-1.778" x2="4.953" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="2.794" y1="1.778" x2="4.699" y2="1.778" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-1.778" x2="2.794" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.524" x2="2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.413" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="2.413" y1="0.508" x2="2.413" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="0.381" y1="0" x2="0.762" y2="0" width="0.1524" layer="51"/>
<wire x1="2.286" y1="0" x2="2.794" y2="0" width="0.1524" layer="21"/>
<wire x1="2.794" y1="0" x2="3.302" y2="0" width="0.1524" layer="51"/>
<wire x1="2.286" y1="0" x2="1.778" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="3" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="2.159" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-3.302" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025_050-045X075" urn="urn:adsk.eagle:footprint:23145/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 + 5 mm, outline 4.5 x 7.5 mm</description>
<wire x1="-2.159" y1="2.286" x2="2.159" y2="2.286" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-2.286" x2="-2.159" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="2.032" x2="-2.413" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="2.159" y1="2.286" x2="2.413" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="2.032" x2="-2.159" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-2.286" x2="2.413" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-2.032" x2="-2.159" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<wire x1="4.953" y1="2.032" x2="4.953" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="4.699" y1="2.286" x2="4.953" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="-2.286" x2="4.953" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="2.794" y1="2.286" x2="4.699" y2="2.286" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-2.286" x2="2.794" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="2.413" y1="2.032" x2="2.413" y2="1.397" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.397" x2="2.413" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="2.413" y1="0.762" x2="2.413" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="2.286" y1="0" x2="2.794" y2="0" width="0.1524" layer="21"/>
<wire x1="2.794" y1="0" x2="3.302" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.762" y2="0" width="0.1524" layer="51"/>
<wire x1="2.286" y1="0" x2="1.778" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="3" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="2.667" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-3.81" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C025_050-055X075" urn="urn:adsk.eagle:footprint:23146/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 2.5 + 5 mm, outline 5.5 x 7.5 mm</description>
<wire x1="-2.159" y1="2.794" x2="2.159" y2="2.794" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-2.794" x2="-2.159" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="2.54" x2="-2.413" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="2.159" y1="2.794" x2="2.413" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.413" y1="2.54" x2="-2.159" y2="2.794" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.159" y1="-2.794" x2="2.413" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.413" y1="-2.54" x2="-2.159" y2="-2.794" width="0.1524" layer="21" curve="90"/>
<wire x1="0.381" y1="0" x2="0.254" y2="0" width="0.1524" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="0.762" width="0.254" layer="21"/>
<wire x1="0.254" y1="0" x2="0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0.762" x2="-0.254" y2="0" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.254" y2="-0.762" width="0.254" layer="21"/>
<wire x1="-0.254" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="0" x2="-0.762" y2="0" width="0.1524" layer="51"/>
<wire x1="4.953" y1="2.54" x2="4.953" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="4.699" y1="2.794" x2="4.953" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="-2.794" x2="4.953" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="2.794" y1="2.794" x2="4.699" y2="2.794" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-2.794" x2="2.794" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="2.413" y1="2.54" x2="2.413" y2="2.032" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-2.032" x2="2.413" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="2.413" y1="0.762" x2="2.413" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0" x2="2.286" y2="0" width="0.1524" layer="51"/>
<wire x1="2.286" y1="0" x2="2.794" y2="0" width="0.1524" layer="21"/>
<wire x1="2.794" y1="0" x2="3.302" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="0.762" y2="0" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="3" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.286" y="3.175" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.032" y="-2.286" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-024X044" urn="urn:adsk.eagle:footprint:23147/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 2.4 x 4.4 mm</description>
<wire x1="-2.159" y1="-0.635" x2="-2.159" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-2.159" y1="0.635" x2="-1.651" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.159" y1="-0.635" x2="-1.651" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="1.651" y1="1.143" x2="-1.651" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.159" y1="-0.635" x2="2.159" y2="0.635" width="0.1524" layer="51"/>
<wire x1="1.651" y1="-1.143" x2="-1.651" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="1.651" y1="1.143" x2="2.159" y2="0.635" width="0.1524" layer="21" curve="-90"/>
<wire x1="1.651" y1="-1.143" x2="2.159" y2="-0.635" width="0.1524" layer="21" curve="90"/>
<wire x1="-0.3048" y1="0.762" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.762" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0.762" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.762" width="0.3048" layer="21"/>
<wire x1="1.27" y1="0" x2="0.3302" y2="0" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="0" x2="-0.3048" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.159" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.159" y="-2.667" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="2.159" y1="-0.381" x2="2.54" y2="0.381" layer="51"/>
<rectangle x1="-2.54" y1="-0.381" x2="-2.159" y2="0.381" layer="51"/>
</package>
<package name="C050-025X075" urn="urn:adsk.eagle:footprint:23148/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 2.5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="1.016" x2="-3.683" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-1.27" x2="3.429" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-1.016" x2="3.683" y2="1.016" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.27" x2="-3.429" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.27" x2="3.683" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-1.27" x2="3.683" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-1.016" x2="-3.429" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="1.016" x2="-3.429" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.429" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-045X075" urn="urn:adsk.eagle:footprint:23149/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 4.5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="2.032" x2="-3.683" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-2.286" x2="3.429" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-2.032" x2="3.683" y2="2.032" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.286" x2="-3.429" y2="2.286" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.286" x2="3.683" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-2.286" x2="3.683" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-2.032" x2="-3.429" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="2.032" x2="-3.429" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.556" y="2.667" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.556" y="-3.81" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-030X075" urn="urn:adsk.eagle:footprint:23150/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 3 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="1.27" x2="-3.683" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-1.524" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-1.27" x2="3.683" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.524" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.524" x2="3.683" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-1.524" x2="3.683" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-1.27" x2="-3.429" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="1.27" x2="-3.429" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.556" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.556" y="-3.048" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-050X075" urn="urn:adsk.eagle:footprint:23151/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="2.286" x2="-3.683" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-2.54" x2="3.429" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-2.286" x2="3.683" y2="2.286" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.54" x2="-3.429" y2="2.54" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.54" x2="3.683" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-2.54" x2="3.683" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-2.286" x2="-3.429" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="2.286" x2="-3.429" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.429" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-2.159" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-055X075" urn="urn:adsk.eagle:footprint:23152/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 5.5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="2.54" x2="-3.683" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-2.794" x2="3.429" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-2.54" x2="3.683" y2="2.54" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.794" x2="-3.429" y2="2.794" width="0.1524" layer="21"/>
<wire x1="3.429" y1="2.794" x2="3.683" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-2.794" x2="3.683" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-2.54" x2="-3.429" y2="-2.794" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="2.54" x2="-3.429" y2="2.794" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.429" y="3.175" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.302" y="-2.286" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-075X075" urn="urn:adsk.eagle:footprint:23153/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 7.5 x 7.5 mm</description>
<wire x1="-1.524" y1="0" x2="-0.4572" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.4572" y1="0" x2="-0.4572" y2="0.762" width="0.4064" layer="21"/>
<wire x1="-0.4572" y1="0" x2="-0.4572" y2="-0.762" width="0.4064" layer="21"/>
<wire x1="0.4318" y1="0.762" x2="0.4318" y2="0" width="0.4064" layer="21"/>
<wire x1="0.4318" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.4318" y1="0" x2="0.4318" y2="-0.762" width="0.4064" layer="21"/>
<wire x1="-3.683" y1="3.429" x2="-3.683" y2="-3.429" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-3.683" x2="3.429" y2="-3.683" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-3.429" x2="3.683" y2="3.429" width="0.1524" layer="21"/>
<wire x1="3.429" y1="3.683" x2="-3.429" y2="3.683" width="0.1524" layer="21"/>
<wire x1="3.429" y1="3.683" x2="3.683" y2="3.429" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-3.683" x2="3.683" y2="-3.429" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-3.429" x2="-3.429" y2="-3.683" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="3.429" x2="-3.429" y2="3.683" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.429" y="4.064" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-2.921" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050H075X075" urn="urn:adsk.eagle:footprint:23154/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
Horizontal, grid 5 mm, outline 7.5 x 7.5 mm</description>
<wire x1="-3.683" y1="7.112" x2="-3.683" y2="0.508" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="0.508" x2="-3.302" y2="0.508" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="0.508" x2="-1.778" y2="0.508" width="0.1524" layer="51"/>
<wire x1="-1.778" y1="0.508" x2="1.778" y2="0.508" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0.508" x2="3.302" y2="0.508" width="0.1524" layer="51"/>
<wire x1="3.302" y1="0.508" x2="3.683" y2="0.508" width="0.1524" layer="21"/>
<wire x1="3.683" y1="0.508" x2="3.683" y2="7.112" width="0.1524" layer="21"/>
<wire x1="3.175" y1="7.62" x2="-3.175" y2="7.62" width="0.1524" layer="21"/>
<wire x1="-0.3048" y1="2.413" x2="-0.3048" y2="1.778" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="1.778" x2="-0.3048" y2="1.143" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="1.778" x2="-1.651" y2="1.778" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="2.413" x2="0.3302" y2="1.778" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="1.778" x2="0.3302" y2="1.143" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="1.778" x2="1.651" y2="1.778" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="7.112" x2="-3.175" y2="7.62" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.175" y1="7.62" x2="3.683" y2="7.112" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.54" y1="0" x2="-2.54" y2="0.254" width="0.508" layer="51"/>
<wire x1="2.54" y1="0" x2="2.54" y2="0.254" width="0.508" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.302" y="8.001" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="3.175" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-2.794" y1="0.127" x2="-2.286" y2="0.508" layer="51"/>
<rectangle x1="2.286" y1="0.127" x2="2.794" y2="0.508" layer="51"/>
</package>
<package name="C075-032X103" urn="urn:adsk.eagle:footprint:23155/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 7.5 mm, outline 3.2 x 10.3 mm</description>
<wire x1="4.826" y1="1.524" x2="-4.826" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="-1.524" x2="4.826" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-1.27" x2="5.08" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.826" y1="1.524" x2="5.08" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.826" y1="-1.524" x2="5.08" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="-1.27" x2="-4.826" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="1.27" x2="-4.826" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="0.508" y1="0" x2="2.54" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0" x2="-0.508" y2="0" width="0.1524" layer="21"/>
<wire x1="-0.508" y1="0.889" x2="-0.508" y2="0" width="0.4064" layer="21"/>
<wire x1="-0.508" y1="0" x2="-0.508" y2="-0.889" width="0.4064" layer="21"/>
<wire x1="0.508" y1="0.889" x2="0.508" y2="0" width="0.4064" layer="21"/>
<wire x1="0.508" y1="0" x2="0.508" y2="-0.889" width="0.4064" layer="21"/>
<pad name="1" x="-3.81" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.9144" shape="octagon"/>
<text x="-4.826" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.826" y="-3.048" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C075-042X103" urn="urn:adsk.eagle:footprint:23156/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 7.5 mm, outline 4.2 x 10.3 mm</description>
<wire x1="4.826" y1="2.032" x2="-4.826" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="1.778" x2="-5.08" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="-2.032" x2="4.826" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-1.778" x2="5.08" y2="1.778" width="0.1524" layer="21"/>
<wire x1="4.826" y1="2.032" x2="5.08" y2="1.778" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.826" y1="-2.032" x2="5.08" y2="-1.778" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="-1.778" x2="-4.826" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="1.778" x2="-4.826" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.27" y1="0" x2="2.667" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.667" y1="0" x2="-2.159" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.159" y1="1.27" x2="-2.159" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.159" y1="0" x2="-2.159" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-1.27" y1="1.27" x2="-1.27" y2="0" width="0.4064" layer="21"/>
<wire x1="-1.27" y1="0" x2="-1.27" y2="-1.27" width="0.4064" layer="21"/>
<pad name="1" x="-3.81" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.9144" shape="octagon"/>
<text x="-4.699" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.635" y="-1.651" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C075-052X106" urn="urn:adsk.eagle:footprint:23157/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 7.5 mm, outline 5.2 x 10.6 mm</description>
<wire x1="4.953" y1="2.54" x2="-4.953" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="2.286" x2="-5.207" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="-2.54" x2="4.953" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="5.207" y1="-2.286" x2="5.207" y2="2.286" width="0.1524" layer="21"/>
<wire x1="4.953" y1="2.54" x2="5.207" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.953" y1="-2.54" x2="5.207" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.207" y1="-2.286" x2="-4.953" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.207" y1="2.286" x2="-4.953" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.27" y1="0" x2="2.667" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.667" y1="0" x2="-2.159" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.159" y1="1.27" x2="-2.159" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.159" y1="0" x2="-2.159" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-1.27" y1="1.27" x2="-1.27" y2="0" width="0.4064" layer="21"/>
<wire x1="-1.27" y1="0" x2="-1.27" y2="-1.27" width="0.4064" layer="21"/>
<pad name="1" x="-3.81" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.9144" shape="octagon"/>
<text x="-4.826" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.635" y="-2.032" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C102-043X133" urn="urn:adsk.eagle:footprint:23158/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 10.2 mm, outline 4.3 x 13.3 mm</description>
<wire x1="-3.175" y1="1.27" x2="-3.175" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.286" y1="1.27" x2="-2.286" y2="0" width="0.4064" layer="21"/>
<wire x1="3.81" y1="0" x2="-2.286" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="0" x2="-2.286" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-3.81" y1="0" x2="-3.175" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="0" x2="-3.175" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-6.096" y1="2.032" x2="6.096" y2="2.032" width="0.1524" layer="21"/>
<wire x1="6.604" y1="1.524" x2="6.604" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-2.032" x2="-6.096" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="-1.524" x2="-6.604" y2="1.524" width="0.1524" layer="21"/>
<wire x1="6.096" y1="2.032" x2="6.604" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.096" y1="-2.032" x2="6.604" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="-1.524" x2="-6.096" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="1.524" x2="-6.096" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.016" shape="octagon"/>
<text x="-6.096" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.524" y="-1.651" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C102-054X133" urn="urn:adsk.eagle:footprint:23159/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 10.2 mm, outline 5.4 x 13.3 mm</description>
<wire x1="-3.175" y1="1.27" x2="-3.175" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.286" y1="1.27" x2="-2.286" y2="0" width="0.4064" layer="21"/>
<wire x1="3.81" y1="0" x2="-2.286" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="0" x2="-2.286" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-3.81" y1="0" x2="-3.175" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="0" x2="-3.175" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-6.096" y1="2.54" x2="6.096" y2="2.54" width="0.1524" layer="21"/>
<wire x1="6.604" y1="2.032" x2="6.604" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-2.54" x2="-6.096" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="-2.032" x2="-6.604" y2="2.032" width="0.1524" layer="21"/>
<wire x1="6.096" y1="2.54" x2="6.604" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.096" y1="-2.54" x2="6.604" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="-2.032" x2="-6.096" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="2.032" x2="-6.096" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.016" shape="octagon"/>
<text x="-6.096" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.524" y="-1.905" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C102-064X133" urn="urn:adsk.eagle:footprint:23160/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 10.2 mm, outline 6.4 x 13.3 mm</description>
<wire x1="-3.175" y1="1.27" x2="-3.175" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.286" y1="1.27" x2="-2.286" y2="0" width="0.4064" layer="21"/>
<wire x1="3.81" y1="0" x2="-2.286" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="0" x2="-2.286" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-3.81" y1="0" x2="-3.175" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="0" x2="-3.175" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-6.096" y1="3.048" x2="6.096" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.604" y1="2.54" x2="6.604" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-3.048" x2="-6.096" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="-2.54" x2="-6.604" y2="2.54" width="0.1524" layer="21"/>
<wire x1="6.096" y1="3.048" x2="6.604" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.096" y1="-3.048" x2="6.604" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="-2.54" x2="-6.096" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="2.54" x2="-6.096" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.016" shape="octagon"/>
<text x="-6.096" y="3.429" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.524" y="-2.032" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C102_152-062X184" urn="urn:adsk.eagle:footprint:23161/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 10.2 mm + 15.2 mm, outline 6.2 x 18.4 mm</description>
<wire x1="-2.286" y1="1.27" x2="-2.286" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.286" y1="0" x2="-2.286" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-3.175" y2="0" width="0.4064" layer="21"/>
<wire x1="-3.175" y1="0" x2="-3.175" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-3.683" y1="0" x2="-3.175" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="0" x2="3.683" y2="0" width="0.1524" layer="21"/>
<wire x1="6.477" y1="0" x2="8.636" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.096" y1="3.048" x2="6.223" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.223" y1="-3.048" x2="-6.096" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="-2.54" x2="-6.604" y2="2.54" width="0.1524" layer="21"/>
<wire x1="6.223" y1="3.048" x2="6.731" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.223" y1="-3.048" x2="6.731" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="-2.54" x2="-6.096" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-6.604" y1="2.54" x2="-6.096" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.731" y1="2.54" x2="6.731" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="11.176" y1="3.048" x2="11.684" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="11.176" y1="-3.048" x2="11.684" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="11.176" y1="-3.048" x2="7.112" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="7.112" y1="3.048" x2="11.176" y2="3.048" width="0.1524" layer="21"/>
<wire x1="11.684" y1="2.54" x2="11.684" y2="-2.54" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="3" x="10.033" y="0" drill="1.016" shape="octagon"/>
<text x="-5.969" y="3.429" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.524" y="-2.286" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C150-054X183" urn="urn:adsk.eagle:footprint:23162/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 15 mm, outline 5.4 x 18.3 mm</description>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="0" width="0.4064" layer="21"/>
<wire x1="-5.08" y1="0" x2="-5.08" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="1.27" x2="-4.191" y2="0" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="-4.191" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0" x2="-6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="9.017" y1="2.032" x2="9.017" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-2.54" x2="-8.509" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-9.017" y1="-2.032" x2="-9.017" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-8.509" y1="2.54" x2="8.509" y2="2.54" width="0.1524" layer="21"/>
<wire x1="8.509" y1="2.54" x2="9.017" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.509" y1="-2.54" x2="9.017" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="-2.032" x2="-8.509" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="2.032" x2="-8.509" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-7.493" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.493" y="0" drill="1.016" shape="octagon"/>
<text x="-8.382" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.032" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C150-064X183" urn="urn:adsk.eagle:footprint:23163/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 15 mm, outline 6.4 x 18.3 mm</description>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="0" width="0.4064" layer="21"/>
<wire x1="-5.08" y1="0" x2="-5.08" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="1.27" x2="-4.191" y2="0" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="-4.191" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0" x2="-6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="9.017" y1="2.54" x2="9.017" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-3.048" x2="-8.509" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-9.017" y1="-2.54" x2="-9.017" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-8.509" y1="3.048" x2="8.509" y2="3.048" width="0.1524" layer="21"/>
<wire x1="8.509" y1="3.048" x2="9.017" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.509" y1="-3.048" x2="9.017" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="-2.54" x2="-8.509" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="2.54" x2="-8.509" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-7.493" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.493" y="0" drill="1.016" shape="octagon"/>
<text x="-8.509" y="3.429" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.032" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C150-072X183" urn="urn:adsk.eagle:footprint:23164/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 15 mm, outline 7.2 x 18.3 mm</description>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="0" width="0.4064" layer="21"/>
<wire x1="-5.08" y1="0" x2="-5.08" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="1.27" x2="-4.191" y2="0" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="-4.191" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0" x2="-6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="9.017" y1="3.048" x2="9.017" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-3.556" x2="-8.509" y2="-3.556" width="0.1524" layer="21"/>
<wire x1="-9.017" y1="-3.048" x2="-9.017" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-8.509" y1="3.556" x2="8.509" y2="3.556" width="0.1524" layer="21"/>
<wire x1="8.509" y1="3.556" x2="9.017" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.509" y1="-3.556" x2="9.017" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="-3.048" x2="-8.509" y2="-3.556" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="3.048" x2="-8.509" y2="3.556" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-7.493" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.493" y="0" drill="1.016" shape="octagon"/>
<text x="-8.509" y="3.937" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.286" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C150-084X183" urn="urn:adsk.eagle:footprint:23165/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 15 mm, outline 8.4 x 18.3 mm</description>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="0" width="0.4064" layer="21"/>
<wire x1="-5.08" y1="0" x2="-5.08" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="1.27" x2="-4.191" y2="0" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="-4.191" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0" x2="-6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="9.017" y1="3.556" x2="9.017" y2="-3.556" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-4.064" x2="-8.509" y2="-4.064" width="0.1524" layer="21"/>
<wire x1="-9.017" y1="-3.556" x2="-9.017" y2="3.556" width="0.1524" layer="21"/>
<wire x1="-8.509" y1="4.064" x2="8.509" y2="4.064" width="0.1524" layer="21"/>
<wire x1="8.509" y1="4.064" x2="9.017" y2="3.556" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.509" y1="-4.064" x2="9.017" y2="-3.556" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="-3.556" x2="-8.509" y2="-4.064" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="3.556" x2="-8.509" y2="4.064" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-7.493" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.493" y="0" drill="1.016" shape="octagon"/>
<text x="-8.509" y="4.445" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.54" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C150-091X182" urn="urn:adsk.eagle:footprint:23166/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 15 mm, outline 9.1 x 18.2 mm</description>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="0" width="0.4064" layer="21"/>
<wire x1="-5.08" y1="0" x2="-5.08" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="1.27" x2="-4.191" y2="0" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="-4.191" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-4.191" y1="0" x2="6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0" x2="-6.096" y2="0" width="0.1524" layer="21"/>
<wire x1="9.017" y1="3.937" x2="9.017" y2="-3.937" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-4.445" x2="-8.509" y2="-4.445" width="0.1524" layer="21"/>
<wire x1="-9.017" y1="-3.937" x2="-9.017" y2="3.937" width="0.1524" layer="21"/>
<wire x1="-8.509" y1="4.445" x2="8.509" y2="4.445" width="0.1524" layer="21"/>
<wire x1="8.509" y1="4.445" x2="9.017" y2="3.937" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.509" y1="-4.445" x2="9.017" y2="-3.937" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="-3.937" x2="-8.509" y2="-4.445" width="0.1524" layer="21" curve="90"/>
<wire x1="-9.017" y1="3.937" x2="-8.509" y2="4.445" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-7.493" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.493" y="0" drill="1.016" shape="octagon"/>
<text x="-8.509" y="4.826" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.429" y="-2.54" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C225-062X268" urn="urn:adsk.eagle:footprint:23167/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 22.5 mm, outline 6.2 x 26.8 mm</description>
<wire x1="-12.827" y1="3.048" x2="12.827" y2="3.048" width="0.1524" layer="21"/>
<wire x1="13.335" y1="2.54" x2="13.335" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="12.827" y1="-3.048" x2="-12.827" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-2.54" x2="-13.335" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="12.827" y1="3.048" x2="13.335" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="12.827" y1="-3.048" x2="13.335" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="-2.54" x2="-12.827" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="2.54" x2="-12.827" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="-9.652" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="9.652" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-11.303" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.303" y="0" drill="1.016" shape="octagon"/>
<text x="-12.7" y="3.429" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C225-074X268" urn="urn:adsk.eagle:footprint:23168/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 22.5 mm, outline 7.4 x 26.8 mm</description>
<wire x1="-12.827" y1="3.556" x2="12.827" y2="3.556" width="0.1524" layer="21"/>
<wire x1="13.335" y1="3.048" x2="13.335" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="12.827" y1="-3.556" x2="-12.827" y2="-3.556" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-3.048" x2="-13.335" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="12.827" y1="3.556" x2="13.335" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="12.827" y1="-3.556" x2="13.335" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="-3.048" x2="-12.827" y2="-3.556" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="3.048" x2="-12.827" y2="3.556" width="0.1524" layer="21" curve="-90"/>
<wire x1="-9.652" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="9.652" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-11.303" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.303" y="0" drill="1.016" shape="octagon"/>
<text x="-12.827" y="3.937" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C225-087X268" urn="urn:adsk.eagle:footprint:23169/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 22.5 mm, outline 8.7 x 26.8 mm</description>
<wire x1="-12.827" y1="4.318" x2="12.827" y2="4.318" width="0.1524" layer="21"/>
<wire x1="13.335" y1="3.81" x2="13.335" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="12.827" y1="-4.318" x2="-12.827" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-3.81" x2="-13.335" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="12.827" y1="4.318" x2="13.335" y2="3.81" width="0.1524" layer="21" curve="-90"/>
<wire x1="12.827" y1="-4.318" x2="13.335" y2="-3.81" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="-3.81" x2="-12.827" y2="-4.318" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="3.81" x2="-12.827" y2="4.318" width="0.1524" layer="21" curve="-90"/>
<wire x1="-9.652" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="9.652" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-11.303" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.303" y="0" drill="1.016" shape="octagon"/>
<text x="-12.827" y="4.699" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C225-108X268" urn="urn:adsk.eagle:footprint:23170/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 22.5 mm, outline 10.8 x 26.8 mm</description>
<wire x1="-12.827" y1="5.334" x2="12.827" y2="5.334" width="0.1524" layer="21"/>
<wire x1="13.335" y1="4.826" x2="13.335" y2="-4.826" width="0.1524" layer="21"/>
<wire x1="12.827" y1="-5.334" x2="-12.827" y2="-5.334" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-4.826" x2="-13.335" y2="4.826" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="12.827" y1="5.334" x2="13.335" y2="4.826" width="0.1524" layer="21" curve="-90"/>
<wire x1="12.827" y1="-5.334" x2="13.335" y2="-4.826" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="-4.826" x2="-12.827" y2="-5.334" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="4.826" x2="-12.827" y2="5.334" width="0.1524" layer="21" curve="-90"/>
<wire x1="-9.652" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="9.652" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-11.303" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.303" y="0" drill="1.016" shape="octagon"/>
<text x="-12.954" y="5.715" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C225-113X268" urn="urn:adsk.eagle:footprint:23171/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 22.5 mm, outline 11.3 x 26.8 mm</description>
<wire x1="-12.827" y1="5.588" x2="12.827" y2="5.588" width="0.1524" layer="21"/>
<wire x1="13.335" y1="5.08" x2="13.335" y2="-5.08" width="0.1524" layer="21"/>
<wire x1="12.827" y1="-5.588" x2="-12.827" y2="-5.588" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-5.08" x2="-13.335" y2="5.08" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="12.827" y1="5.588" x2="13.335" y2="5.08" width="0.1524" layer="21" curve="-90"/>
<wire x1="12.827" y1="-5.588" x2="13.335" y2="-5.08" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="-5.08" x2="-12.827" y2="-5.588" width="0.1524" layer="21" curve="90"/>
<wire x1="-13.335" y1="5.08" x2="-12.827" y2="5.588" width="0.1524" layer="21" curve="-90"/>
<wire x1="-9.652" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="9.652" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-11.303" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.303" y="0" drill="1.016" shape="octagon"/>
<text x="-12.954" y="5.969" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C275-093X316" urn="urn:adsk.eagle:footprint:23172/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 27.5 mm, outline 9.3 x 31.6 mm</description>
<wire x1="-15.24" y1="4.572" x2="15.24" y2="4.572" width="0.1524" layer="21"/>
<wire x1="15.748" y1="4.064" x2="15.748" y2="-4.064" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-4.572" x2="-15.24" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="-15.748" y1="-4.064" x2="-15.748" y2="4.064" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="15.24" y1="4.572" x2="15.748" y2="4.064" width="0.1524" layer="21" curve="-90"/>
<wire x1="15.24" y1="-4.572" x2="15.748" y2="-4.064" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="-4.064" x2="-15.24" y2="-4.572" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="4.064" x2="-15.24" y2="4.572" width="0.1524" layer="21" curve="-90"/>
<wire x1="-11.557" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="11.557" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-13.716" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="13.716" y="0" drill="1.1938" shape="octagon"/>
<text x="-15.24" y="4.953" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C275-113X316" urn="urn:adsk.eagle:footprint:23173/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 27.5 mm, outline 11.3 x 31.6 mm</description>
<wire x1="-15.24" y1="5.588" x2="15.24" y2="5.588" width="0.1524" layer="21"/>
<wire x1="15.748" y1="5.08" x2="15.748" y2="-5.08" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-5.588" x2="-15.24" y2="-5.588" width="0.1524" layer="21"/>
<wire x1="-15.748" y1="-5.08" x2="-15.748" y2="5.08" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="15.24" y1="5.588" x2="15.748" y2="5.08" width="0.1524" layer="21" curve="-90"/>
<wire x1="15.24" y1="-5.588" x2="15.748" y2="-5.08" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="-5.08" x2="-15.24" y2="-5.588" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="5.08" x2="-15.24" y2="5.588" width="0.1524" layer="21" curve="-90"/>
<wire x1="-11.557" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="11.557" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-13.716" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="13.716" y="0" drill="1.1938" shape="octagon"/>
<text x="-15.24" y="5.969" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C275-134X316" urn="urn:adsk.eagle:footprint:23174/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 27.5 mm, outline 13.4 x 31.6 mm</description>
<wire x1="-15.24" y1="6.604" x2="15.24" y2="6.604" width="0.1524" layer="21"/>
<wire x1="15.748" y1="6.096" x2="15.748" y2="-6.096" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-6.604" x2="-15.24" y2="-6.604" width="0.1524" layer="21"/>
<wire x1="-15.748" y1="-6.096" x2="-15.748" y2="6.096" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="15.24" y1="6.604" x2="15.748" y2="6.096" width="0.1524" layer="21" curve="-90"/>
<wire x1="15.24" y1="-6.604" x2="15.748" y2="-6.096" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="-6.096" x2="-15.24" y2="-6.604" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="6.096" x2="-15.24" y2="6.604" width="0.1524" layer="21" curve="-90"/>
<wire x1="-11.557" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="11.557" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-13.716" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="13.716" y="0" drill="1.1938" shape="octagon"/>
<text x="-15.24" y="6.985" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C275-205X316" urn="urn:adsk.eagle:footprint:23175/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 27.5 mm, outline 20.5 x 31.6 mm</description>
<wire x1="-15.24" y1="10.16" x2="15.24" y2="10.16" width="0.1524" layer="21"/>
<wire x1="15.748" y1="9.652" x2="15.748" y2="-9.652" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-10.16" x2="-15.24" y2="-10.16" width="0.1524" layer="21"/>
<wire x1="-15.748" y1="-9.652" x2="-15.748" y2="9.652" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="15.24" y1="10.16" x2="15.748" y2="9.652" width="0.1524" layer="21" curve="-90"/>
<wire x1="15.24" y1="-10.16" x2="15.748" y2="-9.652" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="-9.652" x2="-15.24" y2="-10.16" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="9.652" x2="-15.24" y2="10.16" width="0.1524" layer="21" curve="-90"/>
<wire x1="-11.557" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="11.557" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-13.716" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="13.716" y="0" drill="1.1938" shape="octagon"/>
<text x="-15.24" y="10.541" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-4.318" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C325-137X374" urn="urn:adsk.eagle:footprint:23176/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 32.5 mm, outline 13.7 x 37.4 mm</description>
<wire x1="-14.2748" y1="0" x2="-12.7" y2="0" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="1.905" x2="-12.7" y2="0" width="0.4064" layer="21"/>
<wire x1="-11.811" y1="1.905" x2="-11.811" y2="0" width="0.4064" layer="21"/>
<wire x1="-11.811" y1="0" x2="14.2748" y2="0" width="0.1524" layer="21"/>
<wire x1="-11.811" y1="0" x2="-11.811" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-12.7" y1="0" x2="-12.7" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="18.542" y1="6.731" x2="18.542" y2="-6.731" width="0.1524" layer="21"/>
<wire x1="-18.542" y1="6.731" x2="-18.542" y2="-6.731" width="0.1524" layer="21"/>
<wire x1="-18.542" y1="-6.731" x2="18.542" y2="-6.731" width="0.1524" layer="21"/>
<wire x1="18.542" y1="6.731" x2="-18.542" y2="6.731" width="0.1524" layer="21"/>
<pad name="1" x="-16.256" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="16.256" y="0" drill="1.1938" shape="octagon"/>
<text x="-18.2372" y="7.0612" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-10.8458" y="-2.8702" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C325-162X374" urn="urn:adsk.eagle:footprint:23177/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 32.5 mm, outline 16.2 x 37.4 mm</description>
<wire x1="-14.2748" y1="0" x2="-12.7" y2="0" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="1.905" x2="-12.7" y2="0" width="0.4064" layer="21"/>
<wire x1="-11.811" y1="1.905" x2="-11.811" y2="0" width="0.4064" layer="21"/>
<wire x1="-11.811" y1="0" x2="14.2748" y2="0" width="0.1524" layer="21"/>
<wire x1="-11.811" y1="0" x2="-11.811" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-12.7" y1="0" x2="-12.7" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="18.542" y1="8.001" x2="18.542" y2="-8.001" width="0.1524" layer="21"/>
<wire x1="-18.542" y1="8.001" x2="-18.542" y2="-8.001" width="0.1524" layer="21"/>
<wire x1="-18.542" y1="-8.001" x2="18.542" y2="-8.001" width="0.1524" layer="21"/>
<wire x1="18.542" y1="8.001" x2="-18.542" y2="8.001" width="0.1524" layer="21"/>
<pad name="1" x="-16.256" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="16.256" y="0" drill="1.1938" shape="octagon"/>
<text x="-18.3642" y="8.3312" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-10.8458" y="-2.8702" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C325-182X374" urn="urn:adsk.eagle:footprint:23178/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 32.5 mm, outline 18.2 x 37.4 mm</description>
<wire x1="-14.2748" y1="0" x2="-12.7" y2="0" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="1.905" x2="-12.7" y2="0" width="0.4064" layer="21"/>
<wire x1="-11.811" y1="1.905" x2="-11.811" y2="0" width="0.4064" layer="21"/>
<wire x1="-11.811" y1="0" x2="14.2748" y2="0" width="0.1524" layer="21"/>
<wire x1="-11.811" y1="0" x2="-11.811" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-12.7" y1="0" x2="-12.7" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="18.542" y1="9.017" x2="18.542" y2="-9.017" width="0.1524" layer="21"/>
<wire x1="-18.542" y1="9.017" x2="-18.542" y2="-9.017" width="0.1524" layer="21"/>
<wire x1="-18.542" y1="-9.017" x2="18.542" y2="-9.017" width="0.1524" layer="21"/>
<wire x1="18.542" y1="9.017" x2="-18.542" y2="9.017" width="0.1524" layer="21"/>
<pad name="1" x="-16.256" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="16.256" y="0" drill="1.1938" shape="octagon"/>
<text x="-18.3642" y="9.3472" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-10.8458" y="-2.8702" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C375-192X418" urn="urn:adsk.eagle:footprint:23179/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 37.5 mm, outline 19.2 x 41.8 mm</description>
<wire x1="-20.32" y1="8.509" x2="20.32" y2="8.509" width="0.1524" layer="21"/>
<wire x1="20.828" y1="8.001" x2="20.828" y2="-8.001" width="0.1524" layer="21"/>
<wire x1="20.32" y1="-8.509" x2="-20.32" y2="-8.509" width="0.1524" layer="21"/>
<wire x1="-20.828" y1="-8.001" x2="-20.828" y2="8.001" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="20.32" y1="8.509" x2="20.828" y2="8.001" width="0.1524" layer="21" curve="-90"/>
<wire x1="20.32" y1="-8.509" x2="20.828" y2="-8.001" width="0.1524" layer="21" curve="90"/>
<wire x1="-20.828" y1="-8.001" x2="-20.32" y2="-8.509" width="0.1524" layer="21" curve="90"/>
<wire x1="-20.828" y1="8.001" x2="-20.32" y2="8.509" width="0.1524" layer="21" curve="-90"/>
<wire x1="-16.002" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="16.002" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-18.796" y="0" drill="1.3208" shape="octagon"/>
<pad name="2" x="18.796" y="0" drill="1.3208" shape="octagon"/>
<text x="-20.447" y="8.89" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C375-203X418" urn="urn:adsk.eagle:footprint:23180/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 37.5 mm, outline 20.3 x 41.8 mm</description>
<wire x1="-20.32" y1="10.16" x2="20.32" y2="10.16" width="0.1524" layer="21"/>
<wire x1="20.828" y1="9.652" x2="20.828" y2="-9.652" width="0.1524" layer="21"/>
<wire x1="20.32" y1="-10.16" x2="-20.32" y2="-10.16" width="0.1524" layer="21"/>
<wire x1="-20.828" y1="-9.652" x2="-20.828" y2="9.652" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="20.32" y1="10.16" x2="20.828" y2="9.652" width="0.1524" layer="21" curve="-90"/>
<wire x1="20.32" y1="-10.16" x2="20.828" y2="-9.652" width="0.1524" layer="21" curve="90"/>
<wire x1="-20.828" y1="-9.652" x2="-20.32" y2="-10.16" width="0.1524" layer="21" curve="90"/>
<wire x1="-20.828" y1="9.652" x2="-20.32" y2="10.16" width="0.1524" layer="21" curve="-90"/>
<wire x1="-16.002" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="16.002" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-18.796" y="0" drill="1.3208" shape="octagon"/>
<pad name="2" x="18.796" y="0" drill="1.3208" shape="octagon"/>
<text x="-20.32" y="10.541" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C050-035X075" urn="urn:adsk.eagle:footprint:23181/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 5 mm, outline 3.5 x 7.5 mm</description>
<wire x1="-0.3048" y1="0.635" x2="-0.3048" y2="0" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-0.3048" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="-0.3048" y1="0" x2="-1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="0.3302" y1="0.635" x2="0.3302" y2="0" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="0.3302" y2="-0.635" width="0.3048" layer="21"/>
<wire x1="0.3302" y1="0" x2="1.524" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.683" y1="1.524" x2="-3.683" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="-1.778" x2="3.429" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="3.683" y1="-1.524" x2="3.683" y2="1.524" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.778" x2="-3.429" y2="1.778" width="0.1524" layer="21"/>
<wire x1="3.429" y1="1.778" x2="3.683" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="3.429" y1="-1.778" x2="3.683" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="-1.524" x2="-3.429" y2="-1.778" width="0.1524" layer="21" curve="90"/>
<wire x1="-3.683" y1="1.524" x2="-3.429" y2="1.778" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.556" y="2.159" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.556" y="-3.429" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C375-155X418" urn="urn:adsk.eagle:footprint:23182/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 37.5 mm, outline 15.5 x 41.8 mm</description>
<wire x1="-20.32" y1="7.62" x2="20.32" y2="7.62" width="0.1524" layer="21"/>
<wire x1="20.828" y1="7.112" x2="20.828" y2="-7.112" width="0.1524" layer="21"/>
<wire x1="20.32" y1="-7.62" x2="-20.32" y2="-7.62" width="0.1524" layer="21"/>
<wire x1="-20.828" y1="-7.112" x2="-20.828" y2="7.112" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="20.32" y1="7.62" x2="20.828" y2="7.112" width="0.1524" layer="21" curve="-90"/>
<wire x1="20.32" y1="-7.62" x2="20.828" y2="-7.112" width="0.1524" layer="21" curve="90"/>
<wire x1="-20.828" y1="-7.112" x2="-20.32" y2="-7.62" width="0.1524" layer="21" curve="90"/>
<wire x1="-20.828" y1="7.112" x2="-20.32" y2="7.62" width="0.1524" layer="21" curve="-90"/>
<wire x1="-16.002" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="16.002" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-18.796" y="0" drill="1.3208" shape="octagon"/>
<pad name="2" x="18.796" y="0" drill="1.3208" shape="octagon"/>
<text x="-20.447" y="8.001" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C075-063X106" urn="urn:adsk.eagle:footprint:23183/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 7.5 mm, outline 6.3 x 10.6 mm</description>
<wire x1="4.953" y1="3.048" x2="-4.953" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="2.794" x2="-5.207" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="-3.048" x2="4.953" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="5.207" y1="-2.794" x2="5.207" y2="2.794" width="0.1524" layer="21"/>
<wire x1="4.953" y1="3.048" x2="5.207" y2="2.794" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.953" y1="-3.048" x2="5.207" y2="-2.794" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.207" y1="-2.794" x2="-4.953" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.207" y1="2.794" x2="-4.953" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.27" y1="0" x2="2.667" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.667" y1="0" x2="-2.159" y2="0" width="0.1524" layer="21"/>
<wire x1="-2.159" y1="1.27" x2="-2.159" y2="0" width="0.4064" layer="21"/>
<wire x1="-2.159" y1="0" x2="-2.159" y2="-1.27" width="0.4064" layer="21"/>
<wire x1="-1.27" y1="1.27" x2="-1.27" y2="0" width="0.4064" layer="21"/>
<wire x1="-1.27" y1="0" x2="-1.27" y2="-1.27" width="0.4064" layer="21"/>
<pad name="1" x="-3.81" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.9144" shape="octagon"/>
<text x="-4.826" y="3.429" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C275-154X316" urn="urn:adsk.eagle:footprint:23184/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 27.5 mm, outline 15.4 x 31.6 mm</description>
<wire x1="-15.24" y1="7.62" x2="15.24" y2="7.62" width="0.1524" layer="21"/>
<wire x1="15.748" y1="7.112" x2="15.748" y2="-7.112" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-7.62" x2="-15.24" y2="-7.62" width="0.1524" layer="21"/>
<wire x1="-15.748" y1="-7.112" x2="-15.748" y2="7.112" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="15.24" y1="7.62" x2="15.748" y2="7.112" width="0.1524" layer="21" curve="-90"/>
<wire x1="15.24" y1="-7.62" x2="15.748" y2="-7.112" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="-7.112" x2="-15.24" y2="-7.62" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="7.112" x2="-15.24" y2="7.62" width="0.1524" layer="21" curve="-90"/>
<wire x1="-11.557" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="11.557" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-13.716" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="13.716" y="0" drill="1.1938" shape="octagon"/>
<text x="-15.24" y="8.001" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C275-173X316" urn="urn:adsk.eagle:footprint:23185/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
grid 27.5 mm, outline 17.3 x 31.6 mm</description>
<wire x1="-15.24" y1="8.509" x2="15.24" y2="8.509" width="0.1524" layer="21"/>
<wire x1="15.748" y1="8.001" x2="15.748" y2="-8.001" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-8.509" x2="-15.24" y2="-8.509" width="0.1524" layer="21"/>
<wire x1="-15.748" y1="-8.001" x2="-15.748" y2="8.001" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="1.905" x2="-6.731" y2="0" width="0.4064" layer="21"/>
<wire x1="-6.731" y1="0" x2="-6.731" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-7.62" y2="0" width="0.4064" layer="21"/>
<wire x1="-7.62" y1="0" x2="-7.62" y2="-1.905" width="0.4064" layer="21"/>
<wire x1="15.24" y1="8.509" x2="15.748" y2="8.001" width="0.1524" layer="21" curve="-90"/>
<wire x1="15.24" y1="-8.509" x2="15.748" y2="-8.001" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="-8.001" x2="-15.24" y2="-8.509" width="0.1524" layer="21" curve="90"/>
<wire x1="-15.748" y1="8.001" x2="-15.24" y2="8.509" width="0.1524" layer="21" curve="-90"/>
<wire x1="-11.557" y1="0" x2="-7.62" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="0" x2="11.557" y2="0" width="0.1524" layer="21"/>
<pad name="1" x="-13.716" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="13.716" y="0" drill="1.1938" shape="octagon"/>
<text x="-15.24" y="8.89" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-2.54" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="C0402K" urn="urn:adsk.eagle:footprint:23186/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 0204 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 1005</description>
<wire x1="-0.425" y1="0.2" x2="0.425" y2="0.2" width="0.1016" layer="51"/>
<wire x1="0.425" y1="-0.2" x2="-0.425" y2="-0.2" width="0.1016" layer="51"/>
<smd name="1" x="-0.6" y="0" dx="0.925" dy="0.74" layer="1"/>
<smd name="2" x="0.6" y="0" dx="0.925" dy="0.74" layer="1"/>
<text x="-0.5" y="0.425" size="1.016" layer="25">&gt;NAME</text>
<text x="-0.5" y="-1.45" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-0.5" y1="-0.25" x2="-0.225" y2="0.25" layer="51"/>
<rectangle x1="0.225" y1="-0.25" x2="0.5" y2="0.25" layer="51"/>
</package>
<package name="C0603K" urn="urn:adsk.eagle:footprint:23187/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 0603 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 1608</description>
<wire x1="-0.725" y1="0.35" x2="0.725" y2="0.35" width="0.1016" layer="51"/>
<wire x1="0.725" y1="-0.35" x2="-0.725" y2="-0.35" width="0.1016" layer="51"/>
<smd name="1" x="-0.875" y="0" dx="1.05" dy="1.08" layer="1"/>
<smd name="2" x="0.875" y="0" dx="1.05" dy="1.08" layer="1"/>
<text x="-0.8" y="0.65" size="1.016" layer="25">&gt;NAME</text>
<text x="-0.8" y="-1.65" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-0.8" y1="-0.4" x2="-0.45" y2="0.4" layer="51"/>
<rectangle x1="0.45" y1="-0.4" x2="0.8" y2="0.4" layer="51"/>
</package>
<package name="C0805K" urn="urn:adsk.eagle:footprint:23188/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 0805 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 2012</description>
<wire x1="-0.925" y1="0.6" x2="0.925" y2="0.6" width="0.1016" layer="51"/>
<wire x1="0.925" y1="-0.6" x2="-0.925" y2="-0.6" width="0.1016" layer="51"/>
<smd name="1" x="-1" y="0" dx="1.3" dy="1.6" layer="1"/>
<smd name="2" x="1" y="0" dx="1.3" dy="1.6" layer="1"/>
<text x="-1" y="0.875" size="1.016" layer="25">&gt;NAME</text>
<text x="-1" y="-1.9" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-1" y1="-0.65" x2="-0.5" y2="0.65" layer="51"/>
<rectangle x1="0.5" y1="-0.65" x2="1" y2="0.65" layer="51"/>
</package>
<package name="C1206K" urn="urn:adsk.eagle:footprint:23189/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 1206 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 3216</description>
<wire x1="-1.525" y1="0.75" x2="1.525" y2="0.75" width="0.1016" layer="51"/>
<wire x1="1.525" y1="-0.75" x2="-1.525" y2="-0.75" width="0.1016" layer="51"/>
<smd name="1" x="-1.5" y="0" dx="1.5" dy="2" layer="1"/>
<smd name="2" x="1.5" y="0" dx="1.5" dy="2" layer="1"/>
<text x="-1.6" y="1.1" size="1.016" layer="25">&gt;NAME</text>
<text x="-1.6" y="-2.1" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-1.6" y1="-0.8" x2="-1.1" y2="0.8" layer="51"/>
<rectangle x1="1.1" y1="-0.8" x2="1.6" y2="0.8" layer="51"/>
</package>
<package name="C1210K" urn="urn:adsk.eagle:footprint:23190/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 1210 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 3225</description>
<wire x1="-1.525" y1="1.175" x2="1.525" y2="1.175" width="0.1016" layer="51"/>
<wire x1="1.525" y1="-1.175" x2="-1.525" y2="-1.175" width="0.1016" layer="51"/>
<smd name="1" x="-1.5" y="0" dx="1.5" dy="2.9" layer="1"/>
<smd name="2" x="1.5" y="0" dx="1.5" dy="2.9" layer="1"/>
<text x="-1.6" y="1.55" size="1.016" layer="25">&gt;NAME</text>
<text x="-1.6" y="-2.575" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-1.6" y1="-1.25" x2="-1.1" y2="1.25" layer="51"/>
<rectangle x1="1.1" y1="-1.25" x2="1.6" y2="1.25" layer="51"/>
</package>
<package name="C1812K" urn="urn:adsk.eagle:footprint:23191/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 1812 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 4532</description>
<wire x1="-2.175" y1="1.525" x2="2.175" y2="1.525" width="0.1016" layer="51"/>
<wire x1="2.175" y1="-1.525" x2="-2.175" y2="-1.525" width="0.1016" layer="51"/>
<smd name="1" x="-2.05" y="0" dx="1.8" dy="3.7" layer="1"/>
<smd name="2" x="2.05" y="0" dx="1.8" dy="3.7" layer="1"/>
<text x="-2.25" y="1.95" size="1.016" layer="25">&gt;NAME</text>
<text x="-2.25" y="-2.975" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-2.25" y1="-1.6" x2="-1.65" y2="1.6" layer="51"/>
<rectangle x1="1.65" y1="-1.6" x2="2.25" y2="1.6" layer="51"/>
</package>
<package name="C1825K" urn="urn:adsk.eagle:footprint:23192/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 1825 reflow solder&lt;/b&gt;&lt;p&gt;
Metric Code Size 4564</description>
<wire x1="-1.525" y1="3.125" x2="1.525" y2="3.125" width="0.1016" layer="51"/>
<wire x1="1.525" y1="-3.125" x2="-1.525" y2="-3.125" width="0.1016" layer="51"/>
<smd name="1" x="-1.5" y="0" dx="1.8" dy="6.9" layer="1"/>
<smd name="2" x="1.5" y="0" dx="1.8" dy="6.9" layer="1"/>
<text x="-1.6" y="3.55" size="1.016" layer="25">&gt;NAME</text>
<text x="-1.6" y="-4.625" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-1.6" y1="-3.2" x2="-1.1" y2="3.2" layer="51"/>
<rectangle x1="1.1" y1="-3.2" x2="1.6" y2="3.2" layer="51"/>
</package>
<package name="C2220K" urn="urn:adsk.eagle:footprint:23193/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 2220 reflow solder&lt;/b&gt;&lt;p&gt;Metric Code Size 5650</description>
<wire x1="-2.725" y1="2.425" x2="2.725" y2="2.425" width="0.1016" layer="51"/>
<wire x1="2.725" y1="-2.425" x2="-2.725" y2="-2.425" width="0.1016" layer="51"/>
<smd name="1" x="-2.55" y="0" dx="1.85" dy="5.5" layer="1"/>
<smd name="2" x="2.55" y="0" dx="1.85" dy="5.5" layer="1"/>
<text x="-2.8" y="2.95" size="1.016" layer="25">&gt;NAME</text>
<text x="-2.8" y="-3.975" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-2.8" y1="-2.5" x2="-2.2" y2="2.5" layer="51"/>
<rectangle x1="2.2" y1="-2.5" x2="2.8" y2="2.5" layer="51"/>
</package>
<package name="C2225K" urn="urn:adsk.eagle:footprint:23194/1" library_version="11">
<description>&lt;b&gt;Ceramic Chip Capacitor KEMET 2225 reflow solder&lt;/b&gt;&lt;p&gt;Metric Code Size 5664</description>
<wire x1="-2.725" y1="3.075" x2="2.725" y2="3.075" width="0.1016" layer="51"/>
<wire x1="2.725" y1="-3.075" x2="-2.725" y2="-3.075" width="0.1016" layer="51"/>
<smd name="1" x="-2.55" y="0" dx="1.85" dy="6.8" layer="1"/>
<smd name="2" x="2.55" y="0" dx="1.85" dy="6.8" layer="1"/>
<text x="-2.8" y="3.6" size="1.016" layer="25">&gt;NAME</text>
<text x="-2.8" y="-4.575" size="1.016" layer="27">&gt;VALUE</text>
<rectangle x1="-2.8" y1="-3.15" x2="-2.2" y2="3.15" layer="51"/>
<rectangle x1="2.2" y1="-3.15" x2="2.8" y2="3.15" layer="51"/>
</package>
<package name="HPC0201" urn="urn:adsk.eagle:footprint:25783/1" library_version="11">
<description>&lt;b&gt; &lt;/b&gt;&lt;p&gt;
Source: http://www.vishay.com/docs/10129/hpc0201a.pdf</description>
<smd name="1" x="-0.18" y="0" dx="0.2" dy="0.35" layer="1"/>
<smd name="2" x="0.18" y="0" dx="0.2" dy="0.35" layer="1"/>
<text x="-0.75" y="0.74" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.785" y="-1.865" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.305" y1="-0.15" x2="0.305" y2="0.15" layer="51"/>
</package>
<package name="C0201" urn="urn:adsk.eagle:footprint:23196/1" library_version="11">
<description>Source: http://www.avxcorp.com/docs/catalogs/cx5r.pdf</description>
<smd name="1" x="-0.25" y="0" dx="0.25" dy="0.35" layer="1"/>
<smd name="2" x="0.25" y="0" dx="0.25" dy="0.35" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.3" y1="-0.15" x2="-0.15" y2="0.15" layer="51"/>
<rectangle x1="0.15" y1="-0.15" x2="0.3" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="0.1" x2="0.15" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="-0.15" x2="0.15" y2="-0.1" layer="51"/>
</package>
<package name="C1808" urn="urn:adsk.eagle:footprint:23197/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
Source: AVX .. aphvc.pdf</description>
<wire x1="-1.4732" y1="0.9502" x2="1.4732" y2="0.9502" width="0.1016" layer="51"/>
<wire x1="-1.4478" y1="-0.9502" x2="1.4732" y2="-0.9502" width="0.1016" layer="51"/>
<smd name="1" x="-1.95" y="0" dx="1.6" dy="2.2" layer="1"/>
<smd name="2" x="1.95" y="0" dx="1.6" dy="2.2" layer="1"/>
<text x="-2.233" y="1.827" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.233" y="-2.842" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.275" y1="-1.015" x2="-1.225" y2="1.015" layer="51"/>
<rectangle x1="1.225" y1="-1.015" x2="2.275" y2="1.015" layer="51"/>
</package>
<package name="C3640" urn="urn:adsk.eagle:footprint:23198/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;&lt;p&gt;
Source: AVX .. aphvc.pdf</description>
<wire x1="-3.8322" y1="5.0496" x2="3.8322" y2="5.0496" width="0.1016" layer="51"/>
<wire x1="-3.8322" y1="-5.0496" x2="3.8322" y2="-5.0496" width="0.1016" layer="51"/>
<smd name="1" x="-4.267" y="0" dx="2.6" dy="10.7" layer="1"/>
<smd name="2" x="4.267" y="0" dx="2.6" dy="10.7" layer="1"/>
<text x="-4.647" y="6.465" size="1.27" layer="25">&gt;NAME</text>
<text x="-4.647" y="-7.255" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-4.57" y1="-5.1" x2="-3.05" y2="5.1" layer="51"/>
<rectangle x1="3.05" y1="-5.1" x2="4.5688" y2="5.1" layer="51"/>
</package>
<package name="C01005" urn="urn:adsk.eagle:footprint:23199/1" library_version="11">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<rectangle x1="-0.1999" y1="-0.3" x2="0.1999" y2="0.3" layer="35"/>
<rectangle x1="-0.2" y1="-0.1" x2="-0.075" y2="0.1" layer="51"/>
<rectangle x1="0.075" y1="-0.1" x2="0.2" y2="0.1" layer="51"/>
<rectangle x1="-0.15" y1="0.05" x2="0.15" y2="0.1" layer="51"/>
<rectangle x1="-0.15" y1="-0.1" x2="0.15" y2="-0.05" layer="51"/>
<smd name="1" x="-0.1625" y="0" dx="0.2" dy="0.25" layer="1"/>
<smd name="2" x="0.1625" y="0" dx="0.2" dy="0.25" layer="1"/>
<text x="-0.4" y="0.3" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.4" y="-1.6" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="R0402" urn="urn:adsk.eagle:footprint:23043/3" library_version="11">
<description>&lt;b&gt;Chip RESISTOR 0402 EIA (1005 Metric)&lt;/b&gt;</description>
<wire x1="-0.245" y1="0.224" x2="0.245" y2="0.224" width="0.1524" layer="51"/>
<wire x1="0.245" y1="-0.224" x2="-0.245" y2="-0.224" width="0.1524" layer="51"/>
<wire x1="-1" y1="0.483" x2="1" y2="0.483" width="0.0508" layer="39"/>
<wire x1="1" y1="0.483" x2="1" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="1" y1="-0.483" x2="-1" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="-1" y1="-0.483" x2="-1" y2="0.483" width="0.0508" layer="39"/>
<smd name="1" x="-0.5" y="0" dx="0.6" dy="0.7" layer="1"/>
<smd name="2" x="0.5" y="0" dx="0.6" dy="0.7" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.554" y1="-0.3048" x2="-0.254" y2="0.2951" layer="51"/>
<rectangle x1="0.2588" y1="-0.3048" x2="0.5588" y2="0.2951" layer="51"/>
<rectangle x1="-0.1999" y1="-0.35" x2="0.1999" y2="0.35" layer="35"/>
</package>
<package name="R0603" urn="urn:adsk.eagle:footprint:23044/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.432" y1="-0.356" x2="0.432" y2="-0.356" width="0.1524" layer="51"/>
<wire x1="0.432" y1="0.356" x2="-0.432" y2="0.356" width="0.1524" layer="51"/>
<wire x1="-1.473" y1="0.983" x2="1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.983" x2="1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.983" x2="-1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.983" x2="-1.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.85" y="0" dx="1" dy="1.1" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1" dy="1.1" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4318" y1="-0.4318" x2="0.8382" y2="0.4318" layer="51"/>
<rectangle x1="-0.8382" y1="-0.4318" x2="-0.4318" y2="0.4318" layer="51"/>
<rectangle x1="-0.1999" y1="-0.4001" x2="0.1999" y2="0.4001" layer="35"/>
</package>
<package name="R0805" urn="urn:adsk.eagle:footprint:23045/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5001" x2="0.1999" y2="0.5001" layer="35"/>
</package>
<package name="R0805W" urn="urn:adsk.eagle:footprint:23046/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; wave soldering&lt;p&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.0525" y="0" dx="1.5" dy="1" layer="1"/>
<smd name="2" x="1.0525" y="0" dx="1.5" dy="1" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5001" x2="0.1999" y2="0.5001" layer="35"/>
</package>
<package name="R1206" urn="urn:adsk.eagle:footprint:23047/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="0.9525" y1="-0.8128" x2="-0.9652" y2="-0.8128" width="0.1524" layer="51"/>
<wire x1="0.9525" y1="0.8128" x2="-0.9652" y2="0.8128" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="2" x="1.422" y="0" dx="1.6" dy="1.803" layer="1"/>
<smd name="1" x="-1.422" y="0" dx="1.6" dy="1.803" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.6891" y1="-0.8763" x2="-0.9525" y2="0.8763" layer="51"/>
<rectangle x1="0.9525" y1="-0.8763" x2="1.6891" y2="0.8763" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R1206W" urn="urn:adsk.eagle:footprint:23048/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="0.8" x2="0.888" y2="0.8" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-0.8" x2="0.888" y2="-0.8" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<text x="-1.905" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-0.8763" x2="-0.9009" y2="0.8738" layer="51"/>
<rectangle x1="0.889" y1="-0.8763" x2="1.6391" y2="0.8738" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R1210" urn="urn:adsk.eagle:footprint:23049/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-0.8999" x2="0.3" y2="0.8999" layer="35"/>
</package>
<package name="R1210W" urn="urn:adsk.eagle:footprint:23050/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-0.8001" x2="0.3" y2="0.8001" layer="35"/>
</package>
<package name="R2010" urn="urn:adsk.eagle:footprint:23051/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<smd name="2" x="2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<text x="-3.175" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
</package>
<package name="R2010W" urn="urn:adsk.eagle:footprint:23052/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.311" y="0" dx="2" dy="1.8" layer="1"/>
<smd name="2" x="2.311" y="0" dx="2" dy="1.8" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
</package>
<package name="R2012" urn="urn:adsk.eagle:footprint:23053/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.85" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1001" y1="-0.5999" x2="0.1001" y2="0.5999" layer="35"/>
</package>
<package name="R2012W" urn="urn:adsk.eagle:footprint:23054/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.94" y="0" dx="1.5" dy="1" layer="1"/>
<smd name="2" x="0.94" y="0" dx="1.5" dy="1" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1001" y1="-0.5999" x2="0.1001" y2="0.5999" layer="35"/>
</package>
<package name="R2512" urn="urn:adsk.eagle:footprint:23055/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-2.8" y="0" dx="1.8" dy="3.2" layer="1"/>
<smd name="2" x="2.8" y="0" dx="1.8" dy="3.2" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R2512W" urn="urn:adsk.eagle:footprint:23056/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-2.896" y="0" dx="2" dy="2.1" layer="1"/>
<smd name="2" x="2.896" y="0" dx="2" dy="2.1" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R3216" urn="urn:adsk.eagle:footprint:23057/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.913" y1="0.8" x2="0.888" y2="0.8" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-0.8" x2="0.888" y2="-0.8" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<text x="-1.905" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-0.8763" x2="-0.9009" y2="0.8738" layer="51"/>
<rectangle x1="0.889" y1="-0.8763" x2="1.6391" y2="0.8738" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R3216W" urn="urn:adsk.eagle:footprint:23058/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="0.8" x2="0.888" y2="0.8" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-0.8" x2="0.888" y2="-0.8" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<text x="-1.905" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-0.8763" x2="-0.9009" y2="0.8738" layer="51"/>
<rectangle x1="0.889" y1="-0.8763" x2="1.6391" y2="0.8738" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R3225" urn="urn:adsk.eagle:footprint:23059/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-1" x2="0.3" y2="1" layer="35"/>
</package>
<package name="R3225W" urn="urn:adsk.eagle:footprint:23060/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-1" x2="0.3" y2="1" layer="35"/>
</package>
<package name="R5025" urn="urn:adsk.eagle:footprint:23061/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<smd name="2" x="2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<text x="-3.175" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R5025W" urn="urn:adsk.eagle:footprint:23062/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.311" y="0" dx="2" dy="1.8" layer="1"/>
<smd name="2" x="2.311" y="0" dx="2" dy="1.8" layer="1"/>
<text x="-3.175" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R6332" urn="urn:adsk.eagle:footprint:23063/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
Source: http://download.siliconexpert.com/pdfs/2005/02/24/Semi_Ap/2/VSH/Resistor/dcrcwfre.pdf</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-3.1" y="0" dx="1" dy="3.2" layer="1"/>
<smd name="2" x="3.1" y="0" dx="1" dy="3.2" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R6332W" urn="urn:adsk.eagle:footprint:25646/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; wave soldering&lt;p&gt;
Source: http://download.siliconexpert.com/pdfs/2005/02/24/Semi_Ap/2/VSH/Resistor/dcrcwfre.pdf</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-3.196" y="0" dx="1.2" dy="3.2" layer="1"/>
<smd name="2" x="3.196" y="0" dx="1.2" dy="3.2" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="M0805" urn="urn:adsk.eagle:footprint:23065/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.10 W</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="0.7112" y1="0.635" x2="-0.7112" y2="0.635" width="0.1524" layer="51"/>
<wire x1="0.7112" y1="-0.635" x2="-0.7112" y2="-0.635" width="0.1524" layer="51"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0414" y1="-0.7112" x2="-0.6858" y2="0.7112" layer="51"/>
<rectangle x1="0.6858" y1="-0.7112" x2="1.0414" y2="0.7112" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5999" x2="0.1999" y2="0.5999" layer="35"/>
</package>
<package name="M1206" urn="urn:adsk.eagle:footprint:23066/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="1.143" y1="0.8382" x2="-1.143" y2="0.8382" width="0.1524" layer="51"/>
<wire x1="1.143" y1="-0.8382" x2="-1.143" y2="-0.8382" width="0.1524" layer="51"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-0.9144" x2="-1.1176" y2="0.9144" layer="51"/>
<rectangle x1="1.1176" y1="-0.9144" x2="1.7018" y2="0.9144" layer="51"/>
<rectangle x1="-0.3" y1="-0.8001" x2="0.3" y2="0.8001" layer="35"/>
</package>
<package name="M1406" urn="urn:adsk.eagle:footprint:23067/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.12 W</description>
<wire x1="-2.973" y1="0.983" x2="2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-0.983" x2="-2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-0.983" x2="-2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="0.983" x2="2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.3208" y1="0.762" x2="-1.3208" y2="0.762" width="0.1524" layer="51"/>
<wire x1="1.3208" y1="-0.762" x2="-1.3208" y2="-0.762" width="0.1524" layer="51"/>
<smd name="1" x="-1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<smd name="2" x="1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.8542" y1="-0.8382" x2="-1.2954" y2="0.8382" layer="51"/>
<rectangle x1="1.2954" y1="-0.8382" x2="1.8542" y2="0.8382" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="M2012" urn="urn:adsk.eagle:footprint:23068/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.10 W</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="0.7112" y1="0.635" x2="-0.7112" y2="0.635" width="0.1524" layer="51"/>
<wire x1="0.7112" y1="-0.635" x2="-0.7112" y2="-0.635" width="0.1524" layer="51"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0414" y1="-0.7112" x2="-0.6858" y2="0.7112" layer="51"/>
<rectangle x1="0.6858" y1="-0.7112" x2="1.0414" y2="0.7112" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5999" x2="0.1999" y2="0.5999" layer="35"/>
</package>
<package name="M2309" urn="urn:adsk.eagle:footprint:23069/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-4.473" y1="1.483" x2="4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="-1.483" x2="-4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-4.473" y1="-1.483" x2="-4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="1.483" x2="4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.413" y1="1.1684" x2="-2.4384" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="2.413" y1="-1.1684" x2="-2.413" y2="-1.1684" width="0.1524" layer="51"/>
<smd name="1" x="-2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<smd name="2" x="2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.048" y1="-1.2446" x2="-2.3876" y2="1.2446" layer="51"/>
<rectangle x1="2.3876" y1="-1.2446" x2="3.048" y2="1.2446" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="M3216" urn="urn:adsk.eagle:footprint:23070/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="1.143" y1="0.8382" x2="-1.143" y2="0.8382" width="0.1524" layer="51"/>
<wire x1="1.143" y1="-0.8382" x2="-1.143" y2="-0.8382" width="0.1524" layer="51"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-0.9144" x2="-1.1176" y2="0.9144" layer="51"/>
<rectangle x1="1.1176" y1="-0.9144" x2="1.7018" y2="0.9144" layer="51"/>
<rectangle x1="-0.3" y1="-0.8001" x2="0.3" y2="0.8001" layer="35"/>
</package>
<package name="M3516" urn="urn:adsk.eagle:footprint:23071/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.12 W</description>
<wire x1="-2.973" y1="0.983" x2="2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-0.983" x2="-2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-0.983" x2="-2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="0.983" x2="2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.3208" y1="0.762" x2="-1.3208" y2="0.762" width="0.1524" layer="51"/>
<wire x1="1.3208" y1="-0.762" x2="-1.3208" y2="-0.762" width="0.1524" layer="51"/>
<smd name="1" x="-1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<smd name="2" x="1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.8542" y1="-0.8382" x2="-1.2954" y2="0.8382" layer="51"/>
<rectangle x1="1.2954" y1="-0.8382" x2="1.8542" y2="0.8382" layer="51"/>
<rectangle x1="-0.4001" y1="-0.7" x2="0.4001" y2="0.7" layer="35"/>
</package>
<package name="M5923" urn="urn:adsk.eagle:footprint:23072/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-4.473" y1="1.483" x2="4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="-1.483" x2="-4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-4.473" y1="-1.483" x2="-4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="1.483" x2="4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.413" y1="1.1684" x2="-2.4384" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="2.413" y1="-1.1684" x2="-2.413" y2="-1.1684" width="0.1524" layer="51"/>
<smd name="1" x="-2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<smd name="2" x="2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.048" y1="-1.2446" x2="-2.3876" y2="1.2446" layer="51"/>
<rectangle x1="2.3876" y1="-1.2446" x2="3.048" y2="1.2446" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="0204/5" urn="urn:adsk.eagle:footprint:22991/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0204, grid 5 mm</description>
<wire x1="2.54" y1="0" x2="2.032" y2="0" width="0.508" layer="51"/>
<wire x1="-2.54" y1="0" x2="-2.032" y2="0" width="0.508" layer="51"/>
<wire x1="-1.778" y1="0.635" x2="-1.524" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.778" y1="-0.635" x2="-1.524" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="1.524" y1="-0.889" x2="1.778" y2="-0.635" width="0.1524" layer="21" curve="90"/>
<wire x1="1.524" y1="0.889" x2="1.778" y2="0.635" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.778" y1="-0.635" x2="-1.778" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-1.524" y1="0.889" x2="-1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-1.143" y1="0.762" x2="-1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-1.524" y1="-0.889" x2="-1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="-1.143" y1="-0.762" x2="-1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="1.143" y1="0.762" x2="1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="1.143" y1="0.762" x2="-1.143" y2="0.762" width="0.1524" layer="21"/>
<wire x1="1.143" y1="-0.762" x2="1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="1.143" y1="-0.762" x2="-1.143" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="1.524" y1="0.889" x2="1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="1.524" y1="-0.889" x2="1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="1.778" y1="-0.635" x2="1.778" y2="0.635" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.0066" y="1.1684" size="0.9906" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.1336" y="-2.3114" size="0.9906" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-2.032" y1="-0.254" x2="-1.778" y2="0.254" layer="51"/>
<rectangle x1="1.778" y1="-0.254" x2="2.032" y2="0.254" layer="51"/>
</package>
<package name="0204/7" urn="urn:adsk.eagle:footprint:22998/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0204, grid 7.5 mm</description>
<wire x1="3.81" y1="0" x2="2.921" y2="0" width="0.508" layer="51"/>
<wire x1="-3.81" y1="0" x2="-2.921" y2="0" width="0.508" layer="51"/>
<wire x1="-2.54" y1="0.762" x2="-2.286" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.54" y1="-0.762" x2="-2.286" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="2.286" y1="-1.016" x2="2.54" y2="-0.762" width="0.1524" layer="21" curve="90"/>
<wire x1="2.286" y1="1.016" x2="2.54" y2="0.762" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.54" y1="-0.762" x2="-2.54" y2="0.762" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="1.016" x2="-1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-1.778" y1="0.889" x2="-1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="-1.016" x2="-1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-1.778" y1="-0.889" x2="-1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0.889" x2="1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0.889" x2="-1.778" y2="0.889" width="0.1524" layer="21"/>
<wire x1="1.778" y1="-0.889" x2="1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="1.778" y1="-0.889" x2="-1.778" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="2.286" y1="1.016" x2="1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.286" y1="-1.016" x2="1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.762" x2="2.54" y2="0.762" width="0.1524" layer="21"/>
<pad name="1" x="-3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.54" y="1.2954" size="0.9906" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.6256" y="-0.4826" size="0.9906" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="2.54" y1="-0.254" x2="2.921" y2="0.254" layer="21"/>
<rectangle x1="-2.921" y1="-0.254" x2="-2.54" y2="0.254" layer="21"/>
</package>
<package name="0204V" urn="urn:adsk.eagle:footprint:22999/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0204, grid 2.5 mm</description>
<wire x1="-1.27" y1="0" x2="1.27" y2="0" width="0.508" layer="51"/>
<wire x1="-0.127" y1="0" x2="0.127" y2="0" width="0.508" layer="21"/>
<circle x="-1.27" y="0" radius="0.889" width="0.1524" layer="51"/>
<circle x="-1.27" y="0" radius="0.635" width="0.0508" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.1336" y="1.1684" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.1336" y="-2.3114" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/10" urn="urn:adsk.eagle:footprint:22992/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 10 mm</description>
<wire x1="5.08" y1="0" x2="4.064" y2="0" width="0.6096" layer="51"/>
<wire x1="-5.08" y1="0" x2="-4.064" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.048" y="1.524" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.2606" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
</package>
<package name="0207/12" urn="urn:adsk.eagle:footprint:22993/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 12 mm</description>
<wire x1="6.35" y1="0" x2="5.334" y2="0" width="0.6096" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.334" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="4.445" y1="0" x2="4.064" y2="0" width="0.6096" layer="21"/>
<wire x1="-4.445" y1="0" x2="-4.064" y2="0" width="0.6096" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.175" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
<rectangle x1="4.445" y1="-0.3048" x2="5.3086" y2="0.3048" layer="21"/>
<rectangle x1="-5.3086" y1="-0.3048" x2="-4.445" y2="0.3048" layer="21"/>
</package>
<package name="0207/15" urn="urn:adsk.eagle:footprint:22997/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 15mm</description>
<wire x1="7.62" y1="0" x2="6.604" y2="0" width="0.6096" layer="51"/>
<wire x1="-7.62" y1="0" x2="-6.604" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="5.715" y1="0" x2="4.064" y2="0" width="0.6096" layer="21"/>
<wire x1="-5.715" y1="0" x2="-4.064" y2="0" width="0.6096" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.175" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
<rectangle x1="5.715" y1="-0.3048" x2="6.5786" y2="0.3048" layer="21"/>
<rectangle x1="-6.5786" y1="-0.3048" x2="-5.715" y2="0.3048" layer="21"/>
</package>
<package name="0207/2V" urn="urn:adsk.eagle:footprint:22994/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 2.5 mm</description>
<wire x1="-1.27" y1="0" x2="-0.381" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.254" y1="0" x2="0.254" y2="0" width="0.6096" layer="21"/>
<wire x1="0.381" y1="0" x2="1.27" y2="0" width="0.6096" layer="51"/>
<circle x="-1.27" y="0" radius="1.27" width="0.1524" layer="21"/>
<circle x="-1.27" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-0.0508" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.0508" y="-2.2352" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/5V" urn="urn:adsk.eagle:footprint:22995/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 5 mm</description>
<wire x1="-2.54" y1="0" x2="-0.889" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.762" y1="0" x2="0.762" y2="0" width="0.6096" layer="21"/>
<wire x1="0.889" y1="0" x2="2.54" y2="0" width="0.6096" layer="51"/>
<circle x="-2.54" y="0" radius="1.27" width="0.1016" layer="21"/>
<circle x="-2.54" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-1.143" y="0.889" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.143" y="-2.159" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/7" urn="urn:adsk.eagle:footprint:22996/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 7.5 mm</description>
<wire x1="-3.81" y1="0" x2="-3.429" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="51"/>
<wire x1="3.429" y1="0" x2="3.81" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.54" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.5588" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-3.429" y1="-0.3048" x2="-3.175" y2="0.3048" layer="51"/>
<rectangle x1="3.175" y1="-0.3048" x2="3.429" y2="0.3048" layer="51"/>
</package>
<package name="0309/10" urn="urn:adsk.eagle:footprint:23073/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0309, grid 10mm</description>
<wire x1="-4.699" y1="0" x2="-5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="-4.318" y1="1.27" x2="-4.064" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.064" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="-1.524" x2="4.318" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="1.524" x2="4.318" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.318" y2="1.27" width="0.1524" layer="51"/>
<wire x1="-4.064" y1="1.524" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="1.397" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-4.064" y1="-1.524" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="-1.397" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="-3.302" y2="1.397" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="-3.302" y2="-1.397" width="0.1524" layer="21"/>
<wire x1="4.064" y1="1.524" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="4.064" y1="-1.524" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.318" y1="-1.27" x2="4.318" y2="1.27" width="0.1524" layer="51"/>
<wire x1="5.08" y1="0" x2="4.699" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-5.08" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="0.8128" shape="octagon"/>
<text x="-4.191" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-4.6228" y1="-0.3048" x2="-4.318" y2="0.3048" layer="51"/>
<rectangle x1="4.318" y1="-0.3048" x2="4.6228" y2="0.3048" layer="51"/>
</package>
<package name="0309/12" urn="urn:adsk.eagle:footprint:23074/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0309, grid 12.5 mm</description>
<wire x1="6.35" y1="0" x2="5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="-4.318" y1="1.27" x2="-4.064" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.064" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="-1.524" x2="4.318" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="1.524" x2="4.318" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.318" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-4.064" y1="1.524" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="1.397" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-4.064" y1="-1.524" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="-1.397" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="-3.302" y2="1.397" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="-3.302" y2="-1.397" width="0.1524" layer="21"/>
<wire x1="4.064" y1="1.524" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="4.064" y1="-1.524" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.318" y1="-1.27" x2="4.318" y2="1.27" width="0.1524" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="0.8128" shape="octagon"/>
<text x="-4.191" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="4.318" y1="-0.3048" x2="5.1816" y2="0.3048" layer="21"/>
<rectangle x1="-5.1816" y1="-0.3048" x2="-4.318" y2="0.3048" layer="21"/>
</package>
<package name="0309V" urn="urn:adsk.eagle:footprint:23075/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0309, grid 2.5 mm</description>
<wire x1="1.27" y1="0" x2="0.635" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.635" y1="0" x2="-1.27" y2="0" width="0.6096" layer="51"/>
<circle x="-1.27" y="0" radius="1.524" width="0.1524" layer="21"/>
<circle x="-1.27" y="0" radius="0.762" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="0.254" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0.254" y="-2.2098" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="0.254" y1="-0.3048" x2="0.5588" y2="0.3048" layer="51"/>
<rectangle x1="-0.635" y1="-0.3048" x2="-0.3302" y2="0.3048" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3048" x2="0.254" y2="0.3048" layer="21"/>
</package>
<package name="0411/12" urn="urn:adsk.eagle:footprint:23076/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0411, grid 12.5 mm</description>
<wire x1="6.35" y1="0" x2="5.461" y2="0" width="0.762" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.461" y2="0" width="0.762" layer="51"/>
<wire x1="5.08" y1="-1.651" x2="5.08" y2="1.651" width="0.1524" layer="21"/>
<wire x1="4.699" y1="2.032" x2="5.08" y2="1.651" width="0.1524" layer="21" curve="-90"/>
<wire x1="-5.08" y1="-1.651" x2="-4.699" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="4.699" y1="-2.032" x2="5.08" y2="-1.651" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="1.651" x2="-4.699" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="2.032" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="1.905" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-2.032" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="-1.905" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="3.937" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="3.937" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="1.651" x2="-5.08" y2="-1.651" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="2.032" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="-2.032" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="0.9144" shape="octagon"/>
<text x="-5.08" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.5814" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-5.3594" y1="-0.381" x2="-5.08" y2="0.381" layer="21"/>
<rectangle x1="5.08" y1="-0.381" x2="5.3594" y2="0.381" layer="21"/>
</package>
<package name="0411/15" urn="urn:adsk.eagle:footprint:23077/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0411, grid 15 mm</description>
<wire x1="5.08" y1="-1.651" x2="5.08" y2="1.651" width="0.1524" layer="21"/>
<wire x1="4.699" y1="2.032" x2="5.08" y2="1.651" width="0.1524" layer="21" curve="-90"/>
<wire x1="-5.08" y1="-1.651" x2="-4.699" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="4.699" y1="-2.032" x2="5.08" y2="-1.651" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="1.651" x2="-4.699" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="2.032" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="1.905" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-2.032" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="-1.905" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="3.937" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="3.937" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="1.651" x2="-5.08" y2="-1.651" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="2.032" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="-2.032" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0" x2="-6.35" y2="0" width="0.762" layer="51"/>
<wire x1="6.35" y1="0" x2="7.62" y2="0" width="0.762" layer="51"/>
<pad name="1" x="-7.62" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="0.9144" shape="octagon"/>
<text x="-5.08" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.5814" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="5.08" y1="-0.381" x2="6.477" y2="0.381" layer="21"/>
<rectangle x1="-6.477" y1="-0.381" x2="-5.08" y2="0.381" layer="21"/>
</package>
<package name="0411V" urn="urn:adsk.eagle:footprint:23078/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0411, grid 3.81 mm</description>
<wire x1="1.27" y1="0" x2="0.3048" y2="0" width="0.762" layer="51"/>
<wire x1="-1.5748" y1="0" x2="-2.54" y2="0" width="0.762" layer="51"/>
<circle x="-2.54" y="0" radius="2.032" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.9144" shape="octagon"/>
<text x="-0.508" y="1.143" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.5334" y="-2.413" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.4732" y1="-0.381" x2="0.2032" y2="0.381" layer="21"/>
</package>
<package name="0414/15" urn="urn:adsk.eagle:footprint:23079/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0414, grid 15 mm</description>
<wire x1="7.62" y1="0" x2="6.604" y2="0" width="0.8128" layer="51"/>
<wire x1="-7.62" y1="0" x2="-6.604" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.096" y1="1.905" x2="-5.842" y2="2.159" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.096" y1="-1.905" x2="-5.842" y2="-2.159" width="0.1524" layer="21" curve="90"/>
<wire x1="5.842" y1="-2.159" x2="6.096" y2="-1.905" width="0.1524" layer="21" curve="90"/>
<wire x1="5.842" y1="2.159" x2="6.096" y2="1.905" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.096" y1="-1.905" x2="-6.096" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-5.842" y1="2.159" x2="-4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="2.032" x2="-4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-5.842" y1="-2.159" x2="-4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="-2.032" x2="-4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="4.826" y1="2.032" x2="4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="4.826" y1="2.032" x2="-4.826" y2="2.032" width="0.1524" layer="21"/>
<wire x1="4.826" y1="-2.032" x2="4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="4.826" y1="-2.032" x2="-4.826" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="5.842" y1="2.159" x2="4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="5.842" y1="-2.159" x2="4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-1.905" x2="6.096" y2="1.905" width="0.1524" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="1.016" shape="octagon"/>
<text x="-6.096" y="2.5654" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.318" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="6.096" y1="-0.4064" x2="6.5024" y2="0.4064" layer="21"/>
<rectangle x1="-6.5024" y1="-0.4064" x2="-6.096" y2="0.4064" layer="21"/>
</package>
<package name="0414V" urn="urn:adsk.eagle:footprint:23080/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0414, grid 5 mm</description>
<wire x1="2.54" y1="0" x2="1.397" y2="0" width="0.8128" layer="51"/>
<wire x1="-2.54" y1="0" x2="-1.397" y2="0" width="0.8128" layer="51"/>
<circle x="-2.54" y="0" radius="2.159" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.143" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="-0.381" y="1.1684" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.381" y="-2.3622" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.2954" y1="-0.4064" x2="1.2954" y2="0.4064" layer="21"/>
</package>
<package name="0617/17" urn="urn:adsk.eagle:footprint:23081/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0617, grid 17.5 mm</description>
<wire x1="-8.89" y1="0" x2="-8.636" y2="0" width="0.8128" layer="51"/>
<wire x1="-7.874" y1="3.048" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="2.794" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-7.874" y1="-3.048" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="-2.794" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="-6.731" y2="2.794" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="-6.731" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="7.874" y1="3.048" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="7.874" y1="-3.048" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="-2.667" x2="-8.255" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="1.016" x2="-8.255" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="-8.255" y1="1.016" x2="-8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-2.667" x2="8.255" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="8.255" y1="1.016" x2="8.255" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="8.255" y1="1.016" x2="8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="8.636" y1="0" x2="8.89" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.255" y1="2.667" x2="-7.874" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="7.874" y1="3.048" x2="8.255" y2="2.667" width="0.1524" layer="21" curve="-90"/>
<wire x1="-8.255" y1="-2.667" x2="-7.874" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="7.874" y1="-3.048" x2="8.255" y2="-2.667" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-8.89" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="8.89" y="0" drill="1.016" shape="octagon"/>
<text x="-8.128" y="3.4544" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.096" y="-0.7112" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-8.5344" y1="-0.4064" x2="-8.2296" y2="0.4064" layer="51"/>
<rectangle x1="8.2296" y1="-0.4064" x2="8.5344" y2="0.4064" layer="51"/>
</package>
<package name="0617/22" urn="urn:adsk.eagle:footprint:23082/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0617, grid 22.5 mm</description>
<wire x1="-10.287" y1="0" x2="-11.43" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.255" y1="-2.667" x2="-8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-7.874" y1="3.048" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="2.794" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-7.874" y1="-3.048" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="-2.794" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="-6.731" y2="2.794" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="-6.731" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="7.874" y1="3.048" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="7.874" y1="-3.048" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-2.667" x2="8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="11.43" y1="0" x2="10.287" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.255" y1="2.667" x2="-7.874" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="-8.255" y1="-2.667" x2="-7.874" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="7.874" y1="3.048" x2="8.255" y2="2.667" width="0.1524" layer="21" curve="-90"/>
<wire x1="7.874" y1="-3.048" x2="8.255" y2="-2.667" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.43" y="0" drill="1.016" shape="octagon"/>
<text x="-8.255" y="3.4544" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.477" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.1854" y1="-0.4064" x2="-8.255" y2="0.4064" layer="21"/>
<rectangle x1="8.255" y1="-0.4064" x2="10.1854" y2="0.4064" layer="21"/>
</package>
<package name="0617V" urn="urn:adsk.eagle:footprint:23083/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0617, grid 5 mm</description>
<wire x1="-2.54" y1="0" x2="-1.27" y2="0" width="0.8128" layer="51"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.8128" layer="51"/>
<circle x="-2.54" y="0" radius="3.048" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.143" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="0.635" y="1.4224" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0.635" y="-2.6162" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.3208" y1="-0.4064" x2="1.3208" y2="0.4064" layer="21"/>
</package>
<package name="0922/22" urn="urn:adsk.eagle:footprint:23084/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0922, grid 22.5 mm</description>
<wire x1="11.43" y1="0" x2="10.795" y2="0" width="0.8128" layer="51"/>
<wire x1="-11.43" y1="0" x2="-10.795" y2="0" width="0.8128" layer="51"/>
<wire x1="-10.16" y1="-4.191" x2="-10.16" y2="4.191" width="0.1524" layer="21"/>
<wire x1="-9.779" y1="4.572" x2="-8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="-8.636" y1="4.318" x2="-8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="-9.779" y1="-4.572" x2="-8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="-8.636" y1="-4.318" x2="-8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="8.636" y1="4.318" x2="8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="8.636" y1="4.318" x2="-8.636" y2="4.318" width="0.1524" layer="21"/>
<wire x1="8.636" y1="-4.318" x2="8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="8.636" y1="-4.318" x2="-8.636" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="9.779" y1="4.572" x2="8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="9.779" y1="-4.572" x2="8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-4.191" x2="10.16" y2="4.191" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-4.191" x2="-9.779" y2="-4.572" width="0.1524" layer="21" curve="90"/>
<wire x1="-10.16" y1="4.191" x2="-9.779" y2="4.572" width="0.1524" layer="21" curve="-90"/>
<wire x1="9.779" y1="-4.572" x2="10.16" y2="-4.191" width="0.1524" layer="21" curve="90"/>
<wire x1="9.779" y1="4.572" x2="10.16" y2="4.191" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.43" y="0" drill="1.016" shape="octagon"/>
<text x="-10.16" y="5.1054" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.477" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.7188" y1="-0.4064" x2="-10.16" y2="0.4064" layer="51"/>
<rectangle x1="10.16" y1="-0.4064" x2="10.3124" y2="0.4064" layer="21"/>
<rectangle x1="-10.3124" y1="-0.4064" x2="-10.16" y2="0.4064" layer="21"/>
<rectangle x1="10.16" y1="-0.4064" x2="10.7188" y2="0.4064" layer="51"/>
</package>
<package name="P0613V" urn="urn:adsk.eagle:footprint:23085/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0613, grid 5 mm</description>
<wire x1="2.54" y1="0" x2="1.397" y2="0" width="0.8128" layer="51"/>
<wire x1="-2.54" y1="0" x2="-1.397" y2="0" width="0.8128" layer="51"/>
<circle x="-2.54" y="0" radius="2.286" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.143" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="-0.254" y="1.143" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.254" y="-2.413" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.2954" y1="-0.4064" x2="1.3208" y2="0.4064" layer="21"/>
</package>
<package name="P0613/15" urn="urn:adsk.eagle:footprint:23086/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0613, grid 15 mm</description>
<wire x1="7.62" y1="0" x2="6.985" y2="0" width="0.8128" layer="51"/>
<wire x1="-7.62" y1="0" x2="-6.985" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.477" y1="2.032" x2="-6.223" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.477" y1="-2.032" x2="-6.223" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="6.223" y1="-2.286" x2="6.477" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="6.223" y1="2.286" x2="6.477" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.223" y1="2.286" x2="-5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="2.159" x2="-5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="-6.223" y1="-2.286" x2="-5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="-2.159" x2="-5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="5.207" y1="2.159" x2="5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="5.207" y1="2.159" x2="-5.207" y2="2.159" width="0.1524" layer="21"/>
<wire x1="5.207" y1="-2.159" x2="5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="5.207" y1="-2.159" x2="-5.207" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="6.223" y1="2.286" x2="5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="6.223" y1="-2.286" x2="5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="6.477" y1="-0.635" x2="6.477" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="6.477" y1="-0.635" x2="6.477" y2="0.635" width="0.1524" layer="51"/>
<wire x1="6.477" y1="2.032" x2="6.477" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="-2.032" x2="-6.477" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="0.635" x2="-6.477" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-6.477" y1="0.635" x2="-6.477" y2="2.032" width="0.1524" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="1.016" shape="octagon"/>
<text x="-6.477" y="2.6924" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.318" y="-0.7112" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-7.0358" y1="-0.4064" x2="-6.477" y2="0.4064" layer="51"/>
<rectangle x1="6.477" y1="-0.4064" x2="7.0358" y2="0.4064" layer="51"/>
</package>
<package name="P0817/22" urn="urn:adsk.eagle:footprint:23087/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0817, grid 22.5 mm</description>
<wire x1="-10.414" y1="0" x2="-11.43" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.509" y1="-3.429" x2="-8.509" y2="3.429" width="0.1524" layer="21"/>
<wire x1="-8.128" y1="3.81" x2="-7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="3.556" x2="-7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-8.128" y1="-3.81" x2="-7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="-3.556" x2="-7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="3.556" x2="7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="3.556" x2="-6.985" y2="3.556" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-3.556" x2="7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-3.556" x2="-6.985" y2="-3.556" width="0.1524" layer="21"/>
<wire x1="8.128" y1="3.81" x2="7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="8.128" y1="-3.81" x2="7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-3.429" x2="8.509" y2="3.429" width="0.1524" layer="21"/>
<wire x1="11.43" y1="0" x2="10.414" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.509" y1="3.429" x2="-8.128" y2="3.81" width="0.1524" layer="21" curve="-90"/>
<wire x1="-8.509" y1="-3.429" x2="-8.128" y2="-3.81" width="0.1524" layer="21" curve="90"/>
<wire x1="8.128" y1="3.81" x2="8.509" y2="3.429" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.128" y1="-3.81" x2="8.509" y2="-3.429" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.43" y="0" drill="1.016" shape="octagon"/>
<text x="-8.382" y="4.2164" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.223" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="6.604" y="-2.2606" size="1.27" layer="51" ratio="10" rot="R90">0817</text>
<rectangle x1="8.509" y1="-0.4064" x2="10.3124" y2="0.4064" layer="21"/>
<rectangle x1="-10.3124" y1="-0.4064" x2="-8.509" y2="0.4064" layer="21"/>
</package>
<package name="P0817V" urn="urn:adsk.eagle:footprint:23088/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0817, grid 6.35 mm</description>
<wire x1="-3.81" y1="0" x2="-5.08" y2="0" width="0.8128" layer="51"/>
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.8128" layer="51"/>
<circle x="-5.08" y="0" radius="3.81" width="0.1524" layer="21"/>
<circle x="-5.08" y="0" radius="1.27" width="0.1524" layer="51"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="1.016" shape="octagon"/>
<text x="-1.016" y="1.27" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.016" y="-2.54" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-6.858" y="2.032" size="1.016" layer="21" ratio="12">0817</text>
<rectangle x1="-3.81" y1="-0.4064" x2="0" y2="0.4064" layer="21"/>
</package>
<package name="V234/12" urn="urn:adsk.eagle:footprint:23089/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type V234, grid 12.5 mm</description>
<wire x1="-4.953" y1="1.524" x2="-4.699" y2="1.778" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="1.778" x2="4.953" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="-1.778" x2="4.953" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-4.953" y1="-1.524" x2="-4.699" y2="-1.778" width="0.1524" layer="21" curve="90"/>
<wire x1="-4.699" y1="1.778" x2="4.699" y2="1.778" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="1.524" x2="-4.953" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-1.778" x2="-4.699" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="4.953" y1="1.524" x2="4.953" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="6.35" y1="0" x2="5.461" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.461" y2="0" width="0.8128" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="1.016" shape="octagon"/>
<text x="-4.953" y="2.159" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.81" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="4.953" y1="-0.4064" x2="5.4102" y2="0.4064" layer="21"/>
<rectangle x1="-5.4102" y1="-0.4064" x2="-4.953" y2="0.4064" layer="21"/>
</package>
<package name="V235/17" urn="urn:adsk.eagle:footprint:23090/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type V235, grid 17.78 mm</description>
<wire x1="-6.731" y1="2.921" x2="6.731" y2="2.921" width="0.1524" layer="21"/>
<wire x1="-7.112" y1="2.54" x2="-7.112" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.921" x2="-6.731" y2="-2.921" width="0.1524" layer="21"/>
<wire x1="7.112" y1="2.54" x2="7.112" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="8.89" y1="0" x2="7.874" y2="0" width="1.016" layer="51"/>
<wire x1="-7.874" y1="0" x2="-8.89" y2="0" width="1.016" layer="51"/>
<wire x1="-7.112" y1="-2.54" x2="-6.731" y2="-2.921" width="0.1524" layer="21" curve="90"/>
<wire x1="6.731" y1="2.921" x2="7.112" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.731" y1="-2.921" x2="7.112" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-7.112" y1="2.54" x2="-6.731" y2="2.921" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-8.89" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="8.89" y="0" drill="1.1938" shape="octagon"/>
<text x="-6.858" y="3.302" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.842" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="7.112" y1="-0.508" x2="7.747" y2="0.508" layer="21"/>
<rectangle x1="-7.747" y1="-0.508" x2="-7.112" y2="0.508" layer="21"/>
</package>
<package name="V526-0" urn="urn:adsk.eagle:footprint:23091/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type V526-0, grid 2.5 mm</description>
<wire x1="-2.54" y1="1.016" x2="-2.286" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.286" y1="1.27" x2="2.54" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.286" y1="-1.27" x2="2.54" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.54" y1="-1.016" x2="-2.286" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="2.286" y1="1.27" x2="-2.286" y2="1.27" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.016" x2="2.54" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="-1.27" x2="2.286" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="1.016" x2="-2.54" y2="-1.016" width="0.1524" layer="21"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.413" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.413" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0102R" urn="urn:adsk.eagle:footprint:23092/1" library_version="11">
<description>&lt;b&gt;CECC Size RC2211&lt;/b&gt; Reflow Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1" y1="-0.5" x2="1" y2="-0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="-0.5" x2="1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="0.5" x2="-1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="-1" y1="0.5" x2="-1" y2="-0.5" width="0.2032" layer="51"/>
<smd name="1" x="-0.9" y="0" dx="0.5" dy="1.3" layer="1"/>
<smd name="2" x="0.9" y="0" dx="0.5" dy="1.3" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0102W" urn="urn:adsk.eagle:footprint:23093/1" library_version="11">
<description>&lt;b&gt;CECC Size RC2211&lt;/b&gt; Wave Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1" y1="-0.5" x2="1" y2="-0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="-0.5" x2="1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="0.5" x2="-1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="-1" y1="0.5" x2="-1" y2="-0.5" width="0.2032" layer="51"/>
<smd name="1" x="-0.95" y="0" dx="0.6" dy="1.3" layer="1"/>
<smd name="2" x="0.95" y="0" dx="0.6" dy="1.3" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0204R" urn="urn:adsk.eagle:footprint:25676/1" library_version="11">
<description>&lt;b&gt;CECC Size RC3715&lt;/b&gt; Reflow Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1.7" y1="-0.6" x2="1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="-0.6" x2="1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="0.6" x2="-1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="-1.7" y1="0.6" x2="-1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="0.938" y1="0.6" x2="-0.938" y2="0.6" width="0.2032" layer="21"/>
<wire x1="-0.938" y1="-0.6" x2="0.938" y2="-0.6" width="0.2032" layer="21"/>
<smd name="1" x="-1.5" y="0" dx="0.8" dy="1.6" layer="1"/>
<smd name="2" x="1.5" y="0" dx="0.8" dy="1.6" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0204W" urn="urn:adsk.eagle:footprint:25677/1" library_version="11">
<description>&lt;b&gt;CECC Size RC3715&lt;/b&gt; Wave Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1.7" y1="-0.6" x2="1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="-0.6" x2="1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="0.6" x2="-1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="-1.7" y1="0.6" x2="-1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="0.684" y1="0.6" x2="-0.684" y2="0.6" width="0.2032" layer="21"/>
<wire x1="-0.684" y1="-0.6" x2="0.684" y2="-0.6" width="0.2032" layer="21"/>
<smd name="1" x="-1.5" y="0" dx="1.2" dy="1.6" layer="1"/>
<smd name="2" x="1.5" y="0" dx="1.2" dy="1.6" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0207R" urn="urn:adsk.eagle:footprint:25678/1" library_version="11">
<description>&lt;b&gt;CECC Size RC6123&lt;/b&gt; Reflow Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-2.8" y1="-1" x2="2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="-1" x2="2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="1" x2="-2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="-2.8" y1="1" x2="-2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="1.2125" y1="1" x2="-1.2125" y2="1" width="0.2032" layer="21"/>
<wire x1="-1.2125" y1="-1" x2="1.2125" y2="-1" width="0.2032" layer="21"/>
<smd name="1" x="-2.25" y="0" dx="1.6" dy="2.5" layer="1"/>
<smd name="2" x="2.25" y="0" dx="1.6" dy="2.5" layer="1"/>
<text x="-2.2225" y="1.5875" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.2225" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0207W" urn="urn:adsk.eagle:footprint:25679/1" library_version="11">
<description>&lt;b&gt;CECC Size RC6123&lt;/b&gt; Wave Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-2.8" y1="-1" x2="2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="-1" x2="2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="1" x2="-2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="-2.8" y1="1" x2="-2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="1.149" y1="1" x2="-1.149" y2="1" width="0.2032" layer="21"/>
<wire x1="-1.149" y1="-1" x2="1.149" y2="-1" width="0.2032" layer="21"/>
<smd name="1" x="-2.6" y="0" dx="2.4" dy="2.5" layer="1"/>
<smd name="2" x="2.6" y="0" dx="2.4" dy="2.5" layer="1"/>
<text x="-2.54" y="1.5875" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="0922V" urn="urn:adsk.eagle:footprint:23098/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0922, grid 7.5 mm</description>
<wire x1="2.54" y1="0" x2="1.397" y2="0" width="0.8128" layer="51"/>
<wire x1="-5.08" y1="0" x2="-3.81" y2="0" width="0.8128" layer="51"/>
<circle x="-5.08" y="0" radius="4.572" width="0.1524" layer="21"/>
<circle x="-5.08" y="0" radius="1.905" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="-0.508" y="1.6764" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.508" y="-2.9972" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-6.858" y="2.54" size="1.016" layer="21" ratio="12">0922</text>
<rectangle x1="-3.81" y1="-0.4064" x2="1.3208" y2="0.4064" layer="21"/>
</package>
<package name="RDH/15" urn="urn:adsk.eagle:footprint:23099/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type RDH, grid 15 mm</description>
<wire x1="-7.62" y1="0" x2="-6.858" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.096" y1="3.048" x2="-5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="2.794" x2="-5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.096" y1="-3.048" x2="-5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="-2.794" x2="-5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="4.953" y1="2.794" x2="5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="4.953" y1="2.794" x2="-4.953" y2="2.794" width="0.1524" layer="21"/>
<wire x1="4.953" y1="-2.794" x2="5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="4.953" y1="-2.794" x2="-4.953" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="6.096" y1="3.048" x2="5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-3.048" x2="5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="-2.667" x2="-6.477" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="1.016" x2="-6.477" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="-6.477" y1="1.016" x2="-6.477" y2="2.667" width="0.1524" layer="21"/>
<wire x1="6.477" y1="-2.667" x2="6.477" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="6.477" y1="1.016" x2="6.477" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="6.477" y1="1.016" x2="6.477" y2="2.667" width="0.1524" layer="21"/>
<wire x1="6.858" y1="0" x2="7.62" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.477" y1="2.667" x2="-6.096" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.096" y1="3.048" x2="6.477" y2="2.667" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.477" y1="-2.667" x2="-6.096" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="6.096" y1="-3.048" x2="6.477" y2="-2.667" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="1.016" shape="octagon"/>
<text x="-6.35" y="3.4544" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.318" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="4.572" y="-1.7272" size="1.27" layer="51" ratio="10" rot="R90">RDH</text>
<rectangle x1="-6.7564" y1="-0.4064" x2="-6.4516" y2="0.4064" layer="51"/>
<rectangle x1="6.4516" y1="-0.4064" x2="6.7564" y2="0.4064" layer="51"/>
</package>
<package name="MINI_MELF-0102AX" urn="urn:adsk.eagle:footprint:23100/1" library_version="11">
<description>&lt;b&gt;Mini MELF 0102 Axial&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.6" width="0" layer="51"/>
<circle x="0" y="0" radius="0.6" width="0" layer="52"/>
<smd name="1" x="0" y="0" dx="1.9" dy="1.9" layer="1" roundness="100"/>
<smd name="2" x="0" y="0" dx="1.9" dy="1.9" layer="16" roundness="100"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
<hole x="0" y="0" drill="1.3"/>
</package>
<package name="R0201" urn="urn:adsk.eagle:footprint:25683/1" library_version="11">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; chip&lt;p&gt;
Source: http://www.vishay.com/docs/20008/dcrcw.pdf</description>
<smd name="1" x="-0.255" y="0" dx="0.28" dy="0.43" layer="1"/>
<smd name="2" x="0.255" y="0" dx="0.28" dy="0.43" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.3" y1="-0.15" x2="-0.15" y2="0.15" layer="51"/>
<rectangle x1="0.15" y1="-0.15" x2="0.3" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="-0.15" x2="0.15" y2="0.15" layer="21"/>
</package>
<package name="VTA52" urn="urn:adsk.eagle:footprint:25684/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR52&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-15.24" y1="0" x2="-13.97" y2="0" width="0.6096" layer="51"/>
<wire x1="12.6225" y1="0.025" x2="12.6225" y2="4.725" width="0.1524" layer="21"/>
<wire x1="12.6225" y1="4.725" x2="-12.6225" y2="4.725" width="0.1524" layer="21"/>
<wire x1="-12.6225" y1="4.725" x2="-12.6225" y2="0.025" width="0.1524" layer="21"/>
<wire x1="-12.6225" y1="0.025" x2="-12.6225" y2="-4.65" width="0.1524" layer="21"/>
<wire x1="-12.6225" y1="-4.65" x2="12.6225" y2="-4.65" width="0.1524" layer="21"/>
<wire x1="12.6225" y1="-4.65" x2="12.6225" y2="0.025" width="0.1524" layer="21"/>
<wire x1="13.97" y1="0" x2="15.24" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-15.24" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="15.24" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="5.08" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-13.97" y1="-0.3048" x2="-12.5675" y2="0.3048" layer="21"/>
<rectangle x1="12.5675" y1="-0.3048" x2="13.97" y2="0.3048" layer="21"/>
</package>
<package name="VTA53" urn="urn:adsk.eagle:footprint:25685/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR53&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-12.065" y1="0" x2="-10.795" y2="0" width="0.6096" layer="51"/>
<wire x1="9.8975" y1="0" x2="9.8975" y2="4.7" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="4.7" x2="-9.8975" y2="4.7" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="4.7" x2="-9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="0" x2="-9.8975" y2="-4.675" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="-4.675" x2="9.8975" y2="-4.675" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="-4.675" x2="9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="10.795" y1="0" x2="12.065" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-12.065" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="12.065" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="5.08" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.795" y1="-0.3048" x2="-9.8425" y2="0.3048" layer="21"/>
<rectangle x1="9.8425" y1="-0.3048" x2="10.795" y2="0.3048" layer="21"/>
</package>
<package name="VTA54" urn="urn:adsk.eagle:footprint:25686/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR54&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-12.065" y1="0" x2="-10.795" y2="0" width="0.6096" layer="51"/>
<wire x1="9.8975" y1="0" x2="9.8975" y2="3.3" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="3.3" x2="-9.8975" y2="3.3" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="3.3" x2="-9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="0" x2="-9.8975" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="-3.3" x2="9.8975" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="-3.3" x2="9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="10.795" y1="0" x2="12.065" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-12.065" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="12.065" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="3.81" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.795" y1="-0.3048" x2="-9.8425" y2="0.3048" layer="21"/>
<rectangle x1="9.8425" y1="-0.3048" x2="10.795" y2="0.3048" layer="21"/>
</package>
<package name="VTA55" urn="urn:adsk.eagle:footprint:25687/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR55&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-8.255" y1="0" x2="-6.985" y2="0" width="0.6096" layer="51"/>
<wire x1="6.405" y1="0" x2="6.405" y2="3.3" width="0.1524" layer="21"/>
<wire x1="6.405" y1="3.3" x2="-6.405" y2="3.3" width="0.1524" layer="21"/>
<wire x1="-6.405" y1="3.3" x2="-6.405" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.405" y1="0" x2="-6.405" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="-6.405" y1="-3.3" x2="6.405" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="6.405" y1="-3.3" x2="6.405" y2="0" width="0.1524" layer="21"/>
<wire x1="6.985" y1="0" x2="8.255" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-8.255" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="8.255" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="3.81" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-6.985" y1="-0.3048" x2="-6.35" y2="0.3048" layer="21"/>
<rectangle x1="6.35" y1="-0.3048" x2="6.985" y2="0.3048" layer="21"/>
</package>
<package name="VTA56" urn="urn:adsk.eagle:footprint:25688/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR56&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-6.35" y1="0" x2="-5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="4.5" y1="0" x2="4.5" y2="3.3" width="0.1524" layer="21"/>
<wire x1="4.5" y1="3.3" x2="-4.5" y2="3.3" width="0.1524" layer="21"/>
<wire x1="-4.5" y1="3.3" x2="-4.5" y2="0" width="0.1524" layer="21"/>
<wire x1="-4.5" y1="0" x2="-4.5" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="-4.5" y1="-3.3" x2="4.5" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="4.5" y1="-3.3" x2="4.5" y2="0" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0" x2="6.35" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="3.81" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-5.08" y1="-0.3048" x2="-4.445" y2="0.3048" layer="21"/>
<rectangle x1="4.445" y1="-0.3048" x2="5.08" y2="0.3048" layer="21"/>
</package>
<package name="VMTA55" urn="urn:adsk.eagle:footprint:25689/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RNC55&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-5.08" y1="0" x2="-4.26" y2="0" width="0.6096" layer="51"/>
<wire x1="3.3375" y1="-1.45" x2="3.3375" y2="1.45" width="0.1524" layer="21"/>
<wire x1="3.3375" y1="1.45" x2="-3.3625" y2="1.45" width="0.1524" layer="21"/>
<wire x1="-3.3625" y1="1.45" x2="-3.3625" y2="-1.45" width="0.1524" layer="21"/>
<wire x1="-3.3625" y1="-1.45" x2="3.3375" y2="-1.45" width="0.1524" layer="21"/>
<wire x1="4.235" y1="0" x2="5.08" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-5.08" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.1" shape="octagon"/>
<text x="-3.175" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-4.26" y1="-0.3048" x2="-3.3075" y2="0.3048" layer="21"/>
<rectangle x1="3.2825" y1="-0.3048" x2="4.235" y2="0.3048" layer="21"/>
</package>
<package name="VMTB60" urn="urn:adsk.eagle:footprint:25690/1" library_version="11">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RNC60&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-6.35" y1="0" x2="-5.585" y2="0" width="0.6096" layer="51"/>
<wire x1="4.6875" y1="-1.95" x2="4.6875" y2="1.95" width="0.1524" layer="21"/>
<wire x1="4.6875" y1="1.95" x2="-4.6875" y2="1.95" width="0.1524" layer="21"/>
<wire x1="-4.6875" y1="1.95" x2="-4.6875" y2="-1.95" width="0.1524" layer="21"/>
<wire x1="-4.6875" y1="-1.95" x2="4.6875" y2="-1.95" width="0.1524" layer="21"/>
<wire x1="5.585" y1="0" x2="6.35" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="1.1" shape="octagon"/>
<text x="-4.445" y="2.54" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.445" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-5.585" y1="-0.3048" x2="-4.6325" y2="0.3048" layer="21"/>
<rectangle x1="4.6325" y1="-0.3048" x2="5.585" y2="0.3048" layer="21"/>
</package>
<package name="R4527" urn="urn:adsk.eagle:footprint:13246/1" library_version="11">
<description>&lt;b&gt;Package 4527&lt;/b&gt;&lt;p&gt;
Source: http://www.vishay.com/docs/31059/wsrhigh.pdf</description>
<wire x1="-5.675" y1="-3.375" x2="5.65" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="5.65" y1="-3.375" x2="5.65" y2="3.375" width="0.2032" layer="51"/>
<wire x1="5.65" y1="3.375" x2="-5.675" y2="3.375" width="0.2032" layer="21"/>
<wire x1="-5.675" y1="3.375" x2="-5.675" y2="-3.375" width="0.2032" layer="51"/>
<smd name="1" x="-4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<smd name="2" x="4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<text x="-5.715" y="3.81" size="1.27" layer="25">&gt;NAME</text>
<text x="-5.715" y="-5.08" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC0001" urn="urn:adsk.eagle:footprint:25692/1" library_version="11">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="-1.8" width="0.2032" layer="51"/>
<wire x1="-3.075" y1="-1.8" x2="3.075" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.075" y1="-1.8" x2="3.075" y2="1.8" width="0.2032" layer="51"/>
<wire x1="3.075" y1="1.8" x2="-3.075" y2="1.8" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="1.606" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="-1.606" x2="-3.075" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.075" y1="1.606" x2="3.075" y2="1.8" width="0.2032" layer="21"/>
<wire x1="3.075" y1="-1.8" x2="3.075" y2="-1.606" width="0.2032" layer="21"/>
<smd name="1" x="-2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<smd name="2" x="2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<text x="-2.544" y="2.229" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.544" y="-3.501" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC0002" urn="urn:adsk.eagle:footprint:25693/1" library_version="11">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-5.55" y1="3.375" x2="-5.55" y2="-3.375" width="0.2032" layer="51"/>
<wire x1="-5.55" y1="-3.375" x2="5.55" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="5.55" y1="-3.375" x2="5.55" y2="3.375" width="0.2032" layer="51"/>
<wire x1="5.55" y1="3.375" x2="-5.55" y2="3.375" width="0.2032" layer="21"/>
<smd name="1" x="-4.575" y="0.025" dx="3.94" dy="5.84" layer="1"/>
<smd name="2" x="4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<text x="-5.65" y="3.9" size="1.27" layer="25">&gt;NAME</text>
<text x="-5.65" y="-5.15" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC01/2" urn="urn:adsk.eagle:footprint:25694/1" library_version="11">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-2.45" y1="1.475" x2="-2.45" y2="-1.475" width="0.2032" layer="51"/>
<wire x1="-2.45" y1="-1.475" x2="2.45" y2="-1.475" width="0.2032" layer="21"/>
<wire x1="2.45" y1="-1.475" x2="2.45" y2="1.475" width="0.2032" layer="51"/>
<wire x1="2.45" y1="1.475" x2="-2.45" y2="1.475" width="0.2032" layer="21"/>
<wire x1="-2.45" y1="1.475" x2="-2.45" y2="1.106" width="0.2032" layer="21"/>
<wire x1="-2.45" y1="-1.106" x2="-2.45" y2="-1.475" width="0.2032" layer="21"/>
<wire x1="2.45" y1="1.106" x2="2.45" y2="1.475" width="0.2032" layer="21"/>
<wire x1="2.45" y1="-1.475" x2="2.45" y2="-1.106" width="0.2032" layer="21"/>
<smd name="1" x="-2.1" y="0" dx="2.16" dy="1.78" layer="1"/>
<smd name="2" x="2.1" y="0" dx="2.16" dy="1.78" layer="1"/>
<text x="-2.544" y="1.904" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.544" y="-3.176" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC2515" urn="urn:adsk.eagle:footprint:25695/1" library_version="11">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="-1.8" width="0.2032" layer="51"/>
<wire x1="-3.075" y1="-1.8" x2="3.05" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.05" y1="-1.8" x2="3.05" y2="1.8" width="0.2032" layer="51"/>
<wire x1="3.05" y1="1.8" x2="-3.075" y2="1.8" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="1.606" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="-1.606" x2="-3.075" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.05" y1="1.606" x2="3.05" y2="1.8" width="0.2032" layer="21"/>
<wire x1="3.05" y1="-1.8" x2="3.05" y2="-1.606" width="0.2032" layer="21"/>
<smd name="1" x="-2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<smd name="2" x="2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<text x="-3.2" y="2.15" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.2" y="-3.4" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC4527" urn="urn:adsk.eagle:footprint:25696/1" library_version="11">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-5.675" y1="3.4" x2="-5.675" y2="-3.375" width="0.2032" layer="51"/>
<wire x1="-5.675" y1="-3.375" x2="5.675" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="5.675" y1="-3.375" x2="5.675" y2="3.4" width="0.2032" layer="51"/>
<wire x1="5.675" y1="3.4" x2="-5.675" y2="3.4" width="0.2032" layer="21"/>
<smd name="1" x="-4.575" y="0.025" dx="3.94" dy="5.84" layer="1"/>
<smd name="2" x="4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<text x="-5.775" y="3.925" size="1.27" layer="25">&gt;NAME</text>
<text x="-5.775" y="-5.15" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC6927" urn="urn:adsk.eagle:footprint:25697/1" library_version="11">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-8.65" y1="3.375" x2="-8.65" y2="-3.375" width="0.2032" layer="51"/>
<wire x1="-8.65" y1="-3.375" x2="8.65" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="8.65" y1="-3.375" x2="8.65" y2="3.375" width="0.2032" layer="51"/>
<wire x1="8.65" y1="3.375" x2="-8.65" y2="3.375" width="0.2032" layer="21"/>
<smd name="1" x="-7.95" y="0.025" dx="3.94" dy="5.97" layer="1"/>
<smd name="2" x="7.95" y="0" dx="3.94" dy="5.97" layer="1"/>
<text x="-8.75" y="3.9" size="1.27" layer="25">&gt;NAME</text>
<text x="-8.75" y="-5.15" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="R1218" urn="urn:adsk.eagle:footprint:25698/1" library_version="11">
<description>&lt;b&gt;CRCW1218 Thick Film, Rectangular Chip Resistors&lt;/b&gt;&lt;p&gt;
Source: http://www.vishay.com .. dcrcw.pdf</description>
<wire x1="-0.913" y1="-2.219" x2="0.939" y2="-2.219" width="0.1524" layer="51"/>
<wire x1="0.913" y1="2.219" x2="-0.939" y2="2.219" width="0.1524" layer="51"/>
<smd name="1" x="-1.475" y="0" dx="1.05" dy="4.9" layer="1"/>
<smd name="2" x="1.475" y="0" dx="1.05" dy="4.9" layer="1"/>
<text x="-2.54" y="2.54" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.81" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-2.3" x2="-0.9009" y2="2.3" layer="51"/>
<rectangle x1="0.9144" y1="-2.3" x2="1.6645" y2="2.3" layer="51"/>
</package>
<package name="1812X7R" urn="urn:adsk.eagle:footprint:25699/1" library_version="11">
<description>&lt;b&gt;Chip Monolithic Ceramic Capacitors&lt;/b&gt; Medium Voltage High Capacitance for General Use&lt;p&gt;
Source: http://www.murata.com .. GRM43DR72E224KW01.pdf</description>
<wire x1="-1.1" y1="1.5" x2="1.1" y2="1.5" width="0.2032" layer="51"/>
<wire x1="1.1" y1="-1.5" x2="-1.1" y2="-1.5" width="0.2032" layer="51"/>
<wire x1="-0.6" y1="1.5" x2="0.6" y2="1.5" width="0.2032" layer="21"/>
<wire x1="0.6" y1="-1.5" x2="-0.6" y2="-1.5" width="0.2032" layer="21"/>
<smd name="1" x="-1.425" y="0" dx="0.8" dy="3.5" layer="1"/>
<smd name="2" x="1.425" y="0" dx="0.8" dy="3.5" layer="1" rot="R180"/>
<text x="-1.9456" y="1.9958" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.9456" y="-3.7738" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.4" y1="-1.6" x2="-1.1" y2="1.6" layer="51"/>
<rectangle x1="1.1" y1="-1.6" x2="1.4" y2="1.6" layer="51" rot="R180"/>
</package>
<package name="PRL1632" urn="urn:adsk.eagle:footprint:25700/1" library_version="11">
<description>&lt;b&gt;PRL1632 are realized as 1W for 3.2 × 1.6mm(1206)&lt;/b&gt;&lt;p&gt;
Source: http://www.mouser.com/ds/2/392/products_18-2245.pdf</description>
<wire x1="0.7275" y1="-1.5228" x2="-0.7277" y2="-1.5228" width="0.1524" layer="51"/>
<wire x1="0.7275" y1="1.5228" x2="-0.7152" y2="1.5228" width="0.1524" layer="51"/>
<smd name="2" x="0.822" y="0" dx="1" dy="3.2" layer="1"/>
<smd name="1" x="-0.822" y="0" dx="1" dy="3.2" layer="1"/>
<text x="-1.4" y="1.8" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.4" y="-3" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.8" y1="-1.6" x2="-0.4" y2="1.6" layer="51"/>
<rectangle x1="0.4" y1="-1.6" x2="0.8" y2="1.6" layer="51"/>
</package>
<package name="R01005" urn="urn:adsk.eagle:footprint:25701/1" library_version="11">
<smd name="1" x="-0.1625" y="0" dx="0.2" dy="0.25" layer="1"/>
<smd name="2" x="0.1625" y="0" dx="0.2" dy="0.25" layer="1"/>
<text x="-0.4" y="0.3" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.4" y="-1.6" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.2" y1="-0.1" x2="-0.075" y2="0.1" layer="51"/>
<rectangle x1="0.075" y1="-0.1" x2="0.2" y2="0.1" layer="51"/>
<rectangle x1="-0.15" y1="0.05" x2="0.15" y2="0.1" layer="51"/>
<rectangle x1="-0.15" y1="-0.1" x2="0.15" y2="-0.05" layer="51"/>
</package>
</packages>
<packages3d>
<package3d name="CAPC1005X60" urn="urn:adsk.eagle:package:23626/2" type="model" library_version="11">
<description>Chip, 1.00 X 0.50 X 0.60 mm body
&lt;p&gt;Chip package with body size 1.00 X 0.50 X 0.60 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="C0402"/>
</packageinstances>
</package3d>
<package3d name="C0504" urn="urn:adsk.eagle:package:23624/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C0504"/>
</packageinstances>
</package3d>
<package3d name="C0603" urn="urn:adsk.eagle:package:23616/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C0603"/>
</packageinstances>
</package3d>
<package3d name="C0805" urn="urn:adsk.eagle:package:23617/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C0805"/>
</packageinstances>
</package3d>
<package3d name="C1206" urn="urn:adsk.eagle:package:23618/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C1206"/>
</packageinstances>
</package3d>
<package3d name="C1210" urn="urn:adsk.eagle:package:23619/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C1210"/>
</packageinstances>
</package3d>
<package3d name="C1310" urn="urn:adsk.eagle:package:23620/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C1310"/>
</packageinstances>
</package3d>
<package3d name="C1608" urn="urn:adsk.eagle:package:23621/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C1608"/>
</packageinstances>
</package3d>
<package3d name="C1812" urn="urn:adsk.eagle:package:23622/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C1812"/>
</packageinstances>
</package3d>
<package3d name="C1825" urn="urn:adsk.eagle:package:23623/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C1825"/>
</packageinstances>
</package3d>
<package3d name="C2012" urn="urn:adsk.eagle:package:23625/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C2012"/>
</packageinstances>
</package3d>
<package3d name="C3216" urn="urn:adsk.eagle:package:23628/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C3216"/>
</packageinstances>
</package3d>
<package3d name="C3225" urn="urn:adsk.eagle:package:23655/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C3225"/>
</packageinstances>
</package3d>
<package3d name="C4532" urn="urn:adsk.eagle:package:23627/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C4532"/>
</packageinstances>
</package3d>
<package3d name="C4564" urn="urn:adsk.eagle:package:23648/2" type="model" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C4564"/>
</packageinstances>
</package3d>
<package3d name="C025-024X044" urn="urn:adsk.eagle:package:23630/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 mm, outline 2.4 x 4.4 mm</description>
<packageinstances>
<packageinstance name="C025-024X044"/>
</packageinstances>
</package3d>
<package3d name="C025-025X050" urn="urn:adsk.eagle:package:23629/2" type="model" library_version="11">
<description>CAPACITOR
grid 2.5 mm, outline 2.5 x 5 mm</description>
<packageinstances>
<packageinstance name="C025-025X050"/>
</packageinstances>
</package3d>
<package3d name="C025-030X050" urn="urn:adsk.eagle:package:23631/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 mm, outline 3 x 5 mm</description>
<packageinstances>
<packageinstance name="C025-030X050"/>
</packageinstances>
</package3d>
<package3d name="C025-040X050" urn="urn:adsk.eagle:package:23634/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 mm, outline 4 x 5 mm</description>
<packageinstances>
<packageinstance name="C025-040X050"/>
</packageinstances>
</package3d>
<package3d name="C025-050X050" urn="urn:adsk.eagle:package:23633/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 mm, outline 5 x 5 mm</description>
<packageinstances>
<packageinstance name="C025-050X050"/>
</packageinstances>
</package3d>
<package3d name="C025-060X050" urn="urn:adsk.eagle:package:23632/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 mm, outline 6 x 5 mm</description>
<packageinstances>
<packageinstance name="C025-060X050"/>
</packageinstances>
</package3d>
<package3d name="C025_050-024X070" urn="urn:adsk.eagle:package:23639/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 mm + 5 mm, outline 2.4 x 7 mm</description>
<packageinstances>
<packageinstance name="C025_050-024X070"/>
</packageinstances>
</package3d>
<package3d name="C025_050-025X075" urn="urn:adsk.eagle:package:23641/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 + 5 mm, outline 2.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C025_050-025X075"/>
</packageinstances>
</package3d>
<package3d name="C025_050-035X075" urn="urn:adsk.eagle:package:23651/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 + 5 mm, outline 3.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C025_050-035X075"/>
</packageinstances>
</package3d>
<package3d name="C025_050-045X075" urn="urn:adsk.eagle:package:23635/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 + 5 mm, outline 4.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C025_050-045X075"/>
</packageinstances>
</package3d>
<package3d name="C025_050-055X075" urn="urn:adsk.eagle:package:23636/1" type="box" library_version="11">
<description>CAPACITOR
grid 2.5 + 5 mm, outline 5.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C025_050-055X075"/>
</packageinstances>
</package3d>
<package3d name="C050-024X044" urn="urn:adsk.eagle:package:23643/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 2.4 x 4.4 mm</description>
<packageinstances>
<packageinstance name="C050-024X044"/>
</packageinstances>
</package3d>
<package3d name="C050-025X075" urn="urn:adsk.eagle:package:23637/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 2.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-025X075"/>
</packageinstances>
</package3d>
<package3d name="C050-045X075" urn="urn:adsk.eagle:package:23638/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 4.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-045X075"/>
</packageinstances>
</package3d>
<package3d name="C050-030X075" urn="urn:adsk.eagle:package:23640/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 3 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-030X075"/>
</packageinstances>
</package3d>
<package3d name="C050-050X075" urn="urn:adsk.eagle:package:23665/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-050X075"/>
</packageinstances>
</package3d>
<package3d name="C050-055X075" urn="urn:adsk.eagle:package:23642/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 5.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-055X075"/>
</packageinstances>
</package3d>
<package3d name="C050-075X075" urn="urn:adsk.eagle:package:23645/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 7.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-075X075"/>
</packageinstances>
</package3d>
<package3d name="C050H075X075" urn="urn:adsk.eagle:package:23644/1" type="box" library_version="11">
<description>CAPACITOR
Horizontal, grid 5 mm, outline 7.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050H075X075"/>
</packageinstances>
</package3d>
<package3d name="C075-032X103" urn="urn:adsk.eagle:package:23646/1" type="box" library_version="11">
<description>CAPACITOR
grid 7.5 mm, outline 3.2 x 10.3 mm</description>
<packageinstances>
<packageinstance name="C075-032X103"/>
</packageinstances>
</package3d>
<package3d name="C075-042X103" urn="urn:adsk.eagle:package:23656/1" type="box" library_version="11">
<description>CAPACITOR
grid 7.5 mm, outline 4.2 x 10.3 mm</description>
<packageinstances>
<packageinstance name="C075-042X103"/>
</packageinstances>
</package3d>
<package3d name="C075-052X106" urn="urn:adsk.eagle:package:23650/1" type="box" library_version="11">
<description>CAPACITOR
grid 7.5 mm, outline 5.2 x 10.6 mm</description>
<packageinstances>
<packageinstance name="C075-052X106"/>
</packageinstances>
</package3d>
<package3d name="C102-043X133" urn="urn:adsk.eagle:package:23647/1" type="box" library_version="11">
<description>CAPACITOR
grid 10.2 mm, outline 4.3 x 13.3 mm</description>
<packageinstances>
<packageinstance name="C102-043X133"/>
</packageinstances>
</package3d>
<package3d name="C102-054X133" urn="urn:adsk.eagle:package:23649/1" type="box" library_version="11">
<description>CAPACITOR
grid 10.2 mm, outline 5.4 x 13.3 mm</description>
<packageinstances>
<packageinstance name="C102-054X133"/>
</packageinstances>
</package3d>
<package3d name="C102-064X133" urn="urn:adsk.eagle:package:23653/1" type="box" library_version="11">
<description>CAPACITOR
grid 10.2 mm, outline 6.4 x 13.3 mm</description>
<packageinstances>
<packageinstance name="C102-064X133"/>
</packageinstances>
</package3d>
<package3d name="C102_152-062X184" urn="urn:adsk.eagle:package:23652/1" type="box" library_version="11">
<description>CAPACITOR
grid 10.2 mm + 15.2 mm, outline 6.2 x 18.4 mm</description>
<packageinstances>
<packageinstance name="C102_152-062X184"/>
</packageinstances>
</package3d>
<package3d name="C150-054X183" urn="urn:adsk.eagle:package:23669/1" type="box" library_version="11">
<description>CAPACITOR
grid 15 mm, outline 5.4 x 18.3 mm</description>
<packageinstances>
<packageinstance name="C150-054X183"/>
</packageinstances>
</package3d>
<package3d name="C150-064X183" urn="urn:adsk.eagle:package:23654/1" type="box" library_version="11">
<description>CAPACITOR
grid 15 mm, outline 6.4 x 18.3 mm</description>
<packageinstances>
<packageinstance name="C150-064X183"/>
</packageinstances>
</package3d>
<package3d name="C150-072X183" urn="urn:adsk.eagle:package:23657/1" type="box" library_version="11">
<description>CAPACITOR
grid 15 mm, outline 7.2 x 18.3 mm</description>
<packageinstances>
<packageinstance name="C150-072X183"/>
</packageinstances>
</package3d>
<package3d name="C150-084X183" urn="urn:adsk.eagle:package:23658/1" type="box" library_version="11">
<description>CAPACITOR
grid 15 mm, outline 8.4 x 18.3 mm</description>
<packageinstances>
<packageinstance name="C150-084X183"/>
</packageinstances>
</package3d>
<package3d name="C150-091X182" urn="urn:adsk.eagle:package:23659/1" type="box" library_version="11">
<description>CAPACITOR
grid 15 mm, outline 9.1 x 18.2 mm</description>
<packageinstances>
<packageinstance name="C150-091X182"/>
</packageinstances>
</package3d>
<package3d name="C225-062X268" urn="urn:adsk.eagle:package:23661/1" type="box" library_version="11">
<description>CAPACITOR
grid 22.5 mm, outline 6.2 x 26.8 mm</description>
<packageinstances>
<packageinstance name="C225-062X268"/>
</packageinstances>
</package3d>
<package3d name="C225-074X268" urn="urn:adsk.eagle:package:23660/1" type="box" library_version="11">
<description>CAPACITOR
grid 22.5 mm, outline 7.4 x 26.8 mm</description>
<packageinstances>
<packageinstance name="C225-074X268"/>
</packageinstances>
</package3d>
<package3d name="C225-087X268" urn="urn:adsk.eagle:package:23662/1" type="box" library_version="11">
<description>CAPACITOR
grid 22.5 mm, outline 8.7 x 26.8 mm</description>
<packageinstances>
<packageinstance name="C225-087X268"/>
</packageinstances>
</package3d>
<package3d name="C225-108X268" urn="urn:adsk.eagle:package:23663/1" type="box" library_version="11">
<description>CAPACITOR
grid 22.5 mm, outline 10.8 x 26.8 mm</description>
<packageinstances>
<packageinstance name="C225-108X268"/>
</packageinstances>
</package3d>
<package3d name="C225-113X268" urn="urn:adsk.eagle:package:23667/1" type="box" library_version="11">
<description>CAPACITOR
grid 22.5 mm, outline 11.3 x 26.8 mm</description>
<packageinstances>
<packageinstance name="C225-113X268"/>
</packageinstances>
</package3d>
<package3d name="C275-093X316" urn="urn:adsk.eagle:package:23701/1" type="box" library_version="11">
<description>CAPACITOR
grid 27.5 mm, outline 9.3 x 31.6 mm</description>
<packageinstances>
<packageinstance name="C275-093X316"/>
</packageinstances>
</package3d>
<package3d name="C275-113X316" urn="urn:adsk.eagle:package:23673/1" type="box" library_version="11">
<description>CAPACITOR
grid 27.5 mm, outline 11.3 x 31.6 mm</description>
<packageinstances>
<packageinstance name="C275-113X316"/>
</packageinstances>
</package3d>
<package3d name="C275-134X316" urn="urn:adsk.eagle:package:23664/1" type="box" library_version="11">
<description>CAPACITOR
grid 27.5 mm, outline 13.4 x 31.6 mm</description>
<packageinstances>
<packageinstance name="C275-134X316"/>
</packageinstances>
</package3d>
<package3d name="C275-205X316" urn="urn:adsk.eagle:package:23666/1" type="box" library_version="11">
<description>CAPACITOR
grid 27.5 mm, outline 20.5 x 31.6 mm</description>
<packageinstances>
<packageinstance name="C275-205X316"/>
</packageinstances>
</package3d>
<package3d name="C325-137X374" urn="urn:adsk.eagle:package:23672/1" type="box" library_version="11">
<description>CAPACITOR
grid 32.5 mm, outline 13.7 x 37.4 mm</description>
<packageinstances>
<packageinstance name="C325-137X374"/>
</packageinstances>
</package3d>
<package3d name="C325-162X374" urn="urn:adsk.eagle:package:23670/1" type="box" library_version="11">
<description>CAPACITOR
grid 32.5 mm, outline 16.2 x 37.4 mm</description>
<packageinstances>
<packageinstance name="C325-162X374"/>
</packageinstances>
</package3d>
<package3d name="C325-182X374" urn="urn:adsk.eagle:package:23668/1" type="box" library_version="11">
<description>CAPACITOR
grid 32.5 mm, outline 18.2 x 37.4 mm</description>
<packageinstances>
<packageinstance name="C325-182X374"/>
</packageinstances>
</package3d>
<package3d name="C375-192X418" urn="urn:adsk.eagle:package:23674/1" type="box" library_version="11">
<description>CAPACITOR
grid 37.5 mm, outline 19.2 x 41.8 mm</description>
<packageinstances>
<packageinstance name="C375-192X418"/>
</packageinstances>
</package3d>
<package3d name="C375-203X418" urn="urn:adsk.eagle:package:23671/1" type="box" library_version="11">
<description>CAPACITOR
grid 37.5 mm, outline 20.3 x 41.8 mm</description>
<packageinstances>
<packageinstance name="C375-203X418"/>
</packageinstances>
</package3d>
<package3d name="C050-035X075" urn="urn:adsk.eagle:package:23677/1" type="box" library_version="11">
<description>CAPACITOR
grid 5 mm, outline 3.5 x 7.5 mm</description>
<packageinstances>
<packageinstance name="C050-035X075"/>
</packageinstances>
</package3d>
<package3d name="C375-155X418" urn="urn:adsk.eagle:package:23675/1" type="box" library_version="11">
<description>CAPACITOR
grid 37.5 mm, outline 15.5 x 41.8 mm</description>
<packageinstances>
<packageinstance name="C375-155X418"/>
</packageinstances>
</package3d>
<package3d name="C075-063X106" urn="urn:adsk.eagle:package:23678/1" type="box" library_version="11">
<description>CAPACITOR
grid 7.5 mm, outline 6.3 x 10.6 mm</description>
<packageinstances>
<packageinstance name="C075-063X106"/>
</packageinstances>
</package3d>
<package3d name="C275-154X316" urn="urn:adsk.eagle:package:23685/1" type="box" library_version="11">
<description>CAPACITOR
grid 27.5 mm, outline 15.4 x 31.6 mm</description>
<packageinstances>
<packageinstance name="C275-154X316"/>
</packageinstances>
</package3d>
<package3d name="C275-173X316" urn="urn:adsk.eagle:package:23676/1" type="box" library_version="11">
<description>CAPACITOR
grid 27.5 mm, outline 17.3 x 31.6 mm</description>
<packageinstances>
<packageinstance name="C275-173X316"/>
</packageinstances>
</package3d>
<package3d name="C0402K" urn="urn:adsk.eagle:package:23679/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 0204 reflow solder
Metric Code Size 1005</description>
<packageinstances>
<packageinstance name="C0402K"/>
</packageinstances>
</package3d>
<package3d name="C0603K" urn="urn:adsk.eagle:package:23680/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 0603 reflow solder
Metric Code Size 1608</description>
<packageinstances>
<packageinstance name="C0603K"/>
</packageinstances>
</package3d>
<package3d name="C0805K" urn="urn:adsk.eagle:package:23681/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 0805 reflow solder
Metric Code Size 2012</description>
<packageinstances>
<packageinstance name="C0805K"/>
</packageinstances>
</package3d>
<package3d name="C1206K" urn="urn:adsk.eagle:package:23682/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 1206 reflow solder
Metric Code Size 3216</description>
<packageinstances>
<packageinstance name="C1206K"/>
</packageinstances>
</package3d>
<package3d name="C1210K" urn="urn:adsk.eagle:package:23683/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 1210 reflow solder
Metric Code Size 3225</description>
<packageinstances>
<packageinstance name="C1210K"/>
</packageinstances>
</package3d>
<package3d name="C1812K" urn="urn:adsk.eagle:package:23686/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 1812 reflow solder
Metric Code Size 4532</description>
<packageinstances>
<packageinstance name="C1812K"/>
</packageinstances>
</package3d>
<package3d name="C1825K" urn="urn:adsk.eagle:package:23684/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 1825 reflow solder
Metric Code Size 4564</description>
<packageinstances>
<packageinstance name="C1825K"/>
</packageinstances>
</package3d>
<package3d name="C2220K" urn="urn:adsk.eagle:package:23687/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 2220 reflow solderMetric Code Size 5650</description>
<packageinstances>
<packageinstance name="C2220K"/>
</packageinstances>
</package3d>
<package3d name="C2225K" urn="urn:adsk.eagle:package:23692/2" type="model" library_version="11">
<description>Ceramic Chip Capacitor KEMET 2225 reflow solderMetric Code Size 5664</description>
<packageinstances>
<packageinstance name="C2225K"/>
</packageinstances>
</package3d>
<package3d name="HPC0201" urn="urn:adsk.eagle:package:26213/1" type="box" library_version="11">
<description> 
Source: http://www.vishay.com/docs/10129/hpc0201a.pdf</description>
<packageinstances>
<packageinstance name="HPC0201"/>
</packageinstances>
</package3d>
<package3d name="C0201" urn="urn:adsk.eagle:package:23690/2" type="model" library_version="11">
<description>Source: http://www.avxcorp.com/docs/catalogs/cx5r.pdf</description>
<packageinstances>
<packageinstance name="C0201"/>
</packageinstances>
</package3d>
<package3d name="C1808" urn="urn:adsk.eagle:package:23689/2" type="model" library_version="11">
<description>CAPACITOR
Source: AVX .. aphvc.pdf</description>
<packageinstances>
<packageinstance name="C1808"/>
</packageinstances>
</package3d>
<package3d name="C3640" urn="urn:adsk.eagle:package:23693/2" type="model" library_version="11">
<description>CAPACITOR
Source: AVX .. aphvc.pdf</description>
<packageinstances>
<packageinstance name="C3640"/>
</packageinstances>
</package3d>
<package3d name="C01005" urn="urn:adsk.eagle:package:23691/1" type="box" library_version="11">
<description>CAPACITOR</description>
<packageinstances>
<packageinstance name="C01005"/>
</packageinstances>
</package3d>
<package3d name="R0402" urn="urn:adsk.eagle:package:23547/3" type="model" library_version="11">
<description>Chip RESISTOR 0402 EIA (1005 Metric)</description>
<packageinstances>
<packageinstance name="R0402"/>
</packageinstances>
</package3d>
<package3d name="R0603" urn="urn:adsk.eagle:package:23555/3" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R0603"/>
</packageinstances>
</package3d>
<package3d name="R0805" urn="urn:adsk.eagle:package:23553/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R0805"/>
</packageinstances>
</package3d>
<package3d name="R0805W" urn="urn:adsk.eagle:package:23537/2" type="model" library_version="11">
<description>RESISTOR wave soldering</description>
<packageinstances>
<packageinstance name="R0805W"/>
</packageinstances>
</package3d>
<package3d name="R1206" urn="urn:adsk.eagle:package:23540/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R1206"/>
</packageinstances>
</package3d>
<package3d name="R1206W" urn="urn:adsk.eagle:package:23539/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R1206W"/>
</packageinstances>
</package3d>
<package3d name="R1210" urn="urn:adsk.eagle:package:23554/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R1210"/>
</packageinstances>
</package3d>
<package3d name="R1210W" urn="urn:adsk.eagle:package:23541/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R1210W"/>
</packageinstances>
</package3d>
<package3d name="R2010" urn="urn:adsk.eagle:package:23551/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R2010"/>
</packageinstances>
</package3d>
<package3d name="R2010W" urn="urn:adsk.eagle:package:23542/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R2010W"/>
</packageinstances>
</package3d>
<package3d name="R2012" urn="urn:adsk.eagle:package:23543/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R2012"/>
</packageinstances>
</package3d>
<package3d name="R2012W" urn="urn:adsk.eagle:package:23544/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R2012W"/>
</packageinstances>
</package3d>
<package3d name="R2512" urn="urn:adsk.eagle:package:23545/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R2512"/>
</packageinstances>
</package3d>
<package3d name="R2512W" urn="urn:adsk.eagle:package:23565/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R2512W"/>
</packageinstances>
</package3d>
<package3d name="R3216" urn="urn:adsk.eagle:package:23557/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R3216"/>
</packageinstances>
</package3d>
<package3d name="R3216W" urn="urn:adsk.eagle:package:23548/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R3216W"/>
</packageinstances>
</package3d>
<package3d name="R3225" urn="urn:adsk.eagle:package:23549/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R3225"/>
</packageinstances>
</package3d>
<package3d name="R3225W" urn="urn:adsk.eagle:package:23550/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R3225W"/>
</packageinstances>
</package3d>
<package3d name="R5025" urn="urn:adsk.eagle:package:23552/2" type="model" library_version="11">
<description>RESISTOR</description>
<packageinstances>
<packageinstance name="R5025"/>
</packageinstances>
</package3d>
<package3d name="R5025W" urn="urn:adsk.eagle:package:23558/2" type="model" library_version="11">
<description>RESISTOR
wave soldering</description>
<packageinstances>
<packageinstance name="R5025W"/>
</packageinstances>
</package3d>
<package3d name="R6332" urn="urn:adsk.eagle:package:23559/2" type="model" library_version="11">
<description>RESISTOR
Source: http://download.siliconexpert.com/pdfs/2005/02/24/Semi_Ap/2/VSH/Resistor/dcrcwfre.pdf</description>
<packageinstances>
<packageinstance name="R6332"/>
</packageinstances>
</package3d>
<package3d name="R6332W" urn="urn:adsk.eagle:package:26078/2" type="model" library_version="11">
<description>RESISTOR wave soldering
Source: http://download.siliconexpert.com/pdfs/2005/02/24/Semi_Ap/2/VSH/Resistor/dcrcwfre.pdf</description>
<packageinstances>
<packageinstance name="R6332W"/>
</packageinstances>
</package3d>
<package3d name="M0805" urn="urn:adsk.eagle:package:23556/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.10 W</description>
<packageinstances>
<packageinstance name="M0805"/>
</packageinstances>
</package3d>
<package3d name="M1206" urn="urn:adsk.eagle:package:23566/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.25 W</description>
<packageinstances>
<packageinstance name="M1206"/>
</packageinstances>
</package3d>
<package3d name="M1406" urn="urn:adsk.eagle:package:23569/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.12 W</description>
<packageinstances>
<packageinstance name="M1406"/>
</packageinstances>
</package3d>
<package3d name="M2012" urn="urn:adsk.eagle:package:23561/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.10 W</description>
<packageinstances>
<packageinstance name="M2012"/>
</packageinstances>
</package3d>
<package3d name="M2309" urn="urn:adsk.eagle:package:23562/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.25 W</description>
<packageinstances>
<packageinstance name="M2309"/>
</packageinstances>
</package3d>
<package3d name="M3216" urn="urn:adsk.eagle:package:23563/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.25 W</description>
<packageinstances>
<packageinstance name="M3216"/>
</packageinstances>
</package3d>
<package3d name="M3516" urn="urn:adsk.eagle:package:23573/2" type="model" library_version="11">
<description>RESISTOR
MELF 0.12 W</description>
<packageinstances>
<packageinstance name="M3516"/>
</packageinstances>
</package3d>
<package3d name="M5923" urn="urn:adsk.eagle:package:23564/3" type="model" library_version="11">
<description>RESISTOR
MELF 0.25 W</description>
<packageinstances>
<packageinstance name="M5923"/>
</packageinstances>
</package3d>
<package3d name="0204/5" urn="urn:adsk.eagle:package:23488/1" type="box" library_version="11">
<description>RESISTOR
type 0204, grid 5 mm</description>
<packageinstances>
<packageinstance name="0204/5"/>
</packageinstances>
</package3d>
<package3d name="0204/7" urn="urn:adsk.eagle:package:23498/2" type="model" library_version="11">
<description>RESISTOR
type 0204, grid 7.5 mm</description>
<packageinstances>
<packageinstance name="0204/7"/>
</packageinstances>
</package3d>
<package3d name="0204V" urn="urn:adsk.eagle:package:23495/1" type="box" library_version="11">
<description>RESISTOR
type 0204, grid 2.5 mm</description>
<packageinstances>
<packageinstance name="0204V"/>
</packageinstances>
</package3d>
<package3d name="0207/10" urn="urn:adsk.eagle:package:23491/2" type="model" library_version="11">
<description>RESISTOR
type 0207, grid 10 mm</description>
<packageinstances>
<packageinstance name="0207/10"/>
</packageinstances>
</package3d>
<package3d name="0207/12" urn="urn:adsk.eagle:package:23489/1" type="box" library_version="11">
<description>RESISTOR
type 0207, grid 12 mm</description>
<packageinstances>
<packageinstance name="0207/12"/>
</packageinstances>
</package3d>
<package3d name="0207/15" urn="urn:adsk.eagle:package:23492/1" type="box" library_version="11">
<description>RESISTOR
type 0207, grid 15mm</description>
<packageinstances>
<packageinstance name="0207/15"/>
</packageinstances>
</package3d>
<package3d name="0207/2V" urn="urn:adsk.eagle:package:23490/1" type="box" library_version="11">
<description>RESISTOR
type 0207, grid 2.5 mm</description>
<packageinstances>
<packageinstance name="0207/2V"/>
</packageinstances>
</package3d>
<package3d name="0207/5V" urn="urn:adsk.eagle:package:23502/1" type="box" library_version="11">
<description>RESISTOR
type 0207, grid 5 mm</description>
<packageinstances>
<packageinstance name="0207/5V"/>
</packageinstances>
</package3d>
<package3d name="0207/7" urn="urn:adsk.eagle:package:23493/2" type="model" library_version="11">
<description>RESISTOR
type 0207, grid 7.5 mm</description>
<packageinstances>
<packageinstance name="0207/7"/>
</packageinstances>
</package3d>
<package3d name="0309/10" urn="urn:adsk.eagle:package:23567/2" type="model" library_version="11">
<description>RESISTOR
type 0309, grid 10mm</description>
<packageinstances>
<packageinstance name="0309/10"/>
</packageinstances>
</package3d>
<package3d name="0309/12" urn="urn:adsk.eagle:package:23571/1" type="box" library_version="11">
<description>RESISTOR
type 0309, grid 12.5 mm</description>
<packageinstances>
<packageinstance name="0309/12"/>
</packageinstances>
</package3d>
<package3d name="0309V" urn="urn:adsk.eagle:package:23572/1" type="box" library_version="11">
<description>RESISTOR
type 0309, grid 2.5 mm</description>
<packageinstances>
<packageinstance name="0309V"/>
</packageinstances>
</package3d>
<package3d name="0411/12" urn="urn:adsk.eagle:package:23578/1" type="box" library_version="11">
<description>RESISTOR
type 0411, grid 12.5 mm</description>
<packageinstances>
<packageinstance name="0411/12"/>
</packageinstances>
</package3d>
<package3d name="0411/15" urn="urn:adsk.eagle:package:23568/2" type="model" library_version="11">
<description>RESISTOR
type 0411, grid 15 mm</description>
<packageinstances>
<packageinstance name="0411/15"/>
</packageinstances>
</package3d>
<package3d name="0411V" urn="urn:adsk.eagle:package:23570/1" type="box" library_version="11">
<description>RESISTOR
type 0411, grid 3.81 mm</description>
<packageinstances>
<packageinstance name="0411V"/>
</packageinstances>
</package3d>
<package3d name="0414/15" urn="urn:adsk.eagle:package:23579/2" type="model" library_version="11">
<description>RESISTOR
type 0414, grid 15 mm</description>
<packageinstances>
<packageinstance name="0414/15"/>
</packageinstances>
</package3d>
<package3d name="0414V" urn="urn:adsk.eagle:package:23574/1" type="box" library_version="11">
<description>RESISTOR
type 0414, grid 5 mm</description>
<packageinstances>
<packageinstance name="0414V"/>
</packageinstances>
</package3d>
<package3d name="0617/17" urn="urn:adsk.eagle:package:23575/2" type="model" library_version="11">
<description>RESISTOR
type 0617, grid 17.5 mm</description>
<packageinstances>
<packageinstance name="0617/17"/>
</packageinstances>
</package3d>
<package3d name="0617/22" urn="urn:adsk.eagle:package:23577/1" type="box" library_version="11">
<description>RESISTOR
type 0617, grid 22.5 mm</description>
<packageinstances>
<packageinstance name="0617/22"/>
</packageinstances>
</package3d>
<package3d name="0617V" urn="urn:adsk.eagle:package:23576/1" type="box" library_version="11">
<description>RESISTOR
type 0617, grid 5 mm</description>
<packageinstances>
<packageinstance name="0617V"/>
</packageinstances>
</package3d>
<package3d name="0922/22" urn="urn:adsk.eagle:package:23580/2" type="model" library_version="11">
<description>RESISTOR
type 0922, grid 22.5 mm</description>
<packageinstances>
<packageinstance name="0922/22"/>
</packageinstances>
</package3d>
<package3d name="P0613V" urn="urn:adsk.eagle:package:23582/1" type="box" library_version="11">
<description>RESISTOR
type 0613, grid 5 mm</description>
<packageinstances>
<packageinstance name="P0613V"/>
</packageinstances>
</package3d>
<package3d name="P0613/15" urn="urn:adsk.eagle:package:23581/2" type="model" library_version="11">
<description>RESISTOR
type 0613, grid 15 mm</description>
<packageinstances>
<packageinstance name="P0613/15"/>
</packageinstances>
</package3d>
<package3d name="P0817/22" urn="urn:adsk.eagle:package:23583/1" type="box" library_version="11">
<description>RESISTOR
type 0817, grid 22.5 mm</description>
<packageinstances>
<packageinstance name="P0817/22"/>
</packageinstances>
</package3d>
<package3d name="P0817V" urn="urn:adsk.eagle:package:23608/1" type="box" library_version="11">
<description>RESISTOR
type 0817, grid 6.35 mm</description>
<packageinstances>
<packageinstance name="P0817V"/>
</packageinstances>
</package3d>
<package3d name="V234/12" urn="urn:adsk.eagle:package:23592/1" type="box" library_version="11">
<description>RESISTOR
type V234, grid 12.5 mm</description>
<packageinstances>
<packageinstance name="V234/12"/>
</packageinstances>
</package3d>
<package3d name="V235/17" urn="urn:adsk.eagle:package:23586/2" type="model" library_version="11">
<description>RESISTOR
type V235, grid 17.78 mm</description>
<packageinstances>
<packageinstance name="V235/17"/>
</packageinstances>
</package3d>
<package3d name="V526-0" urn="urn:adsk.eagle:package:23590/1" type="box" library_version="11">
<description>RESISTOR
type V526-0, grid 2.5 mm</description>
<packageinstances>
<packageinstance name="V526-0"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0102R" urn="urn:adsk.eagle:package:23591/2" type="model" library_version="11">
<description>CECC Size RC2211 Reflow Soldering
source Beyschlag</description>
<packageinstances>
<packageinstance name="MINI_MELF-0102R"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0102W" urn="urn:adsk.eagle:package:23588/2" type="model" library_version="11">
<description>CECC Size RC2211 Wave Soldering
source Beyschlag</description>
<packageinstances>
<packageinstance name="MINI_MELF-0102W"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0204R" urn="urn:adsk.eagle:package:26109/2" type="model" library_version="11">
<description>CECC Size RC3715 Reflow Soldering
source Beyschlag</description>
<packageinstances>
<packageinstance name="MINI_MELF-0204R"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0204W" urn="urn:adsk.eagle:package:26111/2" type="model" library_version="11">
<description>CECC Size RC3715 Wave Soldering
source Beyschlag</description>
<packageinstances>
<packageinstance name="MINI_MELF-0204W"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0207R" urn="urn:adsk.eagle:package:26113/2" type="model" library_version="11">
<description>CECC Size RC6123 Reflow Soldering
source Beyschlag</description>
<packageinstances>
<packageinstance name="MINI_MELF-0207R"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0207W" urn="urn:adsk.eagle:package:26112/2" type="model" library_version="11">
<description>CECC Size RC6123 Wave Soldering
source Beyschlag</description>
<packageinstances>
<packageinstance name="MINI_MELF-0207W"/>
</packageinstances>
</package3d>
<package3d name="0922V" urn="urn:adsk.eagle:package:23589/1" type="box" library_version="11">
<description>RESISTOR
type 0922, grid 7.5 mm</description>
<packageinstances>
<packageinstance name="0922V"/>
</packageinstances>
</package3d>
<package3d name="RDH/15" urn="urn:adsk.eagle:package:23595/1" type="box" library_version="11">
<description>RESISTOR
type RDH, grid 15 mm</description>
<packageinstances>
<packageinstance name="RDH/15"/>
</packageinstances>
</package3d>
<package3d name="MINI_MELF-0102AX" urn="urn:adsk.eagle:package:23594/1" type="box" library_version="11">
<description>Mini MELF 0102 Axial</description>
<packageinstances>
<packageinstance name="MINI_MELF-0102AX"/>
</packageinstances>
</package3d>
<package3d name="R0201" urn="urn:adsk.eagle:package:26117/2" type="model" library_version="11">
<description>RESISTOR chip
Source: http://www.vishay.com/docs/20008/dcrcw.pdf</description>
<packageinstances>
<packageinstance name="R0201"/>
</packageinstances>
</package3d>
<package3d name="VTA52" urn="urn:adsk.eagle:package:26116/2" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RBR52
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VTA52"/>
</packageinstances>
</package3d>
<package3d name="VTA53" urn="urn:adsk.eagle:package:26118/2" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RBR53
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VTA53"/>
</packageinstances>
</package3d>
<package3d name="VTA54" urn="urn:adsk.eagle:package:26119/2" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RBR54
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VTA54"/>
</packageinstances>
</package3d>
<package3d name="VTA55" urn="urn:adsk.eagle:package:26120/2" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RBR55
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VTA55"/>
</packageinstances>
</package3d>
<package3d name="VTA56" urn="urn:adsk.eagle:package:26129/3" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RBR56
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VTA56"/>
</packageinstances>
</package3d>
<package3d name="VMTA55" urn="urn:adsk.eagle:package:26121/2" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RNC55
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VMTA55"/>
</packageinstances>
</package3d>
<package3d name="VMTB60" urn="urn:adsk.eagle:package:26122/2" type="model" library_version="11">
<description>Bulk Metal® Foil Technology, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements
MIL SIZE RNC60
Source: VISHAY .. vta56.pdf</description>
<packageinstances>
<packageinstance name="VMTB60"/>
</packageinstances>
</package3d>
<package3d name="R4527" urn="urn:adsk.eagle:package:13310/2" type="model" library_version="11">
<description>Package 4527
Source: http://www.vishay.com/docs/31059/wsrhigh.pdf</description>
<packageinstances>
<packageinstance name="R4527"/>
</packageinstances>
</package3d>
<package3d name="WSC0001" urn="urn:adsk.eagle:package:26123/2" type="model" library_version="11">
<description>Wirewound Resistors, Precision Power
Source: VISHAY wscwsn.pdf</description>
<packageinstances>
<packageinstance name="WSC0001"/>
</packageinstances>
</package3d>
<package3d name="WSC0002" urn="urn:adsk.eagle:package:26125/2" type="model" library_version="11">
<description>Wirewound Resistors, Precision Power
Source: VISHAY wscwsn.pdf</description>
<packageinstances>
<packageinstance name="WSC0002"/>
</packageinstances>
</package3d>
<package3d name="WSC01/2" urn="urn:adsk.eagle:package:26127/2" type="model" library_version="11">
<description>Wirewound Resistors, Precision Power
Source: VISHAY wscwsn.pdf</description>
<packageinstances>
<packageinstance name="WSC01/2"/>
</packageinstances>
</package3d>
<package3d name="WSC2515" urn="urn:adsk.eagle:package:26134/2" type="model" library_version="11">
<description>Wirewound Resistors, Precision Power
Source: VISHAY wscwsn.pdf</description>
<packageinstances>
<packageinstance name="WSC2515"/>
</packageinstances>
</package3d>
<package3d name="WSC4527" urn="urn:adsk.eagle:package:26126/2" type="model" library_version="11">
<description>Wirewound Resistors, Precision Power
Source: VISHAY wscwsn.pdf</description>
<packageinstances>
<packageinstance name="WSC4527"/>
</packageinstances>
</package3d>
<package3d name="WSC6927" urn="urn:adsk.eagle:package:26128/2" type="model" library_version="11">
<description>Wirewound Resistors, Precision Power
Source: VISHAY wscwsn.pdf</description>
<packageinstances>
<packageinstance name="WSC6927"/>
</packageinstances>
</package3d>
<package3d name="R1218" urn="urn:adsk.eagle:package:26131/2" type="model" library_version="11">
<description>CRCW1218 Thick Film, Rectangular Chip Resistors
Source: http://www.vishay.com .. dcrcw.pdf</description>
<packageinstances>
<packageinstance name="R1218"/>
</packageinstances>
</package3d>
<package3d name="1812X7R" urn="urn:adsk.eagle:package:26130/2" type="model" library_version="11">
<description>Chip Monolithic Ceramic Capacitors Medium Voltage High Capacitance for General Use
Source: http://www.murata.com .. GRM43DR72E224KW01.pdf</description>
<packageinstances>
<packageinstance name="1812X7R"/>
</packageinstances>
</package3d>
<package3d name="PRL1632" urn="urn:adsk.eagle:package:26132/2" type="model" library_version="11">
<description>PRL1632 are realized as 1W for 3.2 × 1.6mm(1206)
Source: http://www.mouser.com/ds/2/392/products_18-2245.pdf</description>
<packageinstances>
<packageinstance name="PRL1632"/>
</packageinstances>
</package3d>
<package3d name="R01005" urn="urn:adsk.eagle:package:26133/2" type="model" library_version="11">
<description>Chip, 0.40 X 0.20 X 0.16 mm body
&lt;p&gt;Chip package with body size 0.40 X 0.20 X 0.16 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="R01005"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="C-EU" urn="urn:adsk.eagle:symbol:23120/1" library_version="11">
<wire x1="0" y1="0" x2="0" y2="-0.508" width="0.1524" layer="94"/>
<wire x1="0" y1="-2.54" x2="0" y2="-2.032" width="0.1524" layer="94"/>
<text x="1.524" y="0.381" size="1.778" layer="95">&gt;NAME</text>
<text x="1.524" y="-4.699" size="1.778" layer="96">&gt;VALUE</text>
<rectangle x1="-2.032" y1="-2.032" x2="2.032" y2="-1.524" layer="94"/>
<rectangle x1="-2.032" y1="-1.016" x2="2.032" y2="-0.508" layer="94"/>
<pin name="1" x="0" y="2.54" visible="off" length="short" direction="pas" swaplevel="1" rot="R270"/>
<pin name="2" x="0" y="-5.08" visible="off" length="short" direction="pas" swaplevel="1" rot="R90"/>
</symbol>
<symbol name="R-EU" urn="urn:adsk.eagle:symbol:23042/1" library_version="11">
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="-0.889" x2="2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<text x="-3.81" y="1.4986" size="1.778" layer="95">&gt;NAME</text>
<text x="-3.81" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="C-EU" urn="urn:adsk.eagle:component:23793/46" prefix="C" uservalue="yes" library_version="11">
<description>&lt;B&gt;CAPACITOR&lt;/B&gt;, European symbol</description>
<gates>
<gate name="G$1" symbol="C-EU" x="0" y="0"/>
</gates>
<devices>
<device name="C0402" package="C0402">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23626/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="18" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0504" package="C0504">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23624/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0603" package="C0603">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23616/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="73" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0805" package="C0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23617/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="88" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1206" package="C1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23618/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="54" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1210" package="C1210">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23619/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1310" package="C1310">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23620/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1608" package="C1608">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23621/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1812" package="C1812">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23622/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1825" package="C1825">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23623/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C2012" package="C2012">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23625/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C3216" package="C3216">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23628/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="4" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C3225" package="C3225">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23655/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C4532" package="C4532">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23627/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C4564" package="C4564">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23648/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025-024X044" package="C025-024X044">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23630/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="56" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025-025X050" package="C025-025X050">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23629/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="65" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025-030X050" package="C025-030X050">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23631/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="14" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025-040X050" package="C025-040X050">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23634/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="4" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025-050X050" package="C025-050X050">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23633/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="16" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025-060X050" package="C025-060X050">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23632/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C025_050-024X070" package="C025_050-024X070">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23639/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025_050-025X075" package="C025_050-025X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23641/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025_050-035X075" package="C025_050-035X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23651/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025_050-045X075" package="C025_050-045X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23635/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="025_050-055X075" package="C025_050-055X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23636/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-024X044" package="C050-024X044">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23643/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="33" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-025X075" package="C050-025X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23637/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="29" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-045X075" package="C050-045X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23638/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-030X075" package="C050-030X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23640/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="9" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-050X075" package="C050-050X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23665/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-055X075" package="C050-055X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23642/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-075X075" package="C050-075X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23645/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050H075X075" package="C050H075X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23644/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="075-032X103" package="C075-032X103">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23646/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="075-042X103" package="C075-042X103">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23656/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="075-052X106" package="C075-052X106">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23650/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="4" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="102-043X133" package="C102-043X133">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23647/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="102-054X133" package="C102-054X133">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23649/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="102-064X133" package="C102-064X133">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23653/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="102_152-062X184" package="C102_152-062X184">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23652/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="150-054X183" package="C150-054X183">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23669/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="150-064X183" package="C150-064X183">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23654/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="150-072X183" package="C150-072X183">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23657/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="150-084X183" package="C150-084X183">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23658/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="150-091X182" package="C150-091X182">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23659/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="225-062X268" package="C225-062X268">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23661/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="225-074X268" package="C225-074X268">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23660/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="225-087X268" package="C225-087X268">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23662/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="225-108X268" package="C225-108X268">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23663/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="225-113X268" package="C225-113X268">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23667/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="275-093X316" package="C275-093X316">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23701/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="275-113X316" package="C275-113X316">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23673/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="275-134X316" package="C275-134X316">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23664/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="275-205X316" package="C275-205X316">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23666/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="325-137X374" package="C325-137X374">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23672/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="325-162X374" package="C325-162X374">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23670/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="325-182X374" package="C325-182X374">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23668/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="375-192X418" package="C375-192X418">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23674/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="375-203X418" package="C375-203X418">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23671/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="050-035X075" package="C050-035X075">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23677/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="375-155X418" package="C375-155X418">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23675/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="075-063X106" package="C075-063X106">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23678/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="275-154X316" package="C275-154X316">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23685/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="275-173X316" package="C275-173X316">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23676/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0402K" package="C0402K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23679/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="15" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0603K" package="C0603K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23680/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="30" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0805K" package="C0805K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23681/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="52" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1206K" package="C1206K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23682/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="13" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1210K" package="C1210K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23683/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1812K" package="C1812K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23686/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1825K" package="C1825K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23684/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C2220K" package="C2220K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23687/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C2225K" package="C2225K">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23692/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="HPC0201" package="HPC0201">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26213/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C0201" package="C0201">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23690/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C1808" package="C1808">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23689/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="C3640" package="C3640">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23693/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
<device name="01005" package="C01005">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23691/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="C" constant="no"/>
</technology>
</technologies>
</device>
</devices>
<spice>
<pinmapping spiceprefix="C">
<pinmap gate="G$1" pin="1" pinorder="1"/>
<pinmap gate="G$1" pin="2" pinorder="2"/>
</pinmapping>
</spice>
</deviceset>
<deviceset name="R-EU_" urn="urn:adsk.eagle:component:23791/21" prefix="R" uservalue="yes" library_version="11">
<description>&lt;B&gt;RESISTOR&lt;/B&gt;, European symbol</description>
<gates>
<gate name="G$1" symbol="R-EU" x="0" y="0"/>
</gates>
<devices>
<device name="R0402" package="R0402">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23547/3"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R0603" package="R0603">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23555/3"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="70" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R0805" package="R0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23553/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="86" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R0805W" package="R0805W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23537/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R1206" package="R1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23540/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="41" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R1206W" package="R1206W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23539/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R1210" package="R1210">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23554/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R1210W" package="R1210W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23541/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R2010" package="R2010">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23551/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R2010W" package="R2010W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23542/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R2012" package="R2012">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23543/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R2012W" package="R2012W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23544/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R2512" package="R2512">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23545/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R2512W" package="R2512W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23565/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R3216" package="R3216">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23557/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R3216W" package="R3216W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23548/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="5" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R3225" package="R3225">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23549/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R3225W" package="R3225W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23550/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R5025" package="R5025">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23552/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R5025W" package="R5025W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23558/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R6332" package="R6332">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23559/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R6332W" package="R6332W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26078/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M0805" package="M0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23556/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="45" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M1206" package="M1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23566/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="17" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M1406" package="M1406">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23569/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M2012" package="M2012">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23561/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M2309" package="M2309">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23562/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M3216" package="M3216">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23563/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M3516" package="M3516">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23573/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="M5923" package="M5923">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23564/3"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0204/5" package="0204/5">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23488/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="35" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0204/7" package="0204/7">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23498/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="79" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0204/2V" package="0204V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23495/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="11" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0207/10" package="0207/10">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23491/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="81" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0207/12" package="0207/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23489/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="9" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0207/15" package="0207/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23492/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0207/2V" package="0207/2V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23490/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="17" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0207/5V" package="0207/5V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23502/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="4" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0207/7" package="0207/7">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23493/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="46" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0309/10" package="0309/10">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23567/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0309/12" package="0309/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23571/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="6" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0309/V" package="0309V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23572/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0411/12" package="0411/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23578/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="5" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0411/15" package="0411/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23568/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0411/3V" package="0411V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23570/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="4" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0414/15" package="0414/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23579/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0414/5V" package="0414V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23574/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0617/17" package="0617/17">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23575/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0617/22" package="0617/22">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23577/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="2" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0617/5V" package="0617V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23576/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0922/22" package="0922/22">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23580/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0613/5V" package="P0613V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23582/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0613/15" package="P0613/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23581/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0817/22" package="P0817/22">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23583/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0817/7V" package="P0817V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23608/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="V234/12" package="V234/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23592/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="V235/17" package="V235/17">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23586/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="3" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="V526-0" package="V526-0">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23590/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0102R" package="MINI_MELF-0102R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23591/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0102W" package="MINI_MELF-0102W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23588/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0204R" package="MINI_MELF-0204R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26109/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0204W" package="MINI_MELF-0204W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26111/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0207R" package="MINI_MELF-0207R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26113/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0207W" package="MINI_MELF-0207W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26112/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="0922V" package="0922V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23589/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="RDH/15" package="RDH/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23595/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="1" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF0102AX" package="MINI_MELF-0102AX">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:23594/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R0201" package="R0201">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26117/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VTA52" package="VTA52">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26116/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VTA53" package="VTA53">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26118/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VTA54" package="VTA54">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26119/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VTA55" package="VTA55">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26120/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VTA56" package="VTA56">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26129/3"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VMTA55" package="VMTA55">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26121/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="VMTB60" package="VMTB60">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26122/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R4527" package="R4527">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:13310/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="WSC0001" package="WSC0001">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26123/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="WSC0002" package="WSC0002">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26125/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="WSC01/2" package="WSC01/2">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26127/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="WSC2515" package="WSC2515">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26134/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="WSC4527" package="WSC4527">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26126/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="WSC6927" package="WSC6927">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26128/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="R1218" package="R1218">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26131/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="1812X7R" package="1812X7R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26130/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="PRL1632" package="PRL1632">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26132/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
<device name="01005" package="R01005">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:26133/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
<attribute name="SPICEPREFIX" value="R" constant="no"/>
</technology>
</technologies>
</device>
</devices>
<spice>
<pinmapping spiceprefix="R">
<pinmap gate="G$1" pin="1" pinorder="1"/>
<pinmap gate="G$1" pin="2" pinorder="2"/>
</pinmapping>
</spice>
</deviceset>
</devicesets>
</library>
<library name="My_Library">
<packages>
<package name="M08A">
<smd name="1" x="-2.4638" y="1.905" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="2" x="-2.4638" y="0.635" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="3" x="-2.4638" y="-0.635" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="4" x="-2.4638" y="-1.905" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="5" x="2.4638" y="-1.905" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="6" x="2.4638" y="-0.635" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="7" x="2.4638" y="0.635" dx="1.9812" dy="0.5588" layer="1"/>
<smd name="8" x="2.4638" y="1.905" dx="1.9812" dy="0.5588" layer="1"/>
<wire x1="-1.9812" y1="1.651" x2="-1.9812" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="2.159" x2="-3.0988" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="2.159" x2="-3.0988" y2="1.651" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="1.651" x2="-1.9812" y2="1.651" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="0.381" x2="-1.9812" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="0.889" x2="-3.0988" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="0.889" x2="-3.0988" y2="0.381" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="0.381" x2="-1.9812" y2="0.381" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-0.889" x2="-1.9812" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-0.381" x2="-3.0988" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-0.381" x2="-3.0988" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-0.889" x2="-1.9812" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-2.159" x2="-1.9812" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-1.651" x2="-3.0988" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-1.651" x2="-3.0988" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-2.159" x2="-1.9812" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-1.651" x2="1.9812" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-2.159" x2="3.0988" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-2.159" x2="3.0988" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-1.651" x2="1.9812" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-0.381" x2="1.9812" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-0.889" x2="3.0988" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-0.889" x2="3.0988" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-0.381" x2="1.9812" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="0.889" x2="1.9812" y2="0.381" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="0.381" x2="3.0988" y2="0.381" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="0.381" x2="3.0988" y2="0.889" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="0.889" x2="1.9812" y2="0.889" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="2.159" x2="1.9812" y2="1.651" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="1.651" x2="3.0988" y2="1.651" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="1.651" x2="3.0988" y2="2.159" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="2.159" x2="1.9812" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-2.4892" x2="1.9812" y2="-2.4892" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-2.4892" x2="1.9812" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="2.4892" x2="-0.3048" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="-0.3048" y1="2.4892" x2="-1.9812" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="2.4892" x2="-1.9812" y2="-2.4892" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="2.5146" x2="-0.3048" y2="2.4892" width="0.1524" layer="51" curve="-180"/>
<text x="-3.302" y="2.3368" size="1.27" layer="51" ratio="6" rot="SR0">*</text>
<wire x1="-1.9812" y1="0" x2="-1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.9812" y2="4.7752" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="0" x2="1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.9812" y2="4.7752" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.7272" y2="4.5212" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="-1.7272" y1="4.5212" x2="-1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.7272" y2="4.5212" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="1.7272" y1="4.5212" x2="1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.7752" x2="-3.0988" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-3.0988" y2="6.7056" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="0" x2="3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="3.0988" y2="6.7056" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-2.8448" y2="6.4516" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="-2.8448" y1="6.4516" x2="-2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="2.8448" y2="6.4516" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="2.8448" y1="6.4516" x2="2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="0" y1="2.4892" x2="4.5212" y2="2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.9276" y2="2.4892" width="0.1524" layer="47"/>
<wire x1="0" y1="-2.4892" x2="4.5212" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.9276" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.5212" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.4196" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.6736" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.4196" y1="2.2352" x2="4.6736" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.4196" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.6736" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="4.4196" y1="-2.2352" x2="4.6736" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="-2.4638" y1="1.905" x2="-5.0038" y2="1.905" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="1.905" x2="-5.3848" y2="1.905" width="0.1524" layer="47"/>
<wire x1="-2.4638" y1="0.635" x2="-5.0038" y2="0.635" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="0.635" x2="-5.3848" y2="0.635" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="1.905" x2="-5.0038" y2="3.175" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="0.635" x2="-5.0038" y2="-0.635" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="1.905" x2="-5.1308" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="1.905" x2="-4.8768" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.1308" y1="2.159" x2="-4.8768" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="0.635" x2="-5.1308" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-5.0038" y1="0.635" x2="-4.8768" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-5.1308" y1="0.381" x2="-4.8768" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-1.8288" y1="0" x2="-1.8288" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-1.8288" y1="-4.4196" x2="-1.8288" y2="-4.7752" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-4.3688" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-1.8288" y1="-4.4196" x2="-0.5588" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.3528" y2="-4.2672" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.3528" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-3.3528" y1="-4.2672" x2="-3.3528" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-1.8288" y1="-4.4196" x2="-1.5748" y2="-4.2672" width="0.1524" layer="47"/>
<wire x1="-1.8288" y1="-4.4196" x2="-1.5748" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-1.5748" y1="-4.2672" x2="-1.5748" y2="-4.5212" width="0.1524" layer="47"/>
<text x="-15.2146" y="-7.5692" size="1.27" layer="47" ratio="6" rot="SR0">Default Padstyle: RX78Y22D0T</text>
<text x="-15.5702" y="-9.4996" size="1.27" layer="47" ratio="6" rot="SR0">Pin One Padstyle: RX78Y22D0T</text>
<text x="-14.8082" y="-11.3792" size="1.27" layer="47" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-13.3096" size="1.27" layer="47" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-3.7592" y="4.9276" size="0.635" layer="47" ratio="4" rot="SR0">.157in/3.988mm</text>
<text x="-3.7592" y="6.8072" size="0.635" layer="47" ratio="4" rot="SR0">.244in/6.198mm</text>
<text x="5.0292" y="-0.3048" size="0.635" layer="47" ratio="4" rot="SR0">.197in/5.004mm</text>
<text x="-11.8618" y="0.9652" size="0.635" layer="47" ratio="4" rot="SR0">.05in/1.27mm</text>
<text x="-5.6388" y="-5.5372" size="0.635" layer="47" ratio="4" rot="SR0">.05in/1.27mm</text>
<wire x1="-1.3716" y1="-2.4892" x2="1.3716" y2="-2.4892" width="0.1524" layer="21"/>
<wire x1="1.3716" y1="2.4892" x2="-0.3048" y2="2.4892" width="0.1524" layer="21"/>
<wire x1="-0.3048" y1="2.4892" x2="-1.3716" y2="2.4892" width="0.1524" layer="21"/>
<wire x1="0.3048" y1="2.5146" x2="-0.3048" y2="2.4892" width="0.1524" layer="21" curve="-180"/>
<text x="-3.302" y="2.3368" size="1.27" layer="21" ratio="6" rot="SR0">*</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
<package name="M08A-M">
<smd name="1" x="-2.82575" y="1.905" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="2" x="-2.82575" y="0.635" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="3" x="-2.82575" y="-0.635" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="4" x="-2.82575" y="-1.905" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="5" x="2.82575" y="-1.905" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="6" x="2.82575" y="-0.635" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="7" x="2.82575" y="0.635" dx="1.6637" dy="0.5588" layer="1"/>
<smd name="8" x="2.82575" y="1.905" dx="1.6637" dy="0.5588" layer="1"/>
<wire x1="-1.9812" y1="1.651" x2="-1.9812" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="2.159" x2="-3.0988" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="2.159" x2="-3.0988" y2="1.651" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="1.651" x2="-1.9812" y2="1.651" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="0.381" x2="-1.9812" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="0.889" x2="-3.0988" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="0.889" x2="-3.0988" y2="0.381" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="0.381" x2="-1.9812" y2="0.381" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-0.889" x2="-1.9812" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-0.381" x2="-3.0988" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-0.381" x2="-3.0988" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-0.889" x2="-1.9812" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-2.159" x2="-1.9812" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-1.651" x2="-3.0988" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-1.651" x2="-3.0988" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-2.159" x2="-1.9812" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-1.651" x2="1.9812" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-2.159" x2="3.0988" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-2.159" x2="3.0988" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-1.651" x2="1.9812" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-0.381" x2="1.9812" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-0.889" x2="3.0988" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-0.889" x2="3.0988" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-0.381" x2="1.9812" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="0.889" x2="1.9812" y2="0.381" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="0.381" x2="3.0988" y2="0.381" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="0.381" x2="3.0988" y2="0.889" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="0.889" x2="1.9812" y2="0.889" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="2.159" x2="1.9812" y2="1.651" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="1.651" x2="3.0988" y2="1.651" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="1.651" x2="3.0988" y2="2.159" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="2.159" x2="1.9812" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-2.4892" x2="1.9812" y2="-2.4892" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-2.4892" x2="1.9812" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="2.4892" x2="-0.3048" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="-0.3048" y1="2.4892" x2="-1.9812" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="2.4892" x2="-1.9812" y2="-2.4892" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="2.5146" x2="-0.3048" y2="2.4892" width="0.1524" layer="51" curve="-180"/>
<text x="-2.1844" y="1.1684" size="1.27" layer="51" ratio="6" rot="SR0">*</text>
<wire x1="-1.9812" y1="4.4196" x2="-1.9812" y2="4.7752" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="0" x2="1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.9812" y2="4.7752" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.7272" y2="4.5212" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="-1.7272" y1="4.5212" x2="-1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.7272" y2="4.5212" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="1.7272" y1="4.5212" x2="1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.7752" x2="-3.0988" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-3.0988" y2="6.7056" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="0" x2="3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="3.0988" y2="6.7056" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-2.8448" y2="6.4516" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="-2.8448" y1="6.4516" x2="-2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="2.8448" y2="6.4516" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="2.8448" y1="6.4516" x2="2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="0" y1="2.4892" x2="4.5212" y2="2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.9276" y2="2.4892" width="0.1524" layer="47"/>
<wire x1="0" y1="-2.4892" x2="4.5212" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.9276" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.5212" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.4196" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.6736" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.4196" y1="2.2352" x2="4.6736" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.4196" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.6736" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="4.4196" y1="-2.2352" x2="4.6736" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="-2.8194" y1="1.905" x2="-5.3594" y2="1.905" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="1.905" x2="-5.7404" y2="1.905" width="0.1524" layer="47"/>
<wire x1="-2.8194" y1="0.635" x2="-5.3594" y2="0.635" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="0.635" x2="-5.7404" y2="0.635" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="1.905" x2="-5.3594" y2="3.175" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="0.635" x2="-5.3594" y2="-0.635" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="1.905" x2="-5.4864" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="1.905" x2="-5.2324" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.4864" y1="2.159" x2="-5.2324" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="0.635" x2="-5.4864" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-5.3594" y1="0.635" x2="-5.2324" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-5.4864" y1="0.381" x2="-5.2324" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.9812" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-1.9812" y2="-4.7752" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-4.3688" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-0.7112" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.3528" y2="-4.2672" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.3528" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-3.3528" y1="-4.2672" x2="-3.3528" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-1.7272" y2="-4.2672" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-1.7272" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-1.7272" y1="-4.2672" x2="-1.7272" y2="-4.5212" width="0.1524" layer="47"/>
<text x="-16.3576" y="-7.5692" size="1.27" layer="47" ratio="6" rot="SR0">Default Padstyle: RX65p5Y22D0T</text>
<text x="-16.7386" y="-9.0932" size="1.27" layer="47" ratio="6" rot="SR0">Pin One Padstyle: RX65p5Y22D0T</text>
<text x="-14.8082" y="-13.6652" size="1.27" layer="47" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-15.1892" size="1.27" layer="47" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-4.0386" y="4.9276" size="0.635" layer="47" ratio="4" rot="SR0">0.157in/3.988mm</text>
<text x="-4.0386" y="6.8072" size="0.635" layer="47" ratio="4" rot="SR0">0.244in/6.198mm</text>
<text x="5.0292" y="-0.3048" size="0.635" layer="47" ratio="4" rot="SR0">0.197in/5.004mm</text>
<text x="-12.8016" y="0.9652" size="0.635" layer="47" ratio="4" rot="SR0">0.05in/1.27mm</text>
<text x="-6.0198" y="-5.5372" size="0.635" layer="47" ratio="4" rot="SR0">0.05in/1.27mm</text>
<wire x1="-2.1336" y1="-2.6416" x2="2.1336" y2="-2.6416" width="0.1524" layer="21"/>
<wire x1="2.1336" y1="2.6416" x2="-2.1336" y2="2.6416" width="0.1524" layer="21"/>
<text x="-3.6576" y="2.3368" size="1.27" layer="21" ratio="6" rot="SR0">*</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
<package name="M08A-L">
<smd name="1" x="-2.62255" y="1.905" dx="1.2573" dy="0.508" layer="1"/>
<smd name="2" x="-2.62255" y="0.635" dx="1.2573" dy="0.508" layer="1"/>
<smd name="3" x="-2.62255" y="-0.635" dx="1.2573" dy="0.508" layer="1"/>
<smd name="4" x="-2.62255" y="-1.905" dx="1.2573" dy="0.508" layer="1"/>
<smd name="5" x="2.62255" y="-1.905" dx="1.2573" dy="0.508" layer="1"/>
<smd name="6" x="2.62255" y="-0.635" dx="1.2573" dy="0.508" layer="1"/>
<smd name="7" x="2.62255" y="0.635" dx="1.2573" dy="0.508" layer="1"/>
<smd name="8" x="2.62255" y="1.905" dx="1.2573" dy="0.508" layer="1"/>
<wire x1="-1.9812" y1="1.651" x2="-1.9812" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="2.159" x2="-3.0988" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="2.159" x2="-3.0988" y2="1.651" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="1.651" x2="-1.9812" y2="1.651" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="0.381" x2="-1.9812" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="0.889" x2="-3.0988" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="0.889" x2="-3.0988" y2="0.381" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="0.381" x2="-1.9812" y2="0.381" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-0.889" x2="-1.9812" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-0.381" x2="-3.0988" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-0.381" x2="-3.0988" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-0.889" x2="-1.9812" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-2.159" x2="-1.9812" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-1.651" x2="-3.0988" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-1.651" x2="-3.0988" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="-3.0988" y1="-2.159" x2="-1.9812" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-1.651" x2="1.9812" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-2.159" x2="3.0988" y2="-2.159" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-2.159" x2="3.0988" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-1.651" x2="1.9812" y2="-1.651" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-0.381" x2="1.9812" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-0.889" x2="3.0988" y2="-0.889" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-0.889" x2="3.0988" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="-0.381" x2="1.9812" y2="-0.381" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="0.889" x2="1.9812" y2="0.381" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="0.381" x2="3.0988" y2="0.381" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="0.381" x2="3.0988" y2="0.889" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="0.889" x2="1.9812" y2="0.889" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="2.159" x2="1.9812" y2="1.651" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="1.651" x2="3.0988" y2="1.651" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="1.651" x2="3.0988" y2="2.159" width="0.1524" layer="51"/>
<wire x1="3.0988" y1="2.159" x2="1.9812" y2="2.159" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="-2.4892" x2="1.9812" y2="-2.4892" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="-2.4892" x2="1.9812" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="1.9812" y1="2.4892" x2="-0.3048" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="-0.3048" y1="2.4892" x2="-1.9812" y2="2.4892" width="0.1524" layer="51"/>
<wire x1="-1.9812" y1="2.4892" x2="-1.9812" y2="-2.4892" width="0.1524" layer="51"/>
<wire x1="0.3048" y1="2.5146" x2="-0.3048" y2="2.4892" width="0.1524" layer="51" curve="-180"/>
<text x="-2.1844" y="1.1684" size="1.27" layer="51" ratio="6" rot="SR0">*</text>
<wire x1="-1.9812" y1="4.4196" x2="-1.9812" y2="4.7752" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="0" x2="1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.9812" y2="4.7752" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="1.9812" y2="4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.7272" y2="4.5212" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="-1.7272" y1="4.5212" x2="-1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.7272" y2="4.5212" width="0.1524" layer="47"/>
<wire x1="1.9812" y1="4.4196" x2="1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="1.7272" y1="4.5212" x2="1.7272" y2="4.2672" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.7752" x2="-3.0988" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-3.0988" y2="6.7056" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="0" x2="3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="3.0988" y2="6.7056" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="3.0988" y2="6.2992" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-2.8448" y2="6.4516" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="6.2992" x2="-2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="-2.8448" y1="6.4516" x2="-2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="2.8448" y2="6.4516" width="0.1524" layer="47"/>
<wire x1="3.0988" y1="6.2992" x2="2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="2.8448" y1="6.4516" x2="2.8448" y2="6.1976" width="0.1524" layer="47"/>
<wire x1="0" y1="2.4892" x2="4.5212" y2="2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.9276" y2="2.4892" width="0.1524" layer="47"/>
<wire x1="0" y1="-2.4892" x2="4.5212" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.9276" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.5212" y2="-2.4892" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.4196" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="2.4892" x2="4.6736" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.4196" y1="2.2352" x2="4.6736" y2="2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.4196" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="4.5212" y1="-2.4892" x2="4.6736" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="4.4196" y1="-2.2352" x2="4.6736" y2="-2.2352" width="0.1524" layer="47"/>
<wire x1="-2.6162" y1="1.905" x2="-5.1562" y2="1.905" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="1.905" x2="-5.5372" y2="1.905" width="0.1524" layer="47"/>
<wire x1="-2.6162" y1="0.635" x2="-5.1562" y2="0.635" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="0.635" x2="-5.5372" y2="0.635" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="1.905" x2="-5.1562" y2="3.175" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="0.635" x2="-5.1562" y2="-0.635" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="1.905" x2="-5.2832" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="1.905" x2="-5.0292" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.2832" y1="2.159" x2="-5.0292" y2="2.159" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="0.635" x2="-5.2832" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-5.1562" y1="0.635" x2="-5.0292" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-5.2832" y1="0.381" x2="-5.0292" y2="0.381" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="4.4196" x2="-1.9812" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-1.9812" y2="-4.7752" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-4.3688" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-0.7112" y2="-4.4196" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.3528" y2="-4.2672" width="0.1524" layer="47"/>
<wire x1="-3.0988" y1="-4.4196" x2="-3.3528" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-3.3528" y1="-4.2672" x2="-3.3528" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-1.7272" y2="-4.2672" width="0.1524" layer="47"/>
<wire x1="-1.9812" y1="-4.4196" x2="-1.7272" y2="-4.5212" width="0.1524" layer="47"/>
<wire x1="-1.7272" y1="-4.2672" x2="-1.7272" y2="-4.5212" width="0.1524" layer="47"/>
<text x="-16.3576" y="-7.5692" size="1.27" layer="47" ratio="6" rot="SR0">Default Padstyle: RX49p5Y20D0T</text>
<text x="-16.7386" y="-9.0932" size="1.27" layer="47" ratio="6" rot="SR0">Pin One Padstyle: RX49p5Y20D0T</text>
<text x="-14.8082" y="-13.6652" size="1.27" layer="47" ratio="6" rot="SR0">Alt 1 Padstyle: OX60Y90D30P</text>
<text x="-14.8082" y="-15.1892" size="1.27" layer="47" ratio="6" rot="SR0">Alt 2 Padstyle: OX90Y60D30P</text>
<text x="-4.0386" y="4.9276" size="0.635" layer="47" ratio="4" rot="SR0">0.157in/3.988mm</text>
<text x="-4.0386" y="6.8072" size="0.635" layer="47" ratio="4" rot="SR0">0.244in/6.198mm</text>
<text x="5.0292" y="-0.3048" size="0.635" layer="47" ratio="4" rot="SR0">0.197in/5.004mm</text>
<text x="-12.5984" y="0.9652" size="0.635" layer="47" ratio="4" rot="SR0">0.05in/1.27mm</text>
<text x="-6.0198" y="-5.5372" size="0.635" layer="47" ratio="4" rot="SR0">0.05in/1.27mm</text>
<wire x1="-2.1336" y1="-2.6416" x2="2.1336" y2="-2.6416" width="0.1524" layer="21"/>
<wire x1="2.1336" y1="2.6416" x2="-2.1336" y2="2.6416" width="0.1524" layer="21"/>
<text x="-3.4544" y="2.286" size="1.27" layer="21" ratio="6" rot="SR0">*</text>
<text x="-3.2766" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Name</text>
<text x="-1.7272" y="-0.635" size="1.27" layer="27" ratio="6" rot="SR0">&gt;Value</text>
</package>
</packages>
<symbols>
<symbol name="LM2662M">
<pin name="FC" x="2.54" y="0" length="middle" direction="pas"/>
<pin name="C1+" x="2.54" y="-2.54" length="middle" direction="pas"/>
<pin name="GND" x="2.54" y="-5.08" length="middle" direction="pas"/>
<pin name="C1-" x="2.54" y="-7.62" length="middle" direction="pas"/>
<pin name="OUT" x="53.34" y="-7.62" length="middle" direction="out" rot="R180"/>
<pin name="LV" x="53.34" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="OSC" x="53.34" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="V+" x="53.34" y="0" length="middle" direction="in" rot="R180"/>
<wire x1="7.62" y1="5.08" x2="7.62" y2="-12.7" width="0.1524" layer="94"/>
<wire x1="7.62" y1="-12.7" x2="48.26" y2="-12.7" width="0.1524" layer="94"/>
<wire x1="48.26" y1="-12.7" x2="48.26" y2="5.08" width="0.1524" layer="94"/>
<wire x1="48.26" y1="5.08" x2="7.62" y2="5.08" width="0.1524" layer="94"/>
<text x="23.2156" y="9.1186" size="2.0828" layer="95" ratio="6" rot="SR0">&gt;Name</text>
<text x="22.5806" y="6.5786" size="2.0828" layer="96" ratio="6" rot="SR0">&gt;Value</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="LM2662MX/NOPB" prefix="U">
<gates>
<gate name="A" symbol="LM2662M" x="0" y="0"/>
</gates>
<devices>
<device name="" package="M08A">
<connects>
<connect gate="A" pin="C1+" pad="2"/>
<connect gate="A" pin="C1-" pad="4"/>
<connect gate="A" pin="FC" pad="1"/>
<connect gate="A" pin="GND" pad="3"/>
<connect gate="A" pin="LV" pad="6"/>
<connect gate="A" pin="OSC" pad="7"/>
<connect gate="A" pin="OUT" pad="5"/>
<connect gate="A" pin="V+" pad="8"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2024 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="LM2662MX/NOPB" constant="no"/>
<attribute name="MFR_NAME" value="Texas Instruments" constant="no"/>
<attribute name="TYPE" value="LM2662M" constant="no"/>
</technology>
</technologies>
</device>
<device name="M08A-M" package="M08A-M">
<connects>
<connect gate="A" pin="C1+" pad="2"/>
<connect gate="A" pin="C1-" pad="4"/>
<connect gate="A" pin="FC" pad="1"/>
<connect gate="A" pin="GND" pad="3"/>
<connect gate="A" pin="LV" pad="6"/>
<connect gate="A" pin="OSC" pad="7"/>
<connect gate="A" pin="OUT" pad="5"/>
<connect gate="A" pin="V+" pad="8"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2024 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="LM2662MX/NOPB" constant="no"/>
<attribute name="MFR_NAME" value="Texas Instruments" constant="no"/>
<attribute name="TYPE" value="LM2662M" constant="no"/>
</technology>
</technologies>
</device>
<device name="M08A-L" package="M08A-L">
<connects>
<connect gate="A" pin="C1+" pad="2"/>
<connect gate="A" pin="C1-" pad="4"/>
<connect gate="A" pin="FC" pad="1"/>
<connect gate="A" pin="GND" pad="3"/>
<connect gate="A" pin="LV" pad="6"/>
<connect gate="A" pin="OSC" pad="7"/>
<connect gate="A" pin="OUT" pad="5"/>
<connect gate="A" pin="V+" pad="8"/>
</connects>
<technologies>
<technology name="">
<attribute name="COPYRIGHT" value="Copyright (C) 2024 Ultra Librarian. All rights reserved." constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="LM2662MX/NOPB" constant="no"/>
<attribute name="MFR_NAME" value="Texas Instruments" constant="no"/>
<attribute name="TYPE" value="LM2662M" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="T521W476M020ATE045">
<description>&lt;T521, Tantalum, Polymer Tantalum, Commercial Grade, 47 uF, 20%, 20 VDC, 105C, -55C, 105C, SMD, Polymer, Molded, Low Profile/ESR, NonCombustible, 2,000 Hrs, 9 % , 45 mOhms, 94 uA, 222.95 mg, 7343, 1.4mm, Height Max = 1.5mm, 1000, 52  Weeks&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by SamacSys&lt;/author&gt;</description>
<packages>
<package name="T521W">
<description>&lt;b&gt;T521W&lt;/b&gt;&lt;br&gt;
</description>
<smd name="1" x="-3.12" y="0" dx="2.43" dy="2.37" layer="1" rot="R90"/>
<smd name="2" x="3.12" y="0" dx="2.43" dy="2.37" layer="1" rot="R90"/>
<text x="0" y="0" size="1.27" layer="25" align="center">&gt;NAME</text>
<text x="0" y="0" size="1.27" layer="27" align="center">&gt;VALUE</text>
<wire x1="-3.65" y1="2.15" x2="3.65" y2="2.15" width="0.2" layer="51"/>
<wire x1="3.65" y1="2.15" x2="3.65" y2="-2.15" width="0.2" layer="51"/>
<wire x1="3.65" y1="-2.15" x2="-3.65" y2="-2.15" width="0.2" layer="51"/>
<wire x1="-3.65" y1="-2.15" x2="-3.65" y2="2.15" width="0.2" layer="51"/>
<wire x1="-3.65" y1="2.15" x2="3.65" y2="2.15" width="0.1" layer="21"/>
<wire x1="3.65" y1="-2.15" x2="-3.65" y2="-2.15" width="0.1" layer="21"/>
<circle x="-4.72" y="0" radius="0.05" width="0.2" layer="25"/>
<wire x1="-5.105" y1="3.15" x2="5.105" y2="3.15" width="0.05" layer="51"/>
<wire x1="5.105" y1="3.15" x2="5.105" y2="-3.15" width="0.05" layer="51"/>
<wire x1="5.105" y1="-3.15" x2="-5.105" y2="-3.15" width="0.05" layer="51"/>
<wire x1="-5.105" y1="-3.15" x2="-5.105" y2="3.15" width="0.05" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="T521W476M020ATE045">
<wire x1="5.08" y1="2.54" x2="5.08" y2="-2.54" width="0.254" layer="94"/>
<wire x1="5.842" y1="-2.54" x2="5.08" y2="-2.54" width="0.254" layer="94"/>
<wire x1="5.842" y1="-2.54" x2="5.842" y2="2.54" width="0.254" layer="94"/>
<wire x1="5.08" y1="2.54" x2="5.842" y2="2.54" width="0.254" layer="94"/>
<wire x1="4.572" y1="1.27" x2="3.556" y2="1.27" width="0.254" layer="94"/>
<wire x1="4.064" y1="1.778" x2="4.064" y2="0.762" width="0.254" layer="94"/>
<wire x1="2.54" y1="0" x2="5.08" y2="0" width="0.254" layer="94"/>
<wire x1="7.62" y1="0" x2="10.16" y2="0" width="0.254" layer="94"/>
<text x="8.89" y="6.35" size="1.778" layer="95" align="center-left">&gt;NAME</text>
<text x="8.89" y="3.81" size="1.778" layer="96" align="center-left">&gt;VALUE</text>
<pin name="+" x="0" y="0" visible="pad" length="short"/>
<pin name="-" x="12.7" y="0" visible="pad" length="short" rot="R180"/>
<polygon width="0.254" layer="94">
<vertex x="7.62" y="2.54"/>
<vertex x="7.62" y="-2.54"/>
<vertex x="6.858" y="-2.54"/>
<vertex x="6.858" y="2.54"/>
</polygon>
</symbol>
</symbols>
<devicesets>
<deviceset name="T521W476M020ATE045" prefix="C">
<description>&lt;b&gt;T521, Tantalum, Polymer Tantalum, Commercial Grade, 47 uF, 20%, 20 VDC, 105C, -55C, 105C, SMD, Polymer, Molded, Low Profile/ESR, NonCombustible, 2,000 Hrs, 9 % , 45 mOhms, 94 uA, 222.95 mg, 7343, 1.4mm, Height Max = 1.5mm, 1000, 52  Weeks&lt;/b&gt;&lt;p&gt;
Source: &lt;a href="https://content.kemet.com/datasheets/KEM_T2076_T52X-530.pdf"&gt; Datasheet &lt;/a&gt;</description>
<gates>
<gate name="G$1" symbol="T521W476M020ATE045" x="0" y="0"/>
</gates>
<devices>
<device name="" package="T521W">
<connects>
<connect gate="G$1" pin="+" pad="1"/>
<connect gate="G$1" pin="-" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="DESCRIPTION" value="T521, Tantalum, Polymer Tantalum, Commercial Grade, 47 uF, 20%, 20 VDC, 105C, -55C, 105C, SMD, Polymer, Molded, Low Profile/ESR, NonCombustible, 2,000 Hrs, 9 % , 45 mOhms, 94 uA, 222.95 mg, 7343, 1.4mm, Height Max = 1.5mm, 1000, 52  Weeks" constant="no"/>
<attribute name="HEIGHT" value="1.5mm" constant="no"/>
<attribute name="MANUFACTURER_NAME" value="KEMET" constant="no"/>
<attribute name="MANUFACTURER_PART_NUMBER" value="T521W476M020ATE045" constant="no"/>
<attribute name="MOUSER_PART_NUMBER" value="80-T521W476M20ATE045" constant="no"/>
<attribute name="MOUSER_PRICE-STOCK" value="https://www.mouser.co.uk/ProductDetail/KEMET/T521W476M020ATE045?qs=Ad%252Bh9aq9FyVtchBw1jwoFA%3D%3D" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-molex" urn="urn:adsk.eagle:library:165">
<description>&lt;b&gt;Molex Connectors&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="22-23-2021" urn="urn:adsk.eagle:footprint:8078259/1" library_version="5">
<description>&lt;b&gt;KK® 254 Solid Header, Vertical, with Friction Lock, 2 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/022232021_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<wire x1="-2.54" y1="3.175" x2="2.54" y2="3.175" width="0.254" layer="21"/>
<wire x1="2.54" y1="3.175" x2="2.54" y2="1.27" width="0.254" layer="21"/>
<wire x1="2.54" y1="1.27" x2="2.54" y2="-3.175" width="0.254" layer="21"/>
<wire x1="2.54" y1="-3.175" x2="-2.54" y2="-3.175" width="0.254" layer="21"/>
<wire x1="-2.54" y1="-3.175" x2="-2.54" y2="1.27" width="0.254" layer="21"/>
<wire x1="-2.54" y1="1.27" x2="-2.54" y2="3.175" width="0.254" layer="21"/>
<wire x1="-2.54" y1="1.27" x2="2.54" y2="1.27" width="0.254" layer="21"/>
<pad name="1" x="-1.27" y="0" drill="1" shape="long" rot="R90"/>
<pad name="2" x="1.27" y="0" drill="1" shape="long" rot="R90"/>
<text x="-2.54" y="3.81" size="1.016" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.54" y="-5.08" size="1.016" layer="27" ratio="10">&gt;VALUE</text>
</package>
</packages>
<packages3d>
<package3d name="22-23-2021" urn="urn:adsk.eagle:package:8078633/1" type="box" library_version="5">
<description>&lt;b&gt;KK® 254 Solid Header, Vertical, with Friction Lock, 2 Circuits, Tin (Sn) Plating&lt;/b&gt;&lt;p&gt;&lt;a href =http://www.molex.com/pdm_docs/sd/022232021_sd.pdf&gt;Datasheet &lt;/a&gt;</description>
<packageinstances>
<packageinstance name="22-23-2021"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="MV" urn="urn:adsk.eagle:symbol:6783/2" library_version="5">
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.6096" layer="94"/>
<text x="2.54" y="-0.762" size="1.524" layer="95">&gt;NAME</text>
<text x="-0.762" y="1.397" size="1.778" layer="96">&gt;VALUE</text>
<pin name="S" x="-2.54" y="0" visible="off" length="short" direction="pas"/>
</symbol>
<symbol name="M" urn="urn:adsk.eagle:symbol:6785/2" library_version="5">
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.6096" layer="94"/>
<text x="2.54" y="-0.762" size="1.524" layer="95">&gt;NAME</text>
<pin name="S" x="-2.54" y="0" visible="off" length="short" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="22-23-2021" urn="urn:adsk.eagle:component:8078938/3" prefix="X" library_version="5">
<description>.100" (2.54mm) Center Header - 2 Pin</description>
<gates>
<gate name="-1" symbol="MV" x="0" y="0" addlevel="always" swaplevel="1"/>
<gate name="-2" symbol="M" x="0" y="-2.54" addlevel="always" swaplevel="1"/>
</gates>
<devices>
<device name="" package="22-23-2021">
<connects>
<connect gate="-1" pin="S" pad="1"/>
<connect gate="-2" pin="S" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:8078633/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="MF" value="MOLEX" constant="no"/>
<attribute name="MPN" value="22-23-2021" constant="no"/>
<attribute name="OC_FARNELL" value="1462926" constant="no"/>
<attribute name="OC_NEWARK" value="25C3832" constant="no"/>
<attribute name="POPULARITY" value="40" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="frames" urn="urn:adsk.eagle:library:229">
<description>&lt;b&gt;Frames for Sheet and Layout&lt;/b&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="FRAME_D_L" urn="urn:adsk.eagle:symbol:13885/1" library_version="1">
<frame x1="-431.8" y1="0" x2="431.8" y2="558.8" columns="16" rows="11" layer="94" border-bottom="no"/>
</symbol>
<symbol name="DOCFIELD" urn="urn:adsk.eagle:symbol:13864/1" library_version="1">
<wire x1="0" y1="0" x2="71.12" y2="0" width="0.1016" layer="94"/>
<wire x1="101.6" y1="15.24" x2="87.63" y2="15.24" width="0.1016" layer="94"/>
<wire x1="0" y1="0" x2="0" y2="5.08" width="0.1016" layer="94"/>
<wire x1="0" y1="5.08" x2="71.12" y2="5.08" width="0.1016" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="15.24" width="0.1016" layer="94"/>
<wire x1="101.6" y1="15.24" x2="101.6" y2="5.08" width="0.1016" layer="94"/>
<wire x1="71.12" y1="5.08" x2="71.12" y2="0" width="0.1016" layer="94"/>
<wire x1="71.12" y1="5.08" x2="87.63" y2="5.08" width="0.1016" layer="94"/>
<wire x1="71.12" y1="0" x2="101.6" y2="0" width="0.1016" layer="94"/>
<wire x1="87.63" y1="15.24" x2="87.63" y2="5.08" width="0.1016" layer="94"/>
<wire x1="87.63" y1="15.24" x2="0" y2="15.24" width="0.1016" layer="94"/>
<wire x1="87.63" y1="5.08" x2="101.6" y2="5.08" width="0.1016" layer="94"/>
<wire x1="101.6" y1="5.08" x2="101.6" y2="0" width="0.1016" layer="94"/>
<wire x1="0" y1="15.24" x2="0" y2="22.86" width="0.1016" layer="94"/>
<wire x1="101.6" y1="35.56" x2="0" y2="35.56" width="0.1016" layer="94"/>
<wire x1="101.6" y1="35.56" x2="101.6" y2="22.86" width="0.1016" layer="94"/>
<wire x1="0" y1="22.86" x2="101.6" y2="22.86" width="0.1016" layer="94"/>
<wire x1="0" y1="22.86" x2="0" y2="35.56" width="0.1016" layer="94"/>
<wire x1="101.6" y1="22.86" x2="101.6" y2="15.24" width="0.1016" layer="94"/>
<text x="1.27" y="1.27" size="2.54" layer="94">Date:</text>
<text x="12.7" y="1.27" size="2.54" layer="94">&gt;LAST_DATE_TIME</text>
<text x="72.39" y="1.27" size="2.54" layer="94">Sheet:</text>
<text x="86.36" y="1.27" size="2.54" layer="94">&gt;SHEET</text>
<text x="88.9" y="11.43" size="2.54" layer="94">REV:</text>
<text x="1.27" y="19.05" size="2.54" layer="94">TITLE:</text>
<text x="1.27" y="11.43" size="2.54" layer="94">Document Number:</text>
<text x="17.78" y="19.05" size="2.54" layer="94">&gt;DRAWING_NAME</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="FRAME_D_L" urn="urn:adsk.eagle:component:13943/1" prefix="FRAME" uservalue="yes" library_version="1">
<description>&lt;b&gt;FRAME&lt;/b&gt; D Size , 22 x 34 INCH, Landscape&lt;p&gt;</description>
<gates>
<gate name="G$1" symbol="FRAME_D_L" x="0" y="0" addlevel="always"/>
<gate name="G$2" symbol="DOCFIELD" x="325.12" y="0" addlevel="always"/>
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
<library name="con-ptr500" urn="urn:adsk.eagle:library:181">
<description>&lt;b&gt;PTR Connectors&lt;/b&gt;&lt;p&gt;
Aug. 2004 / PTR Meßtechnik:&lt;br&gt;
Die Bezeichnung der Serie AK505 wurde geändert.&lt;br&gt;
Es handelt sich hierbei um AK500 in horizontaler Ausführung.&lt;p&gt;
&lt;TABLE BORDER=0 CELLSPACING=1 CELLPADDING=2&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;Alte Bezeichnung&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;Neue Bezeichnung&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;AK505/2,grau&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#0000FF"&gt;AK500/2-5.0-H-GRAU&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;AK505/2DS,grau&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#0000FF"&gt;AK500/2DS-5.0-H-GRAU&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;AKZ505/2,grau&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=LEFT&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#0000FF"&gt;AKZ500/2-5.08-H-GRAU&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
  &lt;/TABLE&gt;

&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="AK300/2" urn="urn:adsk.eagle:footprint:9843/1" library_version="3">
<description>&lt;b&gt;CONNECTOR&lt;/b&gt;</description>
<wire x1="5.08" y1="6.223" x2="5.08" y2="3.175" width="0.1524" layer="21"/>
<wire x1="5.08" y1="6.223" x2="-5.08" y2="6.223" width="0.1524" layer="21"/>
<wire x1="5.08" y1="6.223" x2="5.588" y2="6.223" width="0.1524" layer="21"/>
<wire x1="5.588" y1="6.223" x2="5.588" y2="1.397" width="0.1524" layer="21"/>
<wire x1="5.588" y1="1.397" x2="5.08" y2="1.651" width="0.1524" layer="21"/>
<wire x1="5.588" y1="-5.461" x2="5.08" y2="-5.207" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-5.207" x2="5.08" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="5.588" y1="-3.81" x2="5.08" y2="-4.064" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-4.064" x2="5.08" y2="-5.207" width="0.1524" layer="21"/>
<wire x1="5.588" y1="-3.81" x2="5.588" y2="-5.461" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="-6.223" x2="0.4572" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="4.5212" y1="0.254" x2="4.5212" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="-6.223" x2="4.5212" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="4.5212" y1="-6.223" x2="5.08" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="-6.223" x2="-0.4826" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="-6.223" x2="0.4572" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="-4.5466" y1="0.254" x2="-4.5466" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-6.223" x2="-4.5466" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="-4.5466" y1="-6.223" x2="-0.4826" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="-4.318" x2="4.5212" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="-4.318" x2="0.4572" y2="0.254" width="0.1524" layer="21"/>
<wire x1="4.5212" y1="-4.318" x2="4.5212" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="-4.318" x2="-4.5466" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="-4.318" x2="-0.4826" y2="0.254" width="0.1524" layer="21"/>
<wire x1="-4.5466" y1="-4.318" x2="-4.5466" y2="-6.223" width="0.1524" layer="21"/>
<wire x1="4.1402" y1="-3.683" x2="4.1402" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="4.1402" y1="-3.683" x2="0.8382" y2="-3.683" width="0.1524" layer="21"/>
<wire x1="0.8382" y1="-3.683" x2="0.8382" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="-0.8636" y1="-3.683" x2="-0.8636" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="-0.8636" y1="-3.683" x2="-4.1656" y2="-3.683" width="0.1524" layer="21"/>
<wire x1="-4.1656" y1="-3.683" x2="-4.1656" y2="-0.508" width="0.1524" layer="21"/>
<wire x1="-4.1656" y1="-0.508" x2="-3.7846" y2="-0.508" width="0.1524" layer="51"/>
<wire x1="-0.8636" y1="-0.508" x2="-1.2446" y2="-0.508" width="0.1524" layer="51"/>
<wire x1="0.8382" y1="-0.508" x2="1.2192" y2="-0.508" width="0.1524" layer="51"/>
<wire x1="4.1402" y1="-0.508" x2="3.7592" y2="-0.508" width="0.1524" layer="51"/>
<wire x1="-5.08" y1="-6.223" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-5.08" y2="3.175" width="0.1524" layer="21"/>
<wire x1="5.08" y1="1.651" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="5.08" y2="-4.064" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="3.175" x2="5.08" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="3.175" x2="-5.08" y2="6.223" width="0.1524" layer="21"/>
<wire x1="5.08" y1="3.175" x2="5.08" y2="1.651" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="3.429" x2="0.4572" y2="5.969" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="5.969" x2="4.5212" y2="5.969" width="0.1524" layer="21"/>
<wire x1="4.5212" y1="5.969" x2="4.5212" y2="3.429" width="0.1524" layer="21"/>
<wire x1="4.5212" y1="3.429" x2="0.4572" y2="3.429" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="3.429" x2="-0.4826" y2="5.969" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="3.429" x2="-4.5466" y2="3.429" width="0.1524" layer="21"/>
<wire x1="-4.5466" y1="3.429" x2="-4.5466" y2="5.969" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="5.969" x2="-4.5466" y2="5.969" width="0.1524" layer="21"/>
<wire x1="3.9574" y1="4.0849" x2="4.0131" y2="5.0545" width="0.1524" layer="21" curve="90.564135"/>
<wire x1="1.016" y1="4.1656" x2="4.0038" y2="4.1189" width="0.1524" layer="21" curve="75.530157"/>
<wire x1="0.8636" y1="5.0038" x2="4.0178" y2="5.0586" width="0.1524" layer="21" curve="-100.0232"/>
<wire x1="0.9144" y1="5.0546" x2="1.0581" y2="4.1297" width="0.1524" layer="21" curve="104.208873"/>
<wire x1="0.8636" y1="4.445" x2="3.9116" y2="5.08" width="0.1524" layer="21"/>
<wire x1="0.9906" y1="4.318" x2="4.0386" y2="4.953" width="0.1524" layer="21"/>
<wire x1="-1.0464" y1="4.0849" x2="-0.9907" y2="5.0545" width="0.1524" layer="21" curve="90.564135"/>
<wire x1="-3.9878" y1="4.1656" x2="-1" y2="4.1188" width="0.1524" layer="21" curve="75.528719"/>
<wire x1="-4.1402" y1="5.0038" x2="-0.9858" y2="5.0588" width="0.1524" layer="21" curve="-100.022513"/>
<wire x1="-4.0894" y1="5.0546" x2="-3.9457" y2="4.1297" width="0.1524" layer="21" curve="104.208873"/>
<wire x1="-4.1402" y1="4.445" x2="-1.0922" y2="5.08" width="0.1524" layer="21"/>
<wire x1="-4.0132" y1="4.318" x2="-0.9652" y2="4.953" width="0.1524" layer="21"/>
<wire x1="-4.5466" y1="0.254" x2="-4.1656" y2="0.254" width="0.1524" layer="21"/>
<wire x1="-0.4826" y1="0.254" x2="-0.8636" y2="0.254" width="0.1524" layer="21"/>
<wire x1="-0.8636" y1="0.254" x2="-4.1656" y2="0.254" width="0.1524" layer="51"/>
<wire x1="-5.08" y1="0.635" x2="-4.1656" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-4.1656" y1="0.635" x2="-0.8636" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.8636" y1="0.635" x2="0.8382" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="4.1402" y2="0.635" width="0.1524" layer="21"/>
<wire x1="4.1402" y1="0.635" x2="0.8382" y2="0.635" width="0.1524" layer="51"/>
<wire x1="4.5212" y1="0.254" x2="4.1402" y2="0.254" width="0.1524" layer="21"/>
<wire x1="0.4572" y1="0.254" x2="0.8382" y2="0.254" width="0.1524" layer="21"/>
<wire x1="0.8382" y1="0.254" x2="4.1402" y2="0.254" width="0.1524" layer="51"/>
<pad name="1" x="-2.5146" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="2" x="2.4892" y="0" drill="1.3208" shape="long" rot="R90"/>
<text x="-5.08" y="6.731" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-8.636" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
<text x="-4.4958" y="1.27" size="1.27" layer="21" ratio="10">1</text>
<text x="0.5842" y="1.27" size="1.27" layer="21" ratio="10">2</text>
<rectangle x1="-3.7846" y1="-2.54" x2="-1.2446" y2="0.254" layer="51"/>
<rectangle x1="1.2192" y1="-2.54" x2="3.7592" y2="0.254" layer="51"/>
</package>
</packages>
<packages3d>
<package3d name="AK300/2" urn="urn:adsk.eagle:package:9881/1" type="box" library_version="3">
<description>CONNECTOR</description>
<packageinstances>
<packageinstance name="AK300/2"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="KL" urn="urn:adsk.eagle:symbol:9788/2" library_version="3">
<circle x="1.27" y="0" radius="1.27" width="0.254" layer="94"/>
<text x="-1.27" y="0.889" size="1.778" layer="95" rot="R180">&gt;NAME</text>
<pin name="KL" x="5.08" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
<symbol name="KLV" urn="urn:adsk.eagle:symbol:9842/1" library_version="3">
<circle x="1.27" y="0" radius="1.27" width="0.254" layer="94"/>
<text x="-1.27" y="0.889" size="1.778" layer="95" rot="R180">&gt;NAME</text>
<text x="-3.81" y="-3.683" size="1.778" layer="96">&gt;VALUE</text>
<pin name="KL" x="5.08" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="AK300/2" urn="urn:adsk.eagle:component:9912/3" prefix="X" uservalue="yes" library_version="3">
<description>&lt;b&gt;CONNECTOR&lt;/b&gt;</description>
<gates>
<gate name="-1" symbol="KL" x="0" y="5.08" addlevel="always"/>
<gate name="-2" symbol="KLV" x="0" y="0" addlevel="always"/>
</gates>
<devices>
<device name="" package="AK300/2">
<connects>
<connect gate="-1" pin="KL" pad="1"/>
<connect gate="-2" pin="KL" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:9881/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
<attribute name="POPULARITY" value="16" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-lstb" urn="urn:adsk.eagle:library:162">
<description>&lt;b&gt;Pin Headers&lt;/b&gt;&lt;p&gt;
Naming:&lt;p&gt;
MA = male&lt;p&gt;
# contacts - # rows&lt;p&gt;
W = angled&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="MA10-2" urn="urn:adsk.eagle:footprint:8273/1" library_version="2">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-12.065" y1="2.54" x2="-10.795" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="2.54" x2="-10.16" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="1.905" x2="-9.525" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="2.54" x2="-8.255" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="2.54" x2="-7.62" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="2.54" x2="-12.7" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="1.905" x2="-6.985" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="2.54" x2="-5.715" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="2.54" x2="-5.08" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="2.54" x2="-3.175" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="2.54" x2="-2.54" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="1.905" x2="-1.905" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="2.54" x2="-0.635" y2="2.54" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="2.54" x2="0" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="2.54" x2="-5.08" y2="1.905" width="0.1524" layer="21"/>
<wire x1="0" y1="1.905" x2="0.635" y2="2.54" width="0.1524" layer="21"/>
<wire x1="0.635" y1="2.54" x2="1.905" y2="2.54" width="0.1524" layer="21"/>
<wire x1="1.905" y1="2.54" x2="2.54" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-1.905" x2="-10.795" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-1.905" x2="-8.255" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="-2.54" x2="-9.525" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="-2.54" x2="-10.16" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="1.905" x2="-12.7" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-1.905" x2="-12.065" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="-2.54" x2="-12.065" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-5.715" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-2.54" x2="-6.985" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="-2.54" x2="-7.62" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-1.905" x2="-3.175" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="0" y1="-1.905" x2="-0.635" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-2.54" x2="-1.905" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-2.54" x2="-2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-4.445" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-2.54" x2="-4.445" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="1.905" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-2.54" x2="0.635" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-2.54" x2="0" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="3.175" y1="2.54" x2="4.445" y2="2.54" width="0.1524" layer="21"/>
<wire x1="4.445" y1="2.54" x2="5.08" y2="1.905" width="0.1524" layer="21"/>
<wire x1="5.08" y1="1.905" x2="5.715" y2="2.54" width="0.1524" layer="21"/>
<wire x1="12.065" y1="2.54" x2="12.7" y2="1.905" width="0.1524" layer="21"/>
<wire x1="3.175" y1="2.54" x2="2.54" y2="1.905" width="0.1524" layer="21"/>
<wire x1="12.7" y1="1.905" x2="12.7" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-1.905" x2="4.445" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-1.905" x2="12.065" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-2.54" x2="5.08" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="3.175" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-2.54" x2="3.175" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-2.54" x2="6.985" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-1.905" x2="6.985" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-1.905" x2="8.255" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-2.54" x2="9.525" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-1.905" x2="9.525" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-1.905" x2="10.795" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="10.795" y1="-2.54" x2="12.065" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="5.715" y1="2.54" x2="6.985" y2="2.54" width="0.1524" layer="21"/>
<wire x1="7.62" y1="1.905" x2="6.985" y2="2.54" width="0.1524" layer="21"/>
<wire x1="7.62" y1="1.905" x2="8.255" y2="2.54" width="0.1524" layer="21"/>
<wire x1="8.255" y1="2.54" x2="9.525" y2="2.54" width="0.1524" layer="21"/>
<wire x1="10.16" y1="1.905" x2="9.525" y2="2.54" width="0.1524" layer="21"/>
<wire x1="10.16" y1="1.905" x2="10.795" y2="2.54" width="0.1524" layer="21"/>
<wire x1="10.795" y1="2.54" x2="12.065" y2="2.54" width="0.1524" layer="21"/>
<pad name="1" x="-11.43" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="3" x="-8.89" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="5" x="-6.35" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="7" x="-3.81" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="9" x="-1.27" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="11" x="1.27" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="2" x="-11.43" y="1.27" drill="1.016" shape="octagon"/>
<pad name="4" x="-8.89" y="1.27" drill="1.016" shape="octagon"/>
<pad name="6" x="-6.35" y="1.27" drill="1.016" shape="octagon"/>
<pad name="8" x="-3.81" y="1.27" drill="1.016" shape="octagon"/>
<pad name="10" x="-1.27" y="1.27" drill="1.016" shape="octagon"/>
<pad name="12" x="1.27" y="1.27" drill="1.016" shape="octagon"/>
<pad name="13" x="3.81" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="15" x="6.35" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="14" x="3.81" y="1.27" drill="1.016" shape="octagon"/>
<pad name="16" x="6.35" y="1.27" drill="1.016" shape="octagon"/>
<pad name="17" x="8.89" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="18" x="8.89" y="1.27" drill="1.016" shape="octagon"/>
<pad name="19" x="11.43" y="-1.27" drill="1.016" shape="octagon"/>
<pad name="20" x="11.43" y="1.27" drill="1.016" shape="octagon"/>
<text x="-11.938" y="-4.191" size="1.27" layer="21" ratio="10">1</text>
<text x="-12.7" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="2.54" y="-4.191" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="10.16" y="2.921" size="1.27" layer="21" ratio="10">20</text>
<rectangle x1="-9.144" y1="-1.524" x2="-8.636" y2="-1.016" layer="51"/>
<rectangle x1="-11.684" y1="-1.524" x2="-11.176" y2="-1.016" layer="51"/>
<rectangle x1="-6.604" y1="-1.524" x2="-6.096" y2="-1.016" layer="51"/>
<rectangle x1="-1.524" y1="-1.524" x2="-1.016" y2="-1.016" layer="51"/>
<rectangle x1="-4.064" y1="-1.524" x2="-3.556" y2="-1.016" layer="51"/>
<rectangle x1="1.016" y1="-1.524" x2="1.524" y2="-1.016" layer="51"/>
<rectangle x1="-11.684" y1="1.016" x2="-11.176" y2="1.524" layer="51"/>
<rectangle x1="-9.144" y1="1.016" x2="-8.636" y2="1.524" layer="51"/>
<rectangle x1="-6.604" y1="1.016" x2="-6.096" y2="1.524" layer="51"/>
<rectangle x1="-4.064" y1="1.016" x2="-3.556" y2="1.524" layer="51"/>
<rectangle x1="-1.524" y1="1.016" x2="-1.016" y2="1.524" layer="51"/>
<rectangle x1="1.016" y1="1.016" x2="1.524" y2="1.524" layer="51"/>
<rectangle x1="6.096" y1="-1.524" x2="6.604" y2="-1.016" layer="51"/>
<rectangle x1="3.556" y1="-1.524" x2="4.064" y2="-1.016" layer="51"/>
<rectangle x1="3.556" y1="1.016" x2="4.064" y2="1.524" layer="51"/>
<rectangle x1="6.096" y1="1.016" x2="6.604" y2="1.524" layer="51"/>
<rectangle x1="8.636" y1="1.016" x2="9.144" y2="1.524" layer="51"/>
<rectangle x1="11.176" y1="1.016" x2="11.684" y2="1.524" layer="51"/>
<rectangle x1="8.636" y1="-1.524" x2="9.144" y2="-1.016" layer="51"/>
<rectangle x1="11.176" y1="-1.524" x2="11.684" y2="-1.016" layer="51"/>
</package>
</packages>
<packages3d>
<package3d name="MA10-2" urn="urn:adsk.eagle:package:8331/1" type="box" library_version="2">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="MA10-2"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="MA10-2" urn="urn:adsk.eagle:symbol:8270/1" library_version="2">
<wire x1="3.81" y1="-12.7" x2="-3.81" y2="-12.7" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="2.54" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-7.62" x2="2.54" y2="-7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-10.16" x2="2.54" y2="-10.16" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-5.08" x2="-1.27" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-7.62" x2="-1.27" y2="-7.62" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-10.16" x2="-1.27" y2="-10.16" width="0.6096" layer="94"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="2.54" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="0" x2="-1.27" y2="0" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-2.54" x2="-1.27" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="7.62" x2="2.54" y2="7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="5.08" x2="2.54" y2="5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="2.54" x2="2.54" y2="2.54" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="7.62" x2="-1.27" y2="7.62" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="-1.27" y2="5.08" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="2.54" x2="-1.27" y2="2.54" width="0.6096" layer="94"/>
<wire x1="-3.81" y1="15.24" x2="-3.81" y2="-12.7" width="0.4064" layer="94"/>
<wire x1="3.81" y1="-12.7" x2="3.81" y2="15.24" width="0.4064" layer="94"/>
<wire x1="-3.81" y1="15.24" x2="3.81" y2="15.24" width="0.4064" layer="94"/>
<wire x1="1.27" y1="12.7" x2="2.54" y2="12.7" width="0.6096" layer="94"/>
<wire x1="1.27" y1="10.16" x2="2.54" y2="10.16" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="12.7" x2="-1.27" y2="12.7" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="10.16" x2="-1.27" y2="10.16" width="0.6096" layer="94"/>
<text x="-3.81" y="-15.24" size="1.778" layer="96">&gt;VALUE</text>
<text x="-3.81" y="16.002" size="1.778" layer="95">&gt;NAME</text>
<pin name="1" x="7.62" y="-10.16" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="3" x="7.62" y="-7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="5" x="7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="2" x="-7.62" y="-10.16" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="4" x="-7.62" y="-7.62" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="6" x="-7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="7" x="7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="9" x="7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="8" x="-7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="10" x="-7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="11" x="7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="13" x="7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="15" x="7.62" y="7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="12" x="-7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="14" x="-7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="16" x="-7.62" y="7.62" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="17" x="7.62" y="10.16" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="19" x="7.62" y="12.7" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="18" x="-7.62" y="10.16" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="20" x="-7.62" y="12.7" visible="pad" length="middle" direction="pas" swaplevel="1"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="MA10-2" urn="urn:adsk.eagle:component:8371/2" prefix="SV" uservalue="yes" library_version="2">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="MA10-2" x="0" y="0"/>
</gates>
<devices>
<device name="" package="MA10-2">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="10" pad="10"/>
<connect gate="G$1" pin="11" pad="11"/>
<connect gate="G$1" pin="12" pad="12"/>
<connect gate="G$1" pin="13" pad="13"/>
<connect gate="G$1" pin="14" pad="14"/>
<connect gate="G$1" pin="15" pad="15"/>
<connect gate="G$1" pin="16" pad="16"/>
<connect gate="G$1" pin="17" pad="17"/>
<connect gate="G$1" pin="18" pad="18"/>
<connect gate="G$1" pin="19" pad="19"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="20" pad="20"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
<connect gate="G$1" pin="7" pad="7"/>
<connect gate="G$1" pin="8" pad="8"/>
<connect gate="G$1" pin="9" pad="9"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:8331/1"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
<attribute name="POPULARITY" value="3" constant="no"/>
</technology>
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
<part name="U1" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$1" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="2.2µH"/>
<part name="GND1" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C1" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R1" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="3.09k"/>
<part name="R2" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND2" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C2" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C3" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND3" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND4" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C4" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C5" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND5" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND6" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U2" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$2" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="2.2µH"/>
<part name="GND7" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C6" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R3" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="13.7k"/>
<part name="R4" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND8" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C7" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C8" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND9" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND10" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C9" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C10" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND11" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND12" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C11" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND13" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U3" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$3" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND14" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C12" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R5" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="32.2k"/>
<part name="R6" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND15" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C13" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C14" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND16" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND17" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C15" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C16" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND18" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND19" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C17" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND20" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U4" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$4" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND21" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C18" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R7" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="32.2k"/>
<part name="R8" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND22" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C19" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C20" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND23" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND24" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C21" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C22" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND25" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND26" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C23" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND27" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U6" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$6" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND35" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C30" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R11" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="32.2k"/>
<part name="R12" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND36" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C31" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C32" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND37" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND38" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C33" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C34" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND39" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND40" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C35" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND41" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U7" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$7" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND42" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C36" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R13" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="32.2k"/>
<part name="R14" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND43" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C37" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C38" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND44" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND45" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C39" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C40" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND46" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND47" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C41" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND48" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U8" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$8" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND49" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C42" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R15" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="32.2k"/>
<part name="R16" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND50" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C43" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C44" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND51" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND52" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C45" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C46" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND53" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND54" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C47" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND55" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U10" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$10" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND63" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C54" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R19" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="32.2k"/>
<part name="R20" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND64" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C55" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C56" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND65" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND66" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C57" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C58" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND67" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND68" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C59" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND69" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U11" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$11" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND70" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C60" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R21" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="34.8k"/>
<part name="R22" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND71" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C61" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C62" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND72" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND73" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C63" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C64" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND74" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND75" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C65" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND76" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U12" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$12" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND77" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C66" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R23" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R24" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND78" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C67" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C68" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND79" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND80" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C69" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C70" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND81" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND82" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U13" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$13" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND83" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C71" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R25" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R26" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND84" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C72" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C73" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND85" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND86" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C74" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C75" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND87" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND88" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U14" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$14" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND90" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C77" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R27" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R28" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND91" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C78" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C79" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND92" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND93" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C80" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C81" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND94" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND95" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U15" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$15" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND97" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C83" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R29" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R30" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND98" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C84" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C85" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND99" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND100" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C86" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C87" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND101" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND102" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U16" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$16" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND104" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C89" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R31" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R32" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND105" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C90" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C91" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND106" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND107" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C92" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C93" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND108" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND109" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U17" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$17" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND89" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C76" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R33" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="61.9k"/>
<part name="R34" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND96" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C82" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C88" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND103" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND110" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C94" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C95" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND111" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND112" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U18" library="My_Library" deviceset="LM2662MX/NOPB" device=""/>
<part name="C96" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="C97" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="GND113" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND114" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND115" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U19" library="My_Library" deviceset="LM2662MX/NOPB" device=""/>
<part name="C98" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="C99" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="GND116" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND117" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND118" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U20" library="My_Library" deviceset="LM2662MX/NOPB" device=""/>
<part name="C100" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="C101" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="GND119" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND120" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND121" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U21" library="My_Library" deviceset="LM2662MX/NOPB" device=""/>
<part name="C102" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="C103" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="GND122" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND123" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND124" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U22" library="My_Library" deviceset="LM2662MX/NOPB" device=""/>
<part name="C104" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="C105" library="T521W476M020ATE045" deviceset="T521W476M020ATE045" device=""/>
<part name="GND125" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND126" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND127" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X16" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND129" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X18" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND131" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X19" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND132" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X20" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND133" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X21" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND134" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X22" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND135" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X23" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND136" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X24" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND137" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="FRAME1" library="frames" library_urn="urn:adsk.eagle:library:229" deviceset="FRAME_D_L" device=""/>
<part name="X1" library="con-ptr500" library_urn="urn:adsk.eagle:library:181" deviceset="AK300/2" device="" package3d_urn="urn:adsk.eagle:package:9881/1"/>
<part name="GND150" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="SV1" library="con-lstb" library_urn="urn:adsk.eagle:library:162" deviceset="MA10-2" device="" package3d_urn="urn:adsk.eagle:package:8331/1"/>
<part name="GND167" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X27" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND169" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U5" library="My_Library_RADAR" deviceset="ADM7151ACPZ-04-R7" device=""/>
<part name="C24" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND28" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C25" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND29" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C26" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND30" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND31" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="R9" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="12k"/>
<part name="R10" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND32" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C27" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND33" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C28" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND34" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND56" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U9" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$5" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND57" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C29" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R17" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R18" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND58" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C48" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C49" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND59" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND60" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C50" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C51" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND61" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND62" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X2" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND130" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U23" library="My_Library_RADAR" deviceset="ADM7151ACPZ-04-R7" device=""/>
<part name="C52" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND143" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C53" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND151" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C106" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND152" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND153" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="R35" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="12k"/>
<part name="R36" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND154" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C107" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND155" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C108" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND156" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND157" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U24" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$9" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND158" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C109" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R37" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R38" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND159" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C110" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C111" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND160" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND161" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C112" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C113" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND162" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND163" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X9" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND164" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U25" library="My_Library_RADAR" deviceset="ADM7151ACPZ-04-R7" device=""/>
<part name="C114" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND165" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C115" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND166" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C116" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND168" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND170" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="R39" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="2k"/>
<part name="R40" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND171" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C117" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND172" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C118" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND173" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND174" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U26" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$18" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND175" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C119" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R41" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R42" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND176" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C120" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C121" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND177" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND178" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C122" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C123" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND179" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND180" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X17" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND181" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U27" library="My_Library_RADAR" deviceset="ADM7151ACPZ-04-R7" device=""/>
<part name="C124" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND182" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C125" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND183" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C126" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND184" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND185" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="R43" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="12k"/>
<part name="R44" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND186" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C127" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND187" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C128" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND188" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND189" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U28" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$19" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND190" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C129" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R45" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R46" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND191" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C130" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C131" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND192" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND193" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C132" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C133" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND194" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND195" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X25" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND196" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U29" library="My_Library_RADAR" deviceset="ADM7151ACPZ-04-R7" device=""/>
<part name="C134" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND197" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C135" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND198" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C136" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND199" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND200" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="R47" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="12k"/>
<part name="R48" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND201" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C137" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND202" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C138" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND203" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND204" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U30" library="My_Library_RADAR" deviceset="ADM7151ACPZ-04-R7" device=""/>
<part name="C139" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND205" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C140" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND206" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C141" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND207" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND208" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="R49" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="23.4k"/>
<part name="R50" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND209" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C142" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="1µF"/>
<part name="GND210" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C143" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND211" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND212" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U31" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$20" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND213" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C144" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R51" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R52" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND214" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C145" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C146" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND215" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND216" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C147" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C148" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND217" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND218" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X26" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND219" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U32" library="My_Library_RADAR" deviceset="TPS7A8300RGRR" device=""/>
<part name="GND220" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND221" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND222" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C149" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND223" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C150" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10nF"/>
<part name="R53" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="35.7k"/>
<part name="R54" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="11.5k"/>
<part name="GND224" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C151" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10µF"/>
<part name="GND225" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C152" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10nF"/>
<part name="GND226" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C153" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10µF"/>
<part name="GND227" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U33" library="My_Library_RADAR" deviceset="TPS562208DDCT" device=""/>
<part name="U$21" library="My_Library_RADAR" deviceset="POWER_INDUCTOR" device="" value="3.3µH"/>
<part name="GND228" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C154" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="0.1µF"/>
<part name="R55" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="56.2k"/>
<part name="R56" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="10k"/>
<part name="GND229" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C155" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="C156" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND230" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND231" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C157" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="C158" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0805" package3d_urn="urn:adsk.eagle:package:23617/2" value="10µF"/>
<part name="GND232" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND233" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X28" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND234" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="U34" library="My_Library_RADAR" deviceset="TPS7A8300RGRR" device=""/>
<part name="GND235" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND236" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="GND237" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C159" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="22µF"/>
<part name="GND238" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C160" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10nF"/>
<part name="R57" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="35.7k"/>
<part name="R58" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="R-EU_" device="M0805" package3d_urn="urn:adsk.eagle:package:23556/2" value="11.5k"/>
<part name="GND239" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C161" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10µF"/>
<part name="GND240" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C162" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10nF"/>
<part name="GND241" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="C163" library="rcl" library_urn="urn:adsk.eagle:library:334" deviceset="C-EU" device="C0603" package3d_urn="urn:adsk.eagle:package:23616/2" value="10µF"/>
<part name="GND242" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X4" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND138" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X5" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND139" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X6" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND140" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X7" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND141" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X8" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND142" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X10" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND144" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X11" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND145" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X12" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND146" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X3" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND128" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X13" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND147" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X14" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND148" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X15" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND149" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X29" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND243" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X30" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND244" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X31" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND245" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X32" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND246" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X33" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND247" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X34" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND248" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
<part name="X35" library="con-molex" library_urn="urn:adsk.eagle:library:165" deviceset="22-23-2021" device="" package3d_urn="urn:adsk.eagle:package:8078633/1"/>
<part name="GND249" library="supply1" library_urn="urn:adsk.eagle:library:371" deviceset="GND" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U1" gate="A" x="78.74" y="472.44" smashed="yes">
<attribute name="NAME" x="74.0156" y="473.9386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="468.8586" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$1" gate="A" x="111.76" y="482.6" smashed="yes">
<attribute name="NAME" x="110.8456" y="485.9528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="485.9528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND1" gate="1" x="96.52" y="457.2" smashed="yes">
<attribute name="VALUE" x="93.98" y="454.66" size="1.778" layer="96"/>
</instance>
<instance part="C1" gate="G$1" x="101.6" y="474.98" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="476.504" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="476.504" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R1" gate="G$1" x="129.54" y="477.52" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="473.71" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="473.71" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R2" gate="G$1" x="129.54" y="464.82" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="461.01" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="461.01" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND2" gate="1" x="129.54" y="457.2" smashed="yes">
<attribute name="VALUE" x="127" y="454.66" size="1.778" layer="96"/>
</instance>
<instance part="C2" gate="G$1" x="139.7" y="480.06" smashed="yes">
<attribute name="NAME" x="141.224" y="480.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="475.361" size="1.778" layer="96"/>
</instance>
<instance part="C3" gate="G$1" x="147.32" y="480.06" smashed="yes">
<attribute name="NAME" x="148.844" y="480.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="475.361" size="1.778" layer="96"/>
</instance>
<instance part="GND3" gate="1" x="139.7" y="472.44" smashed="yes">
<attribute name="VALUE" x="137.16" y="469.9" size="1.778" layer="96"/>
</instance>
<instance part="GND4" gate="1" x="147.32" y="472.44" smashed="yes">
<attribute name="VALUE" x="144.78" y="469.9" size="1.778" layer="96"/>
</instance>
<instance part="C4" gate="G$1" x="43.18" y="480.06" smashed="yes">
<attribute name="NAME" x="44.704" y="480.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="475.361" size="1.778" layer="96"/>
</instance>
<instance part="C5" gate="G$1" x="33.02" y="480.06" smashed="yes">
<attribute name="NAME" x="34.544" y="480.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="475.361" size="1.778" layer="96"/>
</instance>
<instance part="GND5" gate="1" x="33.02" y="472.44" smashed="yes">
<attribute name="VALUE" x="30.48" y="469.9" size="1.778" layer="96"/>
</instance>
<instance part="GND6" gate="1" x="43.18" y="472.44" smashed="yes">
<attribute name="VALUE" x="40.64" y="469.9" size="1.778" layer="96"/>
</instance>
<instance part="U2" gate="A" x="78.74" y="429.26" smashed="yes">
<attribute name="NAME" x="74.0156" y="430.7586" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="425.6786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$2" gate="A" x="111.76" y="439.42" smashed="yes">
<attribute name="NAME" x="110.8456" y="442.7728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="442.7728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND7" gate="1" x="96.52" y="414.02" smashed="yes">
<attribute name="VALUE" x="93.98" y="411.48" size="1.778" layer="96"/>
</instance>
<instance part="C6" gate="G$1" x="101.6" y="431.8" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="433.324" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="433.324" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R3" gate="G$1" x="129.54" y="434.34" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="430.53" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="430.53" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R4" gate="G$1" x="129.54" y="421.64" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="417.83" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="417.83" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND8" gate="1" x="129.54" y="414.02" smashed="yes">
<attribute name="VALUE" x="127" y="411.48" size="1.778" layer="96"/>
</instance>
<instance part="C7" gate="G$1" x="139.7" y="436.88" smashed="yes">
<attribute name="NAME" x="141.224" y="437.261" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="432.181" size="1.778" layer="96"/>
</instance>
<instance part="C8" gate="G$1" x="147.32" y="436.88" smashed="yes">
<attribute name="NAME" x="148.844" y="437.261" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="432.181" size="1.778" layer="96"/>
</instance>
<instance part="GND9" gate="1" x="139.7" y="429.26" smashed="yes">
<attribute name="VALUE" x="137.16" y="426.72" size="1.778" layer="96"/>
</instance>
<instance part="GND10" gate="1" x="147.32" y="429.26" smashed="yes">
<attribute name="VALUE" x="144.78" y="426.72" size="1.778" layer="96"/>
</instance>
<instance part="C9" gate="G$1" x="43.18" y="436.88" smashed="yes">
<attribute name="NAME" x="44.704" y="437.261" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="432.181" size="1.778" layer="96"/>
</instance>
<instance part="C10" gate="G$1" x="33.02" y="436.88" smashed="yes">
<attribute name="NAME" x="34.544" y="437.261" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="432.181" size="1.778" layer="96"/>
</instance>
<instance part="GND11" gate="1" x="33.02" y="429.26" smashed="yes">
<attribute name="VALUE" x="30.48" y="426.72" size="1.778" layer="96"/>
</instance>
<instance part="GND12" gate="1" x="43.18" y="429.26" smashed="yes">
<attribute name="VALUE" x="40.64" y="426.72" size="1.778" layer="96"/>
</instance>
<instance part="C11" gate="G$1" x="154.94" y="436.88" smashed="yes">
<attribute name="NAME" x="156.464" y="437.261" size="1.778" layer="95"/>
<attribute name="VALUE" x="156.464" y="432.181" size="1.778" layer="96"/>
</instance>
<instance part="GND13" gate="1" x="154.94" y="429.26" smashed="yes">
<attribute name="VALUE" x="152.4" y="426.72" size="1.778" layer="96"/>
</instance>
<instance part="U3" gate="A" x="78.74" y="515.62" smashed="yes">
<attribute name="NAME" x="74.0156" y="517.1186" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="512.0386" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$3" gate="A" x="111.76" y="525.78" smashed="yes">
<attribute name="NAME" x="110.8456" y="529.1328" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="529.1328" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND14" gate="1" x="96.52" y="500.38" smashed="yes">
<attribute name="VALUE" x="93.98" y="497.84" size="1.778" layer="96"/>
</instance>
<instance part="C12" gate="G$1" x="101.6" y="518.16" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="519.684" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="519.684" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R5" gate="G$1" x="129.54" y="520.7" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="516.89" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="516.89" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R6" gate="G$1" x="129.54" y="508" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="504.19" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="504.19" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND15" gate="1" x="129.54" y="500.38" smashed="yes">
<attribute name="VALUE" x="127" y="497.84" size="1.778" layer="96"/>
</instance>
<instance part="C13" gate="G$1" x="139.7" y="523.24" smashed="yes">
<attribute name="NAME" x="141.224" y="523.621" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="518.541" size="1.778" layer="96"/>
</instance>
<instance part="C14" gate="G$1" x="147.32" y="523.24" smashed="yes">
<attribute name="NAME" x="148.844" y="523.621" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="518.541" size="1.778" layer="96"/>
</instance>
<instance part="GND16" gate="1" x="139.7" y="515.62" smashed="yes">
<attribute name="VALUE" x="137.16" y="513.08" size="1.778" layer="96"/>
</instance>
<instance part="GND17" gate="1" x="147.32" y="515.62" smashed="yes">
<attribute name="VALUE" x="144.78" y="513.08" size="1.778" layer="96"/>
</instance>
<instance part="C15" gate="G$1" x="43.18" y="523.24" smashed="yes">
<attribute name="NAME" x="44.704" y="523.621" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="518.541" size="1.778" layer="96"/>
</instance>
<instance part="C16" gate="G$1" x="33.02" y="523.24" smashed="yes">
<attribute name="NAME" x="34.544" y="523.621" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="518.541" size="1.778" layer="96"/>
</instance>
<instance part="GND18" gate="1" x="33.02" y="515.62" smashed="yes">
<attribute name="VALUE" x="30.48" y="513.08" size="1.778" layer="96"/>
</instance>
<instance part="GND19" gate="1" x="43.18" y="515.62" smashed="yes">
<attribute name="VALUE" x="40.64" y="513.08" size="1.778" layer="96"/>
</instance>
<instance part="C17" gate="G$1" x="154.94" y="523.24" smashed="yes">
<attribute name="NAME" x="156.464" y="523.621" size="1.778" layer="95"/>
<attribute name="VALUE" x="156.464" y="518.541" size="1.778" layer="96"/>
</instance>
<instance part="GND20" gate="1" x="154.94" y="515.62" smashed="yes">
<attribute name="VALUE" x="152.4" y="513.08" size="1.778" layer="96"/>
</instance>
<instance part="U4" gate="A" x="78.74" y="386.08" smashed="yes">
<attribute name="NAME" x="74.0156" y="387.5786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="382.4986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$4" gate="A" x="111.76" y="396.24" smashed="yes">
<attribute name="NAME" x="110.8456" y="399.5928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="399.5928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND21" gate="1" x="96.52" y="370.84" smashed="yes">
<attribute name="VALUE" x="93.98" y="368.3" size="1.778" layer="96"/>
</instance>
<instance part="C18" gate="G$1" x="101.6" y="388.62" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="390.144" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="390.144" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R7" gate="G$1" x="129.54" y="391.16" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="387.35" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="387.35" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R8" gate="G$1" x="129.54" y="378.46" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="374.65" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="374.65" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND22" gate="1" x="129.54" y="370.84" smashed="yes">
<attribute name="VALUE" x="127" y="368.3" size="1.778" layer="96"/>
</instance>
<instance part="C19" gate="G$1" x="139.7" y="393.7" smashed="yes">
<attribute name="NAME" x="141.224" y="394.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="389.001" size="1.778" layer="96"/>
</instance>
<instance part="C20" gate="G$1" x="147.32" y="393.7" smashed="yes">
<attribute name="NAME" x="148.844" y="394.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="389.001" size="1.778" layer="96"/>
</instance>
<instance part="GND23" gate="1" x="139.7" y="386.08" smashed="yes">
<attribute name="VALUE" x="137.16" y="383.54" size="1.778" layer="96"/>
</instance>
<instance part="GND24" gate="1" x="147.32" y="386.08" smashed="yes">
<attribute name="VALUE" x="144.78" y="383.54" size="1.778" layer="96"/>
</instance>
<instance part="C21" gate="G$1" x="43.18" y="393.7" smashed="yes">
<attribute name="NAME" x="44.704" y="394.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="389.001" size="1.778" layer="96"/>
</instance>
<instance part="C22" gate="G$1" x="33.02" y="393.7" smashed="yes">
<attribute name="NAME" x="34.544" y="394.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="389.001" size="1.778" layer="96"/>
</instance>
<instance part="GND25" gate="1" x="33.02" y="386.08" smashed="yes">
<attribute name="VALUE" x="30.48" y="383.54" size="1.778" layer="96"/>
</instance>
<instance part="GND26" gate="1" x="43.18" y="386.08" smashed="yes">
<attribute name="VALUE" x="40.64" y="383.54" size="1.778" layer="96"/>
</instance>
<instance part="C23" gate="G$1" x="154.94" y="393.7" smashed="yes">
<attribute name="NAME" x="156.464" y="394.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="156.464" y="389.001" size="1.778" layer="96"/>
</instance>
<instance part="GND27" gate="1" x="154.94" y="386.08" smashed="yes">
<attribute name="VALUE" x="152.4" y="383.54" size="1.778" layer="96"/>
</instance>
<instance part="U6" gate="A" x="436.88" y="353.06" smashed="yes">
<attribute name="NAME" x="432.1556" y="354.5586" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="349.4786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$6" gate="A" x="469.9" y="363.22" smashed="yes">
<attribute name="NAME" x="468.9856" y="366.5728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="366.5728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND35" gate="1" x="454.66" y="337.82" smashed="yes">
<attribute name="VALUE" x="452.12" y="335.28" size="1.778" layer="96"/>
</instance>
<instance part="C30" gate="G$1" x="459.74" y="355.6" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="357.124" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="357.124" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R11" gate="G$1" x="487.68" y="358.14" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="354.33" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="354.33" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R12" gate="G$1" x="487.68" y="345.44" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="341.63" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="341.63" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND36" gate="1" x="487.68" y="337.82" smashed="yes">
<attribute name="VALUE" x="485.14" y="335.28" size="1.778" layer="96"/>
</instance>
<instance part="C31" gate="G$1" x="497.84" y="360.68" smashed="yes">
<attribute name="NAME" x="499.364" y="361.061" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="355.981" size="1.778" layer="96"/>
</instance>
<instance part="C32" gate="G$1" x="505.46" y="360.68" smashed="yes">
<attribute name="NAME" x="506.984" y="361.061" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="355.981" size="1.778" layer="96"/>
</instance>
<instance part="GND37" gate="1" x="497.84" y="353.06" smashed="yes">
<attribute name="VALUE" x="495.3" y="350.52" size="1.778" layer="96"/>
</instance>
<instance part="GND38" gate="1" x="505.46" y="353.06" smashed="yes">
<attribute name="VALUE" x="502.92" y="350.52" size="1.778" layer="96"/>
</instance>
<instance part="C33" gate="G$1" x="401.32" y="360.68" smashed="yes">
<attribute name="NAME" x="402.844" y="361.061" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="355.981" size="1.778" layer="96"/>
</instance>
<instance part="C34" gate="G$1" x="391.16" y="360.68" smashed="yes">
<attribute name="NAME" x="392.684" y="361.061" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="355.981" size="1.778" layer="96"/>
</instance>
<instance part="GND39" gate="1" x="391.16" y="353.06" smashed="yes">
<attribute name="VALUE" x="388.62" y="350.52" size="1.778" layer="96"/>
</instance>
<instance part="GND40" gate="1" x="401.32" y="353.06" smashed="yes">
<attribute name="VALUE" x="398.78" y="350.52" size="1.778" layer="96"/>
</instance>
<instance part="C35" gate="G$1" x="513.08" y="360.68" smashed="yes">
<attribute name="NAME" x="514.604" y="361.061" size="1.778" layer="95"/>
<attribute name="VALUE" x="514.604" y="355.981" size="1.778" layer="96"/>
</instance>
<instance part="GND41" gate="1" x="513.08" y="353.06" smashed="yes">
<attribute name="VALUE" x="510.54" y="350.52" size="1.778" layer="96"/>
</instance>
<instance part="U7" gate="A" x="436.88" y="307.34" smashed="yes">
<attribute name="NAME" x="432.1556" y="308.8386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="303.7586" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$7" gate="A" x="469.9" y="317.5" smashed="yes">
<attribute name="NAME" x="468.9856" y="320.8528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="320.8528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND42" gate="1" x="454.66" y="292.1" smashed="yes">
<attribute name="VALUE" x="452.12" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="C36" gate="G$1" x="459.74" y="309.88" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="311.404" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="311.404" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R13" gate="G$1" x="487.68" y="312.42" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="308.61" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="308.61" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R14" gate="G$1" x="487.68" y="299.72" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="295.91" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="295.91" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND43" gate="1" x="487.68" y="292.1" smashed="yes">
<attribute name="VALUE" x="485.14" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="C37" gate="G$1" x="497.84" y="314.96" smashed="yes">
<attribute name="NAME" x="499.364" y="315.341" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="310.261" size="1.778" layer="96"/>
</instance>
<instance part="C38" gate="G$1" x="505.46" y="314.96" smashed="yes">
<attribute name="NAME" x="506.984" y="315.341" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="310.261" size="1.778" layer="96"/>
</instance>
<instance part="GND44" gate="1" x="497.84" y="307.34" smashed="yes">
<attribute name="VALUE" x="495.3" y="304.8" size="1.778" layer="96"/>
</instance>
<instance part="GND45" gate="1" x="505.46" y="307.34" smashed="yes">
<attribute name="VALUE" x="502.92" y="304.8" size="1.778" layer="96"/>
</instance>
<instance part="C39" gate="G$1" x="401.32" y="314.96" smashed="yes">
<attribute name="NAME" x="402.844" y="315.341" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="310.261" size="1.778" layer="96"/>
</instance>
<instance part="C40" gate="G$1" x="391.16" y="314.96" smashed="yes">
<attribute name="NAME" x="392.684" y="315.341" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="310.261" size="1.778" layer="96"/>
</instance>
<instance part="GND46" gate="1" x="391.16" y="307.34" smashed="yes">
<attribute name="VALUE" x="388.62" y="304.8" size="1.778" layer="96"/>
</instance>
<instance part="GND47" gate="1" x="401.32" y="307.34" smashed="yes">
<attribute name="VALUE" x="398.78" y="304.8" size="1.778" layer="96"/>
</instance>
<instance part="C41" gate="G$1" x="513.08" y="314.96" smashed="yes">
<attribute name="NAME" x="514.604" y="315.341" size="1.778" layer="95"/>
<attribute name="VALUE" x="514.604" y="310.261" size="1.778" layer="96"/>
</instance>
<instance part="GND48" gate="1" x="513.08" y="307.34" smashed="yes">
<attribute name="VALUE" x="510.54" y="304.8" size="1.778" layer="96"/>
</instance>
<instance part="U8" gate="A" x="436.88" y="154.94" smashed="yes">
<attribute name="NAME" x="432.1556" y="156.4386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="151.3586" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$8" gate="A" x="469.9" y="165.1" smashed="yes">
<attribute name="NAME" x="468.9856" y="168.4528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="168.4528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND49" gate="1" x="454.66" y="139.7" smashed="yes">
<attribute name="VALUE" x="452.12" y="137.16" size="1.778" layer="96"/>
</instance>
<instance part="C42" gate="G$1" x="459.74" y="157.48" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="159.004" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="159.004" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R15" gate="G$1" x="487.68" y="160.02" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="156.21" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="156.21" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R16" gate="G$1" x="487.68" y="147.32" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="143.51" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="143.51" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND50" gate="1" x="487.68" y="139.7" smashed="yes">
<attribute name="VALUE" x="485.14" y="137.16" size="1.778" layer="96"/>
</instance>
<instance part="C43" gate="G$1" x="497.84" y="162.56" smashed="yes">
<attribute name="NAME" x="499.364" y="162.941" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="157.861" size="1.778" layer="96"/>
</instance>
<instance part="C44" gate="G$1" x="505.46" y="162.56" smashed="yes">
<attribute name="NAME" x="506.984" y="162.941" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="157.861" size="1.778" layer="96"/>
</instance>
<instance part="GND51" gate="1" x="497.84" y="154.94" smashed="yes">
<attribute name="VALUE" x="495.3" y="152.4" size="1.778" layer="96"/>
</instance>
<instance part="GND52" gate="1" x="505.46" y="154.94" smashed="yes">
<attribute name="VALUE" x="502.92" y="152.4" size="1.778" layer="96"/>
</instance>
<instance part="C45" gate="G$1" x="401.32" y="162.56" smashed="yes">
<attribute name="NAME" x="402.844" y="162.941" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="157.861" size="1.778" layer="96"/>
</instance>
<instance part="C46" gate="G$1" x="391.16" y="162.56" smashed="yes">
<attribute name="NAME" x="392.684" y="162.941" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="157.861" size="1.778" layer="96"/>
</instance>
<instance part="GND53" gate="1" x="391.16" y="154.94" smashed="yes">
<attribute name="VALUE" x="388.62" y="152.4" size="1.778" layer="96"/>
</instance>
<instance part="GND54" gate="1" x="401.32" y="154.94" smashed="yes">
<attribute name="VALUE" x="398.78" y="152.4" size="1.778" layer="96"/>
</instance>
<instance part="C47" gate="G$1" x="513.08" y="162.56" smashed="yes">
<attribute name="NAME" x="514.604" y="162.941" size="1.778" layer="95"/>
<attribute name="VALUE" x="514.604" y="157.861" size="1.778" layer="96"/>
</instance>
<instance part="GND55" gate="1" x="513.08" y="154.94" smashed="yes">
<attribute name="VALUE" x="510.54" y="152.4" size="1.778" layer="96"/>
</instance>
<instance part="U10" gate="A" x="436.88" y="203.2" smashed="yes">
<attribute name="NAME" x="432.1556" y="204.6986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="199.6186" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$10" gate="A" x="469.9" y="213.36" smashed="yes">
<attribute name="NAME" x="468.9856" y="216.7128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="216.7128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND63" gate="1" x="454.66" y="187.96" smashed="yes">
<attribute name="VALUE" x="452.12" y="185.42" size="1.778" layer="96"/>
</instance>
<instance part="C54" gate="G$1" x="459.74" y="205.74" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="207.264" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="207.264" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R19" gate="G$1" x="487.68" y="208.28" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="204.47" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="204.47" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R20" gate="G$1" x="487.68" y="195.58" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="191.77" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="191.77" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND64" gate="1" x="487.68" y="187.96" smashed="yes">
<attribute name="VALUE" x="485.14" y="185.42" size="1.778" layer="96"/>
</instance>
<instance part="C55" gate="G$1" x="497.84" y="210.82" smashed="yes">
<attribute name="NAME" x="499.364" y="211.201" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="206.121" size="1.778" layer="96"/>
</instance>
<instance part="C56" gate="G$1" x="505.46" y="210.82" smashed="yes">
<attribute name="NAME" x="506.984" y="211.201" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="206.121" size="1.778" layer="96"/>
</instance>
<instance part="GND65" gate="1" x="497.84" y="203.2" smashed="yes">
<attribute name="VALUE" x="495.3" y="200.66" size="1.778" layer="96"/>
</instance>
<instance part="GND66" gate="1" x="505.46" y="203.2" smashed="yes">
<attribute name="VALUE" x="502.92" y="200.66" size="1.778" layer="96"/>
</instance>
<instance part="C57" gate="G$1" x="401.32" y="210.82" smashed="yes">
<attribute name="NAME" x="402.844" y="211.201" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="206.121" size="1.778" layer="96"/>
</instance>
<instance part="C58" gate="G$1" x="391.16" y="210.82" smashed="yes">
<attribute name="NAME" x="392.684" y="211.201" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="206.121" size="1.778" layer="96"/>
</instance>
<instance part="GND67" gate="1" x="391.16" y="203.2" smashed="yes">
<attribute name="VALUE" x="388.62" y="200.66" size="1.778" layer="96"/>
</instance>
<instance part="GND68" gate="1" x="401.32" y="203.2" smashed="yes">
<attribute name="VALUE" x="398.78" y="200.66" size="1.778" layer="96"/>
</instance>
<instance part="C59" gate="G$1" x="513.08" y="210.82" smashed="yes">
<attribute name="NAME" x="514.604" y="211.201" size="1.778" layer="95"/>
<attribute name="VALUE" x="514.604" y="206.121" size="1.778" layer="96"/>
</instance>
<instance part="GND69" gate="1" x="513.08" y="203.2" smashed="yes">
<attribute name="VALUE" x="510.54" y="200.66" size="1.778" layer="96"/>
</instance>
<instance part="U11" gate="A" x="436.88" y="462.28" smashed="yes">
<attribute name="NAME" x="432.1556" y="463.7786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="458.6986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$11" gate="A" x="469.9" y="472.44" smashed="yes">
<attribute name="NAME" x="468.9856" y="475.7928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="475.7928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND70" gate="1" x="454.66" y="447.04" smashed="yes">
<attribute name="VALUE" x="452.12" y="444.5" size="1.778" layer="96"/>
</instance>
<instance part="C60" gate="G$1" x="459.74" y="464.82" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="466.344" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="466.344" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R21" gate="G$1" x="487.68" y="467.36" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="463.55" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="463.55" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R22" gate="G$1" x="487.68" y="454.66" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="450.85" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="450.85" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND71" gate="1" x="487.68" y="447.04" smashed="yes">
<attribute name="VALUE" x="485.14" y="444.5" size="1.778" layer="96"/>
</instance>
<instance part="C61" gate="G$1" x="497.84" y="469.9" smashed="yes">
<attribute name="NAME" x="499.364" y="470.281" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="465.201" size="1.778" layer="96"/>
</instance>
<instance part="C62" gate="G$1" x="505.46" y="469.9" smashed="yes">
<attribute name="NAME" x="506.984" y="470.281" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="465.201" size="1.778" layer="96"/>
</instance>
<instance part="GND72" gate="1" x="497.84" y="462.28" smashed="yes">
<attribute name="VALUE" x="495.3" y="459.74" size="1.778" layer="96"/>
</instance>
<instance part="GND73" gate="1" x="505.46" y="462.28" smashed="yes">
<attribute name="VALUE" x="502.92" y="459.74" size="1.778" layer="96"/>
</instance>
<instance part="C63" gate="G$1" x="401.32" y="469.9" smashed="yes">
<attribute name="NAME" x="402.844" y="470.281" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="465.201" size="1.778" layer="96"/>
</instance>
<instance part="C64" gate="G$1" x="391.16" y="469.9" smashed="yes">
<attribute name="NAME" x="392.684" y="470.281" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="465.201" size="1.778" layer="96"/>
</instance>
<instance part="GND74" gate="1" x="391.16" y="462.28" smashed="yes">
<attribute name="VALUE" x="388.62" y="459.74" size="1.778" layer="96"/>
</instance>
<instance part="GND75" gate="1" x="401.32" y="462.28" smashed="yes">
<attribute name="VALUE" x="398.78" y="459.74" size="1.778" layer="96"/>
</instance>
<instance part="C65" gate="G$1" x="513.08" y="469.9" smashed="yes">
<attribute name="NAME" x="514.604" y="470.281" size="1.778" layer="95"/>
<attribute name="VALUE" x="514.604" y="465.201" size="1.778" layer="96"/>
</instance>
<instance part="GND76" gate="1" x="513.08" y="462.28" smashed="yes">
<attribute name="VALUE" x="510.54" y="459.74" size="1.778" layer="96"/>
</instance>
<instance part="U12" gate="A" x="78.74" y="340.36" smashed="yes">
<attribute name="NAME" x="74.0156" y="341.8586" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="336.7786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$12" gate="A" x="111.76" y="350.52" smashed="yes">
<attribute name="NAME" x="110.8456" y="353.8728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="353.8728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND77" gate="1" x="96.52" y="325.12" smashed="yes">
<attribute name="VALUE" x="93.98" y="322.58" size="1.778" layer="96"/>
</instance>
<instance part="C66" gate="G$1" x="101.6" y="342.9" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="344.424" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="344.424" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R23" gate="G$1" x="129.54" y="345.44" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="341.63" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="341.63" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R24" gate="G$1" x="129.54" y="332.74" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="328.93" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="328.93" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND78" gate="1" x="129.54" y="325.12" smashed="yes">
<attribute name="VALUE" x="127" y="322.58" size="1.778" layer="96"/>
</instance>
<instance part="C67" gate="G$1" x="139.7" y="347.98" smashed="yes">
<attribute name="NAME" x="141.224" y="348.361" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="343.281" size="1.778" layer="96"/>
</instance>
<instance part="C68" gate="G$1" x="147.32" y="347.98" smashed="yes">
<attribute name="NAME" x="148.844" y="348.361" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="343.281" size="1.778" layer="96"/>
</instance>
<instance part="GND79" gate="1" x="139.7" y="340.36" smashed="yes">
<attribute name="VALUE" x="137.16" y="337.82" size="1.778" layer="96"/>
</instance>
<instance part="GND80" gate="1" x="147.32" y="340.36" smashed="yes">
<attribute name="VALUE" x="144.78" y="337.82" size="1.778" layer="96"/>
</instance>
<instance part="C69" gate="G$1" x="43.18" y="347.98" smashed="yes">
<attribute name="NAME" x="44.704" y="348.361" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="343.281" size="1.778" layer="96"/>
</instance>
<instance part="C70" gate="G$1" x="33.02" y="347.98" smashed="yes">
<attribute name="NAME" x="34.544" y="348.361" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="343.281" size="1.778" layer="96"/>
</instance>
<instance part="GND81" gate="1" x="33.02" y="340.36" smashed="yes">
<attribute name="VALUE" x="30.48" y="337.82" size="1.778" layer="96"/>
</instance>
<instance part="GND82" gate="1" x="43.18" y="340.36" smashed="yes">
<attribute name="VALUE" x="40.64" y="337.82" size="1.778" layer="96"/>
</instance>
<instance part="U13" gate="A" x="436.88" y="406.4" smashed="yes">
<attribute name="NAME" x="432.1556" y="407.8986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="402.8186" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$13" gate="A" x="469.9" y="416.56" smashed="yes">
<attribute name="NAME" x="468.9856" y="419.9128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="419.9128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND83" gate="1" x="454.66" y="391.16" smashed="yes">
<attribute name="VALUE" x="452.12" y="388.62" size="1.778" layer="96"/>
</instance>
<instance part="C71" gate="G$1" x="459.74" y="408.94" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="410.464" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="410.464" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R25" gate="G$1" x="487.68" y="411.48" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="407.67" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="407.67" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R26" gate="G$1" x="487.68" y="398.78" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="394.97" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="394.97" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND84" gate="1" x="487.68" y="391.16" smashed="yes">
<attribute name="VALUE" x="485.14" y="388.62" size="1.778" layer="96"/>
</instance>
<instance part="C72" gate="G$1" x="497.84" y="414.02" smashed="yes">
<attribute name="NAME" x="499.364" y="414.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="409.321" size="1.778" layer="96"/>
</instance>
<instance part="C73" gate="G$1" x="505.46" y="414.02" smashed="yes">
<attribute name="NAME" x="506.984" y="414.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="409.321" size="1.778" layer="96"/>
</instance>
<instance part="GND85" gate="1" x="497.84" y="406.4" smashed="yes">
<attribute name="VALUE" x="495.3" y="403.86" size="1.778" layer="96"/>
</instance>
<instance part="GND86" gate="1" x="505.46" y="406.4" smashed="yes">
<attribute name="VALUE" x="502.92" y="403.86" size="1.778" layer="96"/>
</instance>
<instance part="C74" gate="G$1" x="401.32" y="414.02" smashed="yes">
<attribute name="NAME" x="402.844" y="414.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="409.321" size="1.778" layer="96"/>
</instance>
<instance part="C75" gate="G$1" x="391.16" y="414.02" smashed="yes">
<attribute name="NAME" x="392.684" y="414.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="409.321" size="1.778" layer="96"/>
</instance>
<instance part="GND87" gate="1" x="391.16" y="406.4" smashed="yes">
<attribute name="VALUE" x="388.62" y="403.86" size="1.778" layer="96"/>
</instance>
<instance part="GND88" gate="1" x="401.32" y="406.4" smashed="yes">
<attribute name="VALUE" x="398.78" y="403.86" size="1.778" layer="96"/>
</instance>
<instance part="U14" gate="A" x="436.88" y="111.76" smashed="yes">
<attribute name="NAME" x="432.1556" y="113.2586" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="108.1786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$14" gate="A" x="469.9" y="121.92" smashed="yes">
<attribute name="NAME" x="468.9856" y="125.2728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="125.2728" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND90" gate="1" x="454.66" y="96.52" smashed="yes">
<attribute name="VALUE" x="452.12" y="93.98" size="1.778" layer="96"/>
</instance>
<instance part="C77" gate="G$1" x="459.74" y="114.3" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="115.824" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="115.824" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R27" gate="G$1" x="487.68" y="116.84" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="113.03" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="113.03" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R28" gate="G$1" x="487.68" y="104.14" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="100.33" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="100.33" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND91" gate="1" x="487.68" y="96.52" smashed="yes">
<attribute name="VALUE" x="485.14" y="93.98" size="1.778" layer="96"/>
</instance>
<instance part="C78" gate="G$1" x="497.84" y="119.38" smashed="yes">
<attribute name="NAME" x="499.364" y="119.761" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="114.681" size="1.778" layer="96"/>
</instance>
<instance part="C79" gate="G$1" x="505.46" y="119.38" smashed="yes">
<attribute name="NAME" x="506.984" y="119.761" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="114.681" size="1.778" layer="96"/>
</instance>
<instance part="GND92" gate="1" x="497.84" y="111.76" smashed="yes">
<attribute name="VALUE" x="495.3" y="109.22" size="1.778" layer="96"/>
</instance>
<instance part="GND93" gate="1" x="505.46" y="111.76" smashed="yes">
<attribute name="VALUE" x="502.92" y="109.22" size="1.778" layer="96"/>
</instance>
<instance part="C80" gate="G$1" x="401.32" y="119.38" smashed="yes">
<attribute name="NAME" x="402.844" y="119.761" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="114.681" size="1.778" layer="96"/>
</instance>
<instance part="C81" gate="G$1" x="391.16" y="119.38" smashed="yes">
<attribute name="NAME" x="392.684" y="119.761" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="114.681" size="1.778" layer="96"/>
</instance>
<instance part="GND94" gate="1" x="391.16" y="111.76" smashed="yes">
<attribute name="VALUE" x="388.62" y="109.22" size="1.778" layer="96"/>
</instance>
<instance part="GND95" gate="1" x="401.32" y="111.76" smashed="yes">
<attribute name="VALUE" x="398.78" y="109.22" size="1.778" layer="96"/>
</instance>
<instance part="U15" gate="A" x="436.88" y="68.58" smashed="yes">
<attribute name="NAME" x="432.1556" y="70.0786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="64.9986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$15" gate="A" x="469.9" y="78.74" smashed="yes">
<attribute name="NAME" x="468.9856" y="82.0928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="82.0928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND97" gate="1" x="454.66" y="53.34" smashed="yes">
<attribute name="VALUE" x="452.12" y="50.8" size="1.778" layer="96"/>
</instance>
<instance part="C83" gate="G$1" x="459.74" y="71.12" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="72.644" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="72.644" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R29" gate="G$1" x="487.68" y="73.66" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="69.85" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="69.85" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R30" gate="G$1" x="487.68" y="60.96" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="57.15" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="57.15" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND98" gate="1" x="487.68" y="53.34" smashed="yes">
<attribute name="VALUE" x="485.14" y="50.8" size="1.778" layer="96"/>
</instance>
<instance part="C84" gate="G$1" x="497.84" y="76.2" smashed="yes">
<attribute name="NAME" x="499.364" y="76.581" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="71.501" size="1.778" layer="96"/>
</instance>
<instance part="C85" gate="G$1" x="505.46" y="76.2" smashed="yes">
<attribute name="NAME" x="506.984" y="76.581" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="71.501" size="1.778" layer="96"/>
</instance>
<instance part="GND99" gate="1" x="497.84" y="68.58" smashed="yes">
<attribute name="VALUE" x="495.3" y="66.04" size="1.778" layer="96"/>
</instance>
<instance part="GND100" gate="1" x="505.46" y="68.58" smashed="yes">
<attribute name="VALUE" x="502.92" y="66.04" size="1.778" layer="96"/>
</instance>
<instance part="C86" gate="G$1" x="401.32" y="76.2" smashed="yes">
<attribute name="NAME" x="402.844" y="76.581" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="71.501" size="1.778" layer="96"/>
</instance>
<instance part="C87" gate="G$1" x="391.16" y="76.2" smashed="yes">
<attribute name="NAME" x="392.684" y="76.581" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="71.501" size="1.778" layer="96"/>
</instance>
<instance part="GND101" gate="1" x="391.16" y="68.58" smashed="yes">
<attribute name="VALUE" x="388.62" y="66.04" size="1.778" layer="96"/>
</instance>
<instance part="GND102" gate="1" x="401.32" y="68.58" smashed="yes">
<attribute name="VALUE" x="398.78" y="66.04" size="1.778" layer="96"/>
</instance>
<instance part="U16" gate="A" x="436.88" y="25.4" smashed="yes">
<attribute name="NAME" x="432.1556" y="26.8986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="21.8186" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$16" gate="A" x="469.9" y="35.56" smashed="yes">
<attribute name="NAME" x="468.9856" y="38.9128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="38.9128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND104" gate="1" x="454.66" y="10.16" smashed="yes">
<attribute name="VALUE" x="452.12" y="7.62" size="1.778" layer="96"/>
</instance>
<instance part="C89" gate="G$1" x="459.74" y="27.94" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="29.464" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="29.464" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R31" gate="G$1" x="487.68" y="30.48" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="26.67" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="26.67" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R32" gate="G$1" x="487.68" y="17.78" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="13.97" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="13.97" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND105" gate="1" x="487.68" y="10.16" smashed="yes">
<attribute name="VALUE" x="485.14" y="7.62" size="1.778" layer="96"/>
</instance>
<instance part="C90" gate="G$1" x="497.84" y="33.02" smashed="yes">
<attribute name="NAME" x="499.364" y="33.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="28.321" size="1.778" layer="96"/>
</instance>
<instance part="C91" gate="G$1" x="505.46" y="33.02" smashed="yes">
<attribute name="NAME" x="506.984" y="33.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="28.321" size="1.778" layer="96"/>
</instance>
<instance part="GND106" gate="1" x="497.84" y="25.4" smashed="yes">
<attribute name="VALUE" x="495.3" y="22.86" size="1.778" layer="96"/>
</instance>
<instance part="GND107" gate="1" x="505.46" y="25.4" smashed="yes">
<attribute name="VALUE" x="502.92" y="22.86" size="1.778" layer="96"/>
</instance>
<instance part="C92" gate="G$1" x="401.32" y="33.02" smashed="yes">
<attribute name="NAME" x="402.844" y="33.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="28.321" size="1.778" layer="96"/>
</instance>
<instance part="C93" gate="G$1" x="391.16" y="33.02" smashed="yes">
<attribute name="NAME" x="392.684" y="33.401" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="28.321" size="1.778" layer="96"/>
</instance>
<instance part="GND108" gate="1" x="391.16" y="25.4" smashed="yes">
<attribute name="VALUE" x="388.62" y="22.86" size="1.778" layer="96"/>
</instance>
<instance part="GND109" gate="1" x="401.32" y="25.4" smashed="yes">
<attribute name="VALUE" x="398.78" y="22.86" size="1.778" layer="96"/>
</instance>
<instance part="U17" gate="A" x="436.88" y="513.08" smashed="yes">
<attribute name="NAME" x="432.1556" y="514.5786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="509.4986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$17" gate="A" x="469.9" y="523.24" smashed="yes">
<attribute name="NAME" x="468.9856" y="526.5928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="526.5928" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND89" gate="1" x="454.66" y="497.84" smashed="yes">
<attribute name="VALUE" x="452.12" y="495.3" size="1.778" layer="96"/>
</instance>
<instance part="C76" gate="G$1" x="459.74" y="515.62" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="517.144" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="517.144" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R33" gate="G$1" x="487.68" y="518.16" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="514.35" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="514.35" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R34" gate="G$1" x="487.68" y="505.46" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="501.65" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="501.65" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND96" gate="1" x="487.68" y="497.84" smashed="yes">
<attribute name="VALUE" x="485.14" y="495.3" size="1.778" layer="96"/>
</instance>
<instance part="C82" gate="G$1" x="497.84" y="520.7" smashed="yes">
<attribute name="NAME" x="499.364" y="521.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="516.001" size="1.778" layer="96"/>
</instance>
<instance part="C88" gate="G$1" x="505.46" y="520.7" smashed="yes">
<attribute name="NAME" x="506.984" y="521.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="516.001" size="1.778" layer="96"/>
</instance>
<instance part="GND103" gate="1" x="497.84" y="513.08" smashed="yes">
<attribute name="VALUE" x="495.3" y="510.54" size="1.778" layer="96"/>
</instance>
<instance part="GND110" gate="1" x="505.46" y="513.08" smashed="yes">
<attribute name="VALUE" x="502.92" y="510.54" size="1.778" layer="96"/>
</instance>
<instance part="C94" gate="G$1" x="401.32" y="520.7" smashed="yes">
<attribute name="NAME" x="402.844" y="521.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="516.001" size="1.778" layer="96"/>
</instance>
<instance part="C95" gate="G$1" x="391.16" y="520.7" smashed="yes">
<attribute name="NAME" x="392.684" y="521.081" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="516.001" size="1.778" layer="96"/>
</instance>
<instance part="GND111" gate="1" x="391.16" y="513.08" smashed="yes">
<attribute name="VALUE" x="388.62" y="510.54" size="1.778" layer="96"/>
</instance>
<instance part="GND112" gate="1" x="401.32" y="513.08" smashed="yes">
<attribute name="VALUE" x="398.78" y="510.54" size="1.778" layer="96"/>
</instance>
<instance part="U18" gate="A" x="574.04" y="210.82" smashed="yes">
<attribute name="NAME" x="597.2556" y="219.9386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="596.6206" y="217.3986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C96" gate="G$1" x="558.8" y="213.36" smashed="yes" rot="R270">
<attribute name="NAME" x="552.45" y="207.01" size="1.778" layer="95" rot="R270" align="center-left"/>
</instance>
<instance part="C97" gate="G$1" x="637.54" y="190.5" smashed="yes" rot="R90">
<attribute name="NAME" x="643.89" y="194.31" size="1.778" layer="95" rot="R90" align="center-left"/>
</instance>
<instance part="GND113" gate="1" x="637.54" y="187.96" smashed="yes">
<attribute name="VALUE" x="635" y="185.42" size="1.778" layer="96"/>
</instance>
<instance part="GND114" gate="1" x="629.92" y="205.74" smashed="yes" rot="R90">
<attribute name="VALUE" x="632.46" y="203.2" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND115" gate="1" x="574.04" y="205.74" smashed="yes" rot="R270">
<attribute name="VALUE" x="571.5" y="208.28" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="U19" gate="A" x="566.42" y="469.9" smashed="yes">
<attribute name="NAME" x="589.6356" y="479.0186" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="589.0006" y="476.4786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C98" gate="G$1" x="551.18" y="472.44" smashed="yes" rot="R270">
<attribute name="NAME" x="544.83" y="466.09" size="1.778" layer="95" rot="R270" align="center-left"/>
</instance>
<instance part="C99" gate="G$1" x="629.92" y="449.58" smashed="yes" rot="R90">
<attribute name="NAME" x="636.27" y="453.39" size="1.778" layer="95" rot="R90" align="center-left"/>
</instance>
<instance part="GND116" gate="1" x="629.92" y="447.04" smashed="yes">
<attribute name="VALUE" x="627.38" y="444.5" size="1.778" layer="96"/>
</instance>
<instance part="GND117" gate="1" x="622.3" y="464.82" smashed="yes" rot="R90">
<attribute name="VALUE" x="624.84" y="462.28" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND118" gate="1" x="566.42" y="464.82" smashed="yes" rot="R270">
<attribute name="VALUE" x="563.88" y="467.36" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="U20" gate="A" x="576.58" y="431.8" smashed="yes">
<attribute name="NAME" x="599.7956" y="440.9186" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="599.1606" y="438.3786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C100" gate="G$1" x="561.34" y="434.34" smashed="yes" rot="R270">
<attribute name="NAME" x="554.99" y="427.99" size="1.778" layer="95" rot="R270" align="center-left"/>
</instance>
<instance part="C101" gate="G$1" x="640.08" y="411.48" smashed="yes" rot="R90">
<attribute name="NAME" x="646.43" y="415.29" size="1.778" layer="95" rot="R90" align="center-left"/>
</instance>
<instance part="GND119" gate="1" x="640.08" y="408.94" smashed="yes">
<attribute name="VALUE" x="637.54" y="406.4" size="1.778" layer="96"/>
</instance>
<instance part="GND120" gate="1" x="632.46" y="426.72" smashed="yes" rot="R90">
<attribute name="VALUE" x="635" y="424.18" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND121" gate="1" x="576.58" y="426.72" smashed="yes" rot="R270">
<attribute name="VALUE" x="574.04" y="429.26" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="U21" gate="A" x="576.58" y="398.78" smashed="yes">
<attribute name="NAME" x="599.7956" y="407.8986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="599.1606" y="405.3586" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C102" gate="G$1" x="561.34" y="401.32" smashed="yes" rot="R270">
<attribute name="NAME" x="554.99" y="394.97" size="1.778" layer="95" rot="R270" align="center-left"/>
</instance>
<instance part="C103" gate="G$1" x="640.08" y="378.46" smashed="yes" rot="R90">
<attribute name="NAME" x="646.43" y="382.27" size="1.778" layer="95" rot="R90" align="center-left"/>
</instance>
<instance part="GND122" gate="1" x="640.08" y="375.92" smashed="yes">
<attribute name="VALUE" x="637.54" y="373.38" size="1.778" layer="96"/>
</instance>
<instance part="GND123" gate="1" x="632.46" y="393.7" smashed="yes" rot="R90">
<attribute name="VALUE" x="635" y="391.16" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND124" gate="1" x="576.58" y="393.7" smashed="yes" rot="R270">
<attribute name="VALUE" x="574.04" y="396.24" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="U22" gate="A" x="563.88" y="518.16" smashed="yes">
<attribute name="NAME" x="587.0956" y="527.2786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="586.4606" y="524.7386" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C104" gate="G$1" x="548.64" y="520.7" smashed="yes" rot="R270">
<attribute name="NAME" x="542.29" y="514.35" size="1.778" layer="95" rot="R270" align="center-left"/>
</instance>
<instance part="C105" gate="G$1" x="627.38" y="497.84" smashed="yes" rot="R90">
<attribute name="NAME" x="633.73" y="501.65" size="1.778" layer="95" rot="R90" align="center-left"/>
</instance>
<instance part="GND125" gate="1" x="627.38" y="495.3" smashed="yes">
<attribute name="VALUE" x="624.84" y="492.76" size="1.778" layer="96"/>
</instance>
<instance part="GND126" gate="1" x="619.76" y="513.08" smashed="yes" rot="R90">
<attribute name="VALUE" x="622.3" y="510.54" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND127" gate="1" x="563.88" y="513.08" smashed="yes" rot="R270">
<attribute name="VALUE" x="561.34" y="515.62" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="X16" gate="-1" x="180.34" y="525.78" smashed="yes">
<attribute name="NAME" x="182.88" y="525.018" size="1.524" layer="95"/>
<attribute name="VALUE" x="179.578" y="527.177" size="1.778" layer="96"/>
</instance>
<instance part="X16" gate="-2" x="180.34" y="523.24" smashed="yes">
<attribute name="NAME" x="182.88" y="522.478" size="1.524" layer="95"/>
</instance>
<instance part="GND129" gate="1" x="177.8" y="520.7" smashed="yes">
<attribute name="VALUE" x="175.26" y="518.16" size="1.778" layer="96"/>
</instance>
<instance part="X18" gate="-1" x="665.48" y="203.2" smashed="yes">
<attribute name="NAME" x="668.02" y="202.438" size="1.524" layer="95"/>
<attribute name="VALUE" x="664.718" y="204.597" size="1.778" layer="96"/>
</instance>
<instance part="X18" gate="-2" x="665.48" y="200.66" smashed="yes">
<attribute name="NAME" x="668.02" y="199.898" size="1.524" layer="95"/>
</instance>
<instance part="GND131" gate="1" x="662.94" y="198.12" smashed="yes">
<attribute name="VALUE" x="660.4" y="195.58" size="1.778" layer="96"/>
</instance>
<instance part="X19" gate="-1" x="652.78" y="510.54" smashed="yes">
<attribute name="NAME" x="655.32" y="509.778" size="1.524" layer="95"/>
<attribute name="VALUE" x="652.018" y="511.937" size="1.778" layer="96"/>
</instance>
<instance part="X19" gate="-2" x="652.78" y="508" smashed="yes">
<attribute name="NAME" x="655.32" y="507.238" size="1.524" layer="95"/>
</instance>
<instance part="GND132" gate="1" x="650.24" y="505.46" smashed="yes">
<attribute name="VALUE" x="647.7" y="502.92" size="1.778" layer="96"/>
</instance>
<instance part="X20" gate="-1" x="675.64" y="391.16" smashed="yes">
<attribute name="NAME" x="678.18" y="390.398" size="1.524" layer="95"/>
<attribute name="VALUE" x="674.878" y="392.557" size="1.778" layer="96"/>
</instance>
<instance part="X20" gate="-2" x="675.64" y="388.62" smashed="yes">
<attribute name="NAME" x="678.18" y="387.858" size="1.524" layer="95"/>
</instance>
<instance part="GND133" gate="1" x="673.1" y="386.08" smashed="yes">
<attribute name="VALUE" x="670.56" y="383.54" size="1.778" layer="96"/>
</instance>
<instance part="X21" gate="-1" x="675.64" y="424.18" smashed="yes">
<attribute name="NAME" x="678.18" y="423.418" size="1.524" layer="95"/>
<attribute name="VALUE" x="674.878" y="425.577" size="1.778" layer="96"/>
</instance>
<instance part="X21" gate="-2" x="675.64" y="421.64" smashed="yes">
<attribute name="NAME" x="678.18" y="420.878" size="1.524" layer="95"/>
</instance>
<instance part="GND134" gate="1" x="673.1" y="419.1" smashed="yes">
<attribute name="VALUE" x="670.56" y="416.56" size="1.778" layer="96"/>
</instance>
<instance part="X22" gate="-1" x="167.64" y="350.52" smashed="yes">
<attribute name="NAME" x="170.18" y="349.758" size="1.524" layer="95"/>
<attribute name="VALUE" x="169.418" y="351.917" size="1.778" layer="96"/>
</instance>
<instance part="X22" gate="-2" x="167.64" y="347.98" smashed="yes">
<attribute name="NAME" x="170.18" y="347.218" size="1.524" layer="95"/>
</instance>
<instance part="GND135" gate="1" x="160.02" y="345.44" smashed="yes">
<attribute name="VALUE" x="157.48" y="342.9" size="1.778" layer="96"/>
</instance>
<instance part="X23" gate="-1" x="530.86" y="472.44" smashed="yes">
<attribute name="NAME" x="533.4" y="471.678" size="1.524" layer="95"/>
<attribute name="VALUE" x="530.098" y="473.837" size="1.778" layer="96"/>
</instance>
<instance part="X23" gate="-2" x="530.86" y="469.9" smashed="yes">
<attribute name="NAME" x="533.4" y="469.138" size="1.524" layer="95"/>
</instance>
<instance part="GND136" gate="1" x="528.32" y="467.36" smashed="yes">
<attribute name="VALUE" x="525.78" y="464.82" size="1.778" layer="96"/>
</instance>
<instance part="X24" gate="-1" x="657.86" y="462.28" smashed="yes">
<attribute name="NAME" x="660.4" y="461.518" size="1.524" layer="95"/>
<attribute name="VALUE" x="657.098" y="463.677" size="1.778" layer="96"/>
</instance>
<instance part="X24" gate="-2" x="657.86" y="459.74" smashed="yes">
<attribute name="NAME" x="660.4" y="458.978" size="1.524" layer="95"/>
</instance>
<instance part="GND137" gate="1" x="655.32" y="457.2" smashed="yes">
<attribute name="VALUE" x="652.78" y="454.66" size="1.778" layer="96"/>
</instance>
<instance part="FRAME1" gate="G$1" x="436.88" y="0" smashed="yes"/>
<instance part="FRAME1" gate="G$2" x="762" y="0" smashed="yes">
<attribute name="LAST_DATE_TIME" x="774.7" y="1.27" size="2.54" layer="94"/>
<attribute name="SHEET" x="848.36" y="1.27" size="2.54" layer="94"/>
<attribute name="DRAWING_NAME" x="779.78" y="19.05" size="2.54" layer="94"/>
</instance>
<instance part="X1" gate="-1" x="279.4" y="515.62" smashed="yes">
<attribute name="NAME" x="278.13" y="516.509" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="X1" gate="-2" x="279.4" y="510.54" smashed="yes">
<attribute name="NAME" x="278.13" y="511.429" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="275.59" y="506.857" size="1.778" layer="96"/>
</instance>
<instance part="GND150" gate="1" x="284.48" y="508" smashed="yes">
<attribute name="VALUE" x="281.94" y="505.46" size="1.778" layer="96"/>
</instance>
<instance part="SV1" gate="G$1" x="292.1" y="452.12" smashed="yes" rot="R90">
<attribute name="VALUE" x="307.34" y="448.31" size="1.778" layer="96" rot="R90"/>
<attribute name="NAME" x="276.098" y="448.31" size="1.778" layer="95" rot="R90"/>
</instance>
<instance part="GND167" gate="1" x="279.4" y="439.42" smashed="yes">
<attribute name="VALUE" x="276.86" y="436.88" size="1.778" layer="96"/>
</instance>
<instance part="X27" gate="-1" x="185.42" y="408.94" smashed="yes">
<attribute name="NAME" x="187.96" y="408.178" size="1.524" layer="95"/>
<attribute name="VALUE" x="184.658" y="410.337" size="1.778" layer="96"/>
</instance>
<instance part="X27" gate="-2" x="185.42" y="406.4" smashed="yes">
<attribute name="NAME" x="187.96" y="405.638" size="1.524" layer="95"/>
</instance>
<instance part="GND169" gate="1" x="182.88" y="403.86" smashed="yes">
<attribute name="VALUE" x="180.34" y="401.32" size="1.778" layer="96"/>
</instance>
<instance part="U5" gate="A" x="251.46" y="350.52" smashed="yes">
<attribute name="NAME" x="272.1356" y="359.6386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="271.5006" y="357.0986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C24" gate="G$1" x="243.84" y="350.52" smashed="yes" rot="R90">
<attribute name="NAME" x="243.459" y="352.044" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="248.539" y="352.044" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND28" gate="1" x="236.22" y="350.52" smashed="yes" rot="R270">
<attribute name="VALUE" x="233.68" y="353.06" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C25" gate="G$1" x="226.06" y="342.9" smashed="yes" rot="R180">
<attribute name="NAME" x="224.536" y="342.519" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="224.536" y="347.599" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND29" gate="1" x="226.06" y="337.82" smashed="yes">
<attribute name="VALUE" x="223.52" y="335.28" size="1.778" layer="96"/>
</instance>
<instance part="C26" gate="G$1" x="238.76" y="340.36" smashed="yes" rot="R180">
<attribute name="NAME" x="237.236" y="339.979" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="237.236" y="345.059" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND30" gate="1" x="238.76" y="335.28" smashed="yes">
<attribute name="VALUE" x="236.22" y="332.74" size="1.778" layer="96"/>
</instance>
<instance part="GND31" gate="1" x="251.46" y="340.36" smashed="yes">
<attribute name="VALUE" x="248.92" y="337.82" size="1.778" layer="96"/>
</instance>
<instance part="R9" gate="G$1" x="314.96" y="337.82" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="334.01" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="334.01" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R10" gate="G$1" x="314.96" y="327.66" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="323.85" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="323.85" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND32" gate="1" x="314.96" y="320.04" smashed="yes">
<attribute name="VALUE" x="312.42" y="317.5" size="1.778" layer="96"/>
</instance>
<instance part="C27" gate="G$1" x="330.2" y="337.82" smashed="yes" rot="R180">
<attribute name="NAME" x="328.676" y="337.439" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="328.676" y="342.519" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND33" gate="1" x="330.2" y="332.74" smashed="yes">
<attribute name="VALUE" x="327.66" y="330.2" size="1.778" layer="96"/>
</instance>
<instance part="C28" gate="G$1" x="337.82" y="342.9" smashed="yes" rot="R180">
<attribute name="NAME" x="336.296" y="342.519" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="336.296" y="347.599" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND34" gate="1" x="337.82" y="337.82" smashed="yes">
<attribute name="VALUE" x="335.28" y="335.28" size="1.778" layer="96"/>
</instance>
<instance part="GND56" gate="1" x="304.8" y="350.52" smashed="yes" rot="R90">
<attribute name="VALUE" x="307.34" y="347.98" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U9" gate="A" x="78.74" y="292.1" smashed="yes">
<attribute name="NAME" x="74.0156" y="293.5986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="288.5186" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$5" gate="A" x="111.76" y="302.26" smashed="yes">
<attribute name="NAME" x="110.8456" y="305.6128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="305.6128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND57" gate="1" x="96.52" y="276.86" smashed="yes">
<attribute name="VALUE" x="93.98" y="274.32" size="1.778" layer="96"/>
</instance>
<instance part="C29" gate="G$1" x="101.6" y="294.64" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="296.164" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="296.164" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R17" gate="G$1" x="129.54" y="297.18" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="293.37" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="293.37" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R18" gate="G$1" x="129.54" y="284.48" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="280.67" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="280.67" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND58" gate="1" x="129.54" y="276.86" smashed="yes">
<attribute name="VALUE" x="127" y="274.32" size="1.778" layer="96"/>
</instance>
<instance part="C48" gate="G$1" x="139.7" y="299.72" smashed="yes">
<attribute name="NAME" x="141.224" y="300.101" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="295.021" size="1.778" layer="96"/>
</instance>
<instance part="C49" gate="G$1" x="147.32" y="299.72" smashed="yes">
<attribute name="NAME" x="148.844" y="300.101" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="295.021" size="1.778" layer="96"/>
</instance>
<instance part="GND59" gate="1" x="139.7" y="292.1" smashed="yes">
<attribute name="VALUE" x="137.16" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="GND60" gate="1" x="147.32" y="292.1" smashed="yes">
<attribute name="VALUE" x="144.78" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="C50" gate="G$1" x="43.18" y="299.72" smashed="yes">
<attribute name="NAME" x="44.704" y="300.101" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="295.021" size="1.778" layer="96"/>
</instance>
<instance part="C51" gate="G$1" x="33.02" y="299.72" smashed="yes">
<attribute name="NAME" x="34.544" y="300.101" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="295.021" size="1.778" layer="96"/>
</instance>
<instance part="GND61" gate="1" x="33.02" y="292.1" smashed="yes">
<attribute name="VALUE" x="30.48" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="GND62" gate="1" x="43.18" y="292.1" smashed="yes">
<attribute name="VALUE" x="40.64" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="X2" gate="-1" x="167.64" y="302.26" smashed="yes">
<attribute name="NAME" x="170.18" y="301.498" size="1.524" layer="95"/>
<attribute name="VALUE" x="169.418" y="303.657" size="1.778" layer="96"/>
</instance>
<instance part="X2" gate="-2" x="167.64" y="299.72" smashed="yes">
<attribute name="NAME" x="170.18" y="298.958" size="1.524" layer="95"/>
</instance>
<instance part="GND130" gate="1" x="160.02" y="297.18" smashed="yes">
<attribute name="VALUE" x="157.48" y="294.64" size="1.778" layer="96"/>
</instance>
<instance part="U23" gate="A" x="251.46" y="302.26" smashed="yes">
<attribute name="NAME" x="272.1356" y="311.3786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="271.5006" y="308.8386" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C52" gate="G$1" x="243.84" y="302.26" smashed="yes" rot="R90">
<attribute name="NAME" x="243.459" y="303.784" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="248.539" y="303.784" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND143" gate="1" x="236.22" y="302.26" smashed="yes" rot="R270">
<attribute name="VALUE" x="233.68" y="304.8" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C53" gate="G$1" x="226.06" y="294.64" smashed="yes" rot="R180">
<attribute name="NAME" x="224.536" y="294.259" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="224.536" y="299.339" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND151" gate="1" x="226.06" y="289.56" smashed="yes">
<attribute name="VALUE" x="223.52" y="287.02" size="1.778" layer="96"/>
</instance>
<instance part="C106" gate="G$1" x="238.76" y="292.1" smashed="yes" rot="R180">
<attribute name="NAME" x="237.236" y="291.719" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="237.236" y="296.799" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND152" gate="1" x="238.76" y="287.02" smashed="yes">
<attribute name="VALUE" x="236.22" y="284.48" size="1.778" layer="96"/>
</instance>
<instance part="GND153" gate="1" x="251.46" y="292.1" smashed="yes">
<attribute name="VALUE" x="248.92" y="289.56" size="1.778" layer="96"/>
</instance>
<instance part="R35" gate="G$1" x="314.96" y="289.56" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="285.75" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="285.75" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R36" gate="G$1" x="314.96" y="279.4" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="275.59" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="275.59" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND154" gate="1" x="314.96" y="271.78" smashed="yes">
<attribute name="VALUE" x="312.42" y="269.24" size="1.778" layer="96"/>
</instance>
<instance part="C107" gate="G$1" x="330.2" y="289.56" smashed="yes" rot="R180">
<attribute name="NAME" x="328.676" y="289.179" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="328.676" y="294.259" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND155" gate="1" x="330.2" y="284.48" smashed="yes">
<attribute name="VALUE" x="327.66" y="281.94" size="1.778" layer="96"/>
</instance>
<instance part="C108" gate="G$1" x="337.82" y="294.64" smashed="yes" rot="R180">
<attribute name="NAME" x="336.296" y="294.259" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="336.296" y="299.339" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND156" gate="1" x="337.82" y="289.56" smashed="yes">
<attribute name="VALUE" x="335.28" y="287.02" size="1.778" layer="96"/>
</instance>
<instance part="GND157" gate="1" x="304.8" y="302.26" smashed="yes" rot="R90">
<attribute name="VALUE" x="307.34" y="299.72" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U24" gate="A" x="78.74" y="241.3" smashed="yes">
<attribute name="NAME" x="74.0156" y="242.7986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="237.7186" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$9" gate="A" x="111.76" y="251.46" smashed="yes">
<attribute name="NAME" x="110.8456" y="254.8128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="254.8128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND158" gate="1" x="96.52" y="226.06" smashed="yes">
<attribute name="VALUE" x="93.98" y="223.52" size="1.778" layer="96"/>
</instance>
<instance part="C109" gate="G$1" x="101.6" y="243.84" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="245.364" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="245.364" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R37" gate="G$1" x="129.54" y="246.38" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="242.57" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="242.57" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R38" gate="G$1" x="129.54" y="233.68" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="229.87" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="229.87" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND159" gate="1" x="129.54" y="226.06" smashed="yes">
<attribute name="VALUE" x="127" y="223.52" size="1.778" layer="96"/>
</instance>
<instance part="C110" gate="G$1" x="139.7" y="248.92" smashed="yes">
<attribute name="NAME" x="141.224" y="249.301" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="244.221" size="1.778" layer="96"/>
</instance>
<instance part="C111" gate="G$1" x="147.32" y="248.92" smashed="yes">
<attribute name="NAME" x="148.844" y="249.301" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="244.221" size="1.778" layer="96"/>
</instance>
<instance part="GND160" gate="1" x="139.7" y="241.3" smashed="yes">
<attribute name="VALUE" x="137.16" y="238.76" size="1.778" layer="96"/>
</instance>
<instance part="GND161" gate="1" x="147.32" y="241.3" smashed="yes">
<attribute name="VALUE" x="144.78" y="238.76" size="1.778" layer="96"/>
</instance>
<instance part="C112" gate="G$1" x="43.18" y="248.92" smashed="yes">
<attribute name="NAME" x="44.704" y="249.301" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="244.221" size="1.778" layer="96"/>
</instance>
<instance part="C113" gate="G$1" x="33.02" y="248.92" smashed="yes">
<attribute name="NAME" x="34.544" y="249.301" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="244.221" size="1.778" layer="96"/>
</instance>
<instance part="GND162" gate="1" x="33.02" y="241.3" smashed="yes">
<attribute name="VALUE" x="30.48" y="238.76" size="1.778" layer="96"/>
</instance>
<instance part="GND163" gate="1" x="43.18" y="241.3" smashed="yes">
<attribute name="VALUE" x="40.64" y="238.76" size="1.778" layer="96"/>
</instance>
<instance part="X9" gate="-1" x="167.64" y="251.46" smashed="yes">
<attribute name="NAME" x="170.18" y="250.698" size="1.524" layer="95"/>
<attribute name="VALUE" x="169.418" y="252.857" size="1.778" layer="96"/>
</instance>
<instance part="X9" gate="-2" x="167.64" y="248.92" smashed="yes">
<attribute name="NAME" x="170.18" y="248.158" size="1.524" layer="95"/>
</instance>
<instance part="GND164" gate="1" x="160.02" y="246.38" smashed="yes">
<attribute name="VALUE" x="157.48" y="243.84" size="1.778" layer="96"/>
</instance>
<instance part="U25" gate="A" x="251.46" y="251.46" smashed="yes">
<attribute name="NAME" x="272.1356" y="260.5786" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="271.5006" y="258.0386" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C114" gate="G$1" x="243.84" y="251.46" smashed="yes" rot="R90">
<attribute name="NAME" x="243.459" y="252.984" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="248.539" y="252.984" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND165" gate="1" x="236.22" y="251.46" smashed="yes" rot="R270">
<attribute name="VALUE" x="233.68" y="254" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C115" gate="G$1" x="226.06" y="243.84" smashed="yes" rot="R180">
<attribute name="NAME" x="224.536" y="243.459" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="224.536" y="248.539" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND166" gate="1" x="226.06" y="238.76" smashed="yes">
<attribute name="VALUE" x="223.52" y="236.22" size="1.778" layer="96"/>
</instance>
<instance part="C116" gate="G$1" x="238.76" y="241.3" smashed="yes" rot="R180">
<attribute name="NAME" x="237.236" y="240.919" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="237.236" y="245.999" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND168" gate="1" x="238.76" y="236.22" smashed="yes">
<attribute name="VALUE" x="236.22" y="233.68" size="1.778" layer="96"/>
</instance>
<instance part="GND170" gate="1" x="251.46" y="241.3" smashed="yes">
<attribute name="VALUE" x="248.92" y="238.76" size="1.778" layer="96"/>
</instance>
<instance part="R39" gate="G$1" x="314.96" y="238.76" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="234.95" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="234.95" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R40" gate="G$1" x="314.96" y="228.6" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="224.79" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="224.79" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND171" gate="1" x="314.96" y="220.98" smashed="yes">
<attribute name="VALUE" x="312.42" y="218.44" size="1.778" layer="96"/>
</instance>
<instance part="C117" gate="G$1" x="330.2" y="238.76" smashed="yes" rot="R180">
<attribute name="NAME" x="328.676" y="238.379" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="328.676" y="243.459" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND172" gate="1" x="330.2" y="233.68" smashed="yes">
<attribute name="VALUE" x="327.66" y="231.14" size="1.778" layer="96"/>
</instance>
<instance part="C118" gate="G$1" x="337.82" y="243.84" smashed="yes" rot="R180">
<attribute name="NAME" x="336.296" y="243.459" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="336.296" y="248.539" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND173" gate="1" x="337.82" y="238.76" smashed="yes">
<attribute name="VALUE" x="335.28" y="236.22" size="1.778" layer="96"/>
</instance>
<instance part="GND174" gate="1" x="304.8" y="251.46" smashed="yes" rot="R90">
<attribute name="VALUE" x="307.34" y="248.92" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U26" gate="A" x="78.74" y="142.24" smashed="yes">
<attribute name="NAME" x="74.0156" y="143.7386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="138.6586" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$18" gate="A" x="111.76" y="152.4" smashed="yes">
<attribute name="NAME" x="110.8456" y="155.7528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="155.7528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND175" gate="1" x="96.52" y="127" smashed="yes">
<attribute name="VALUE" x="93.98" y="124.46" size="1.778" layer="96"/>
</instance>
<instance part="C119" gate="G$1" x="101.6" y="144.78" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="146.304" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="146.304" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R41" gate="G$1" x="129.54" y="147.32" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="143.51" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="143.51" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R42" gate="G$1" x="129.54" y="134.62" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="130.81" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="130.81" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND176" gate="1" x="129.54" y="127" smashed="yes">
<attribute name="VALUE" x="127" y="124.46" size="1.778" layer="96"/>
</instance>
<instance part="C120" gate="G$1" x="139.7" y="149.86" smashed="yes">
<attribute name="NAME" x="141.224" y="150.241" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="145.161" size="1.778" layer="96"/>
</instance>
<instance part="C121" gate="G$1" x="147.32" y="149.86" smashed="yes">
<attribute name="NAME" x="148.844" y="150.241" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="145.161" size="1.778" layer="96"/>
</instance>
<instance part="GND177" gate="1" x="139.7" y="142.24" smashed="yes">
<attribute name="VALUE" x="137.16" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="GND178" gate="1" x="147.32" y="142.24" smashed="yes">
<attribute name="VALUE" x="144.78" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="C122" gate="G$1" x="43.18" y="149.86" smashed="yes">
<attribute name="NAME" x="44.704" y="150.241" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="145.161" size="1.778" layer="96"/>
</instance>
<instance part="C123" gate="G$1" x="33.02" y="149.86" smashed="yes">
<attribute name="NAME" x="34.544" y="150.241" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="145.161" size="1.778" layer="96"/>
</instance>
<instance part="GND179" gate="1" x="33.02" y="142.24" smashed="yes">
<attribute name="VALUE" x="30.48" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="GND180" gate="1" x="43.18" y="142.24" smashed="yes">
<attribute name="VALUE" x="40.64" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="X17" gate="-1" x="167.64" y="152.4" smashed="yes">
<attribute name="NAME" x="170.18" y="151.638" size="1.524" layer="95"/>
<attribute name="VALUE" x="169.418" y="153.797" size="1.778" layer="96"/>
</instance>
<instance part="X17" gate="-2" x="167.64" y="149.86" smashed="yes">
<attribute name="NAME" x="170.18" y="149.098" size="1.524" layer="95"/>
</instance>
<instance part="GND181" gate="1" x="160.02" y="147.32" smashed="yes">
<attribute name="VALUE" x="157.48" y="144.78" size="1.778" layer="96"/>
</instance>
<instance part="U27" gate="A" x="251.46" y="152.4" smashed="yes">
<attribute name="NAME" x="272.1356" y="161.5186" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="271.5006" y="158.9786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C124" gate="G$1" x="243.84" y="152.4" smashed="yes" rot="R90">
<attribute name="NAME" x="243.459" y="153.924" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="248.539" y="153.924" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND182" gate="1" x="236.22" y="152.4" smashed="yes" rot="R270">
<attribute name="VALUE" x="233.68" y="154.94" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C125" gate="G$1" x="226.06" y="144.78" smashed="yes" rot="R180">
<attribute name="NAME" x="224.536" y="144.399" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="224.536" y="149.479" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND183" gate="1" x="226.06" y="139.7" smashed="yes">
<attribute name="VALUE" x="223.52" y="137.16" size="1.778" layer="96"/>
</instance>
<instance part="C126" gate="G$1" x="238.76" y="142.24" smashed="yes" rot="R180">
<attribute name="NAME" x="237.236" y="141.859" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="237.236" y="146.939" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND184" gate="1" x="238.76" y="137.16" smashed="yes">
<attribute name="VALUE" x="236.22" y="134.62" size="1.778" layer="96"/>
</instance>
<instance part="GND185" gate="1" x="251.46" y="142.24" smashed="yes">
<attribute name="VALUE" x="248.92" y="139.7" size="1.778" layer="96"/>
</instance>
<instance part="R43" gate="G$1" x="314.96" y="139.7" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="135.89" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="135.89" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R44" gate="G$1" x="314.96" y="129.54" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="125.73" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="125.73" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND186" gate="1" x="314.96" y="121.92" smashed="yes">
<attribute name="VALUE" x="312.42" y="119.38" size="1.778" layer="96"/>
</instance>
<instance part="C127" gate="G$1" x="330.2" y="139.7" smashed="yes" rot="R180">
<attribute name="NAME" x="328.676" y="139.319" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="328.676" y="144.399" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND187" gate="1" x="330.2" y="134.62" smashed="yes">
<attribute name="VALUE" x="327.66" y="132.08" size="1.778" layer="96"/>
</instance>
<instance part="C128" gate="G$1" x="337.82" y="144.78" smashed="yes" rot="R180">
<attribute name="NAME" x="336.296" y="144.399" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="336.296" y="149.479" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND188" gate="1" x="337.82" y="139.7" smashed="yes">
<attribute name="VALUE" x="335.28" y="137.16" size="1.778" layer="96"/>
</instance>
<instance part="GND189" gate="1" x="304.8" y="152.4" smashed="yes" rot="R90">
<attribute name="VALUE" x="307.34" y="149.86" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U28" gate="A" x="78.74" y="91.44" smashed="yes">
<attribute name="NAME" x="74.0156" y="92.9386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="68.3006" y="87.8586" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$19" gate="A" x="111.76" y="101.6" smashed="yes">
<attribute name="NAME" x="110.8456" y="104.9528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="110.8456" y="104.9528" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND190" gate="1" x="96.52" y="76.2" smashed="yes">
<attribute name="VALUE" x="93.98" y="73.66" size="1.778" layer="96"/>
</instance>
<instance part="C129" gate="G$1" x="101.6" y="93.98" smashed="yes" rot="R90">
<attribute name="NAME" x="101.219" y="95.504" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="106.299" y="95.504" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R45" gate="G$1" x="129.54" y="96.52" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="92.71" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="92.71" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R46" gate="G$1" x="129.54" y="83.82" smashed="yes" rot="R90">
<attribute name="NAME" x="128.0414" y="80.01" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="132.842" y="80.01" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND191" gate="1" x="129.54" y="76.2" smashed="yes">
<attribute name="VALUE" x="127" y="73.66" size="1.778" layer="96"/>
</instance>
<instance part="C130" gate="G$1" x="139.7" y="99.06" smashed="yes">
<attribute name="NAME" x="141.224" y="99.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="141.224" y="94.361" size="1.778" layer="96"/>
</instance>
<instance part="C131" gate="G$1" x="147.32" y="99.06" smashed="yes">
<attribute name="NAME" x="148.844" y="99.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="148.844" y="94.361" size="1.778" layer="96"/>
</instance>
<instance part="GND192" gate="1" x="139.7" y="91.44" smashed="yes">
<attribute name="VALUE" x="137.16" y="88.9" size="1.778" layer="96"/>
</instance>
<instance part="GND193" gate="1" x="147.32" y="91.44" smashed="yes">
<attribute name="VALUE" x="144.78" y="88.9" size="1.778" layer="96"/>
</instance>
<instance part="C132" gate="G$1" x="43.18" y="99.06" smashed="yes">
<attribute name="NAME" x="44.704" y="99.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="44.704" y="94.361" size="1.778" layer="96"/>
</instance>
<instance part="C133" gate="G$1" x="33.02" y="99.06" smashed="yes">
<attribute name="NAME" x="34.544" y="99.441" size="1.778" layer="95"/>
<attribute name="VALUE" x="34.544" y="94.361" size="1.778" layer="96"/>
</instance>
<instance part="GND194" gate="1" x="33.02" y="91.44" smashed="yes">
<attribute name="VALUE" x="30.48" y="88.9" size="1.778" layer="96"/>
</instance>
<instance part="GND195" gate="1" x="43.18" y="91.44" smashed="yes">
<attribute name="VALUE" x="40.64" y="88.9" size="1.778" layer="96"/>
</instance>
<instance part="X25" gate="-1" x="167.64" y="101.6" smashed="yes">
<attribute name="NAME" x="170.18" y="100.838" size="1.524" layer="95"/>
<attribute name="VALUE" x="169.418" y="102.997" size="1.778" layer="96"/>
</instance>
<instance part="X25" gate="-2" x="167.64" y="99.06" smashed="yes">
<attribute name="NAME" x="170.18" y="98.298" size="1.524" layer="95"/>
</instance>
<instance part="GND196" gate="1" x="160.02" y="96.52" smashed="yes">
<attribute name="VALUE" x="157.48" y="93.98" size="1.778" layer="96"/>
</instance>
<instance part="U29" gate="A" x="251.46" y="101.6" smashed="yes">
<attribute name="NAME" x="272.1356" y="110.7186" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="271.5006" y="108.1786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C134" gate="G$1" x="243.84" y="101.6" smashed="yes" rot="R90">
<attribute name="NAME" x="243.459" y="103.124" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="248.539" y="103.124" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND197" gate="1" x="236.22" y="101.6" smashed="yes" rot="R270">
<attribute name="VALUE" x="233.68" y="104.14" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C135" gate="G$1" x="226.06" y="93.98" smashed="yes" rot="R180">
<attribute name="NAME" x="224.536" y="93.599" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="224.536" y="98.679" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND198" gate="1" x="226.06" y="88.9" smashed="yes">
<attribute name="VALUE" x="223.52" y="86.36" size="1.778" layer="96"/>
</instance>
<instance part="C136" gate="G$1" x="238.76" y="91.44" smashed="yes" rot="R180">
<attribute name="NAME" x="237.236" y="91.059" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="237.236" y="96.139" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND199" gate="1" x="238.76" y="86.36" smashed="yes">
<attribute name="VALUE" x="236.22" y="83.82" size="1.778" layer="96"/>
</instance>
<instance part="GND200" gate="1" x="251.46" y="91.44" smashed="yes">
<attribute name="VALUE" x="248.92" y="88.9" size="1.778" layer="96"/>
</instance>
<instance part="R47" gate="G$1" x="314.96" y="88.9" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="85.09" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="85.09" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R48" gate="G$1" x="314.96" y="78.74" smashed="yes" rot="R90">
<attribute name="NAME" x="313.4614" y="74.93" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="318.262" y="74.93" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND201" gate="1" x="314.96" y="71.12" smashed="yes">
<attribute name="VALUE" x="312.42" y="68.58" size="1.778" layer="96"/>
</instance>
<instance part="C137" gate="G$1" x="330.2" y="88.9" smashed="yes" rot="R180">
<attribute name="NAME" x="328.676" y="88.519" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="328.676" y="93.599" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND202" gate="1" x="330.2" y="83.82" smashed="yes">
<attribute name="VALUE" x="327.66" y="81.28" size="1.778" layer="96"/>
</instance>
<instance part="C138" gate="G$1" x="337.82" y="93.98" smashed="yes" rot="R180">
<attribute name="NAME" x="336.296" y="93.599" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="336.296" y="98.679" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND203" gate="1" x="337.82" y="88.9" smashed="yes">
<attribute name="VALUE" x="335.28" y="86.36" size="1.778" layer="96"/>
</instance>
<instance part="GND204" gate="1" x="304.8" y="101.6" smashed="yes" rot="R90">
<attribute name="VALUE" x="307.34" y="99.06" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U30" gate="A" x="58.42" y="198.12" smashed="yes">
<attribute name="NAME" x="79.0956" y="207.2386" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="78.4606" y="204.6986" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="C139" gate="G$1" x="50.8" y="198.12" smashed="yes" rot="R90">
<attribute name="NAME" x="50.419" y="199.644" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="55.499" y="199.644" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND205" gate="1" x="43.18" y="198.12" smashed="yes" rot="R270">
<attribute name="VALUE" x="40.64" y="200.66" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C140" gate="G$1" x="33.02" y="190.5" smashed="yes" rot="R180">
<attribute name="NAME" x="31.496" y="190.119" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="31.496" y="195.199" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND206" gate="1" x="33.02" y="185.42" smashed="yes">
<attribute name="VALUE" x="30.48" y="182.88" size="1.778" layer="96"/>
</instance>
<instance part="C141" gate="G$1" x="45.72" y="187.96" smashed="yes" rot="R180">
<attribute name="NAME" x="44.196" y="187.579" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="44.196" y="192.659" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND207" gate="1" x="45.72" y="182.88" smashed="yes">
<attribute name="VALUE" x="43.18" y="180.34" size="1.778" layer="96"/>
</instance>
<instance part="GND208" gate="1" x="58.42" y="187.96" smashed="yes">
<attribute name="VALUE" x="55.88" y="185.42" size="1.778" layer="96"/>
</instance>
<instance part="R49" gate="G$1" x="121.92" y="185.42" smashed="yes" rot="R90">
<attribute name="NAME" x="120.4214" y="181.61" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="125.222" y="181.61" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R50" gate="G$1" x="121.92" y="175.26" smashed="yes" rot="R90">
<attribute name="NAME" x="120.4214" y="171.45" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="125.222" y="171.45" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND209" gate="1" x="121.92" y="167.64" smashed="yes">
<attribute name="VALUE" x="119.38" y="165.1" size="1.778" layer="96"/>
</instance>
<instance part="C142" gate="G$1" x="137.16" y="185.42" smashed="yes" rot="R180">
<attribute name="NAME" x="135.636" y="185.039" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="135.636" y="190.119" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND210" gate="1" x="137.16" y="180.34" smashed="yes">
<attribute name="VALUE" x="134.62" y="177.8" size="1.778" layer="96"/>
</instance>
<instance part="C143" gate="G$1" x="144.78" y="190.5" smashed="yes" rot="R180">
<attribute name="NAME" x="143.256" y="190.119" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="143.256" y="195.199" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND211" gate="1" x="144.78" y="185.42" smashed="yes">
<attribute name="VALUE" x="142.24" y="182.88" size="1.778" layer="96"/>
</instance>
<instance part="GND212" gate="1" x="111.76" y="198.12" smashed="yes" rot="R90">
<attribute name="VALUE" x="114.3" y="195.58" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U31" gate="A" x="436.88" y="254" smashed="yes">
<attribute name="NAME" x="432.1556" y="255.4986" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="426.4406" y="250.4186" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="U$20" gate="A" x="469.9" y="264.16" smashed="yes">
<attribute name="NAME" x="468.9856" y="267.5128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
<attribute name="NAME" x="468.9856" y="267.5128" size="3.4798" layer="95" ratio="10" rot="SR0"/>
</instance>
<instance part="GND213" gate="1" x="454.66" y="238.76" smashed="yes">
<attribute name="VALUE" x="452.12" y="236.22" size="1.778" layer="96"/>
</instance>
<instance part="C144" gate="G$1" x="459.74" y="256.54" smashed="yes" rot="R90">
<attribute name="NAME" x="459.359" y="258.064" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="464.439" y="258.064" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R51" gate="G$1" x="487.68" y="259.08" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="255.27" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="255.27" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R52" gate="G$1" x="487.68" y="246.38" smashed="yes" rot="R90">
<attribute name="NAME" x="486.1814" y="242.57" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="490.982" y="242.57" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND214" gate="1" x="487.68" y="238.76" smashed="yes">
<attribute name="VALUE" x="485.14" y="236.22" size="1.778" layer="96"/>
</instance>
<instance part="C145" gate="G$1" x="497.84" y="261.62" smashed="yes">
<attribute name="NAME" x="499.364" y="262.001" size="1.778" layer="95"/>
<attribute name="VALUE" x="499.364" y="256.921" size="1.778" layer="96"/>
</instance>
<instance part="C146" gate="G$1" x="505.46" y="261.62" smashed="yes">
<attribute name="NAME" x="506.984" y="262.001" size="1.778" layer="95"/>
<attribute name="VALUE" x="506.984" y="256.921" size="1.778" layer="96"/>
</instance>
<instance part="GND215" gate="1" x="497.84" y="254" smashed="yes">
<attribute name="VALUE" x="495.3" y="251.46" size="1.778" layer="96"/>
</instance>
<instance part="GND216" gate="1" x="505.46" y="254" smashed="yes">
<attribute name="VALUE" x="502.92" y="251.46" size="1.778" layer="96"/>
</instance>
<instance part="C147" gate="G$1" x="401.32" y="261.62" smashed="yes">
<attribute name="NAME" x="402.844" y="262.001" size="1.778" layer="95"/>
<attribute name="VALUE" x="402.844" y="256.921" size="1.778" layer="96"/>
</instance>
<instance part="C148" gate="G$1" x="391.16" y="261.62" smashed="yes">
<attribute name="NAME" x="392.684" y="262.001" size="1.778" layer="95"/>
<attribute name="VALUE" x="392.684" y="256.921" size="1.778" layer="96"/>
</instance>
<instance part="GND217" gate="1" x="391.16" y="254" smashed="yes">
<attribute name="VALUE" x="388.62" y="251.46" size="1.778" layer="96"/>
</instance>
<instance part="GND218" gate="1" x="401.32" y="254" smashed="yes">
<attribute name="VALUE" x="398.78" y="251.46" size="1.778" layer="96"/>
</instance>
<instance part="X26" gate="-1" x="525.78" y="264.16" smashed="yes">
<attribute name="NAME" x="528.32" y="263.398" size="1.524" layer="95"/>
<attribute name="VALUE" x="527.558" y="265.557" size="1.778" layer="96"/>
</instance>
<instance part="X26" gate="-2" x="525.78" y="261.62" smashed="yes">
<attribute name="NAME" x="528.32" y="260.858" size="1.524" layer="95"/>
</instance>
<instance part="GND219" gate="1" x="518.16" y="259.08" smashed="yes">
<attribute name="VALUE" x="515.62" y="256.54" size="1.778" layer="96"/>
</instance>
<instance part="U32" gate="A" x="589.28" y="266.7" smashed="yes">
<attribute name="NAME" x="607.4156" y="275.8186" size="2.0828" layer="95" ratio="6" rot="SR0"/>
<attribute name="VALUE" x="606.7806" y="273.2786" size="2.0828" layer="96" ratio="6" rot="SR0"/>
</instance>
<instance part="GND220" gate="1" x="637.54" y="266.7" smashed="yes" rot="R90">
<attribute name="VALUE" x="640.08" y="264.16" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND221" gate="1" x="637.54" y="259.08" smashed="yes" rot="R90">
<attribute name="VALUE" x="640.08" y="256.54" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND222" gate="1" x="586.74" y="248.92" smashed="yes" rot="R270">
<attribute name="VALUE" x="584.2" y="251.46" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="C149" gate="G$1" x="563.88" y="264.16" smashed="yes">
<attribute name="NAME" x="565.404" y="264.541" size="1.778" layer="95"/>
<attribute name="VALUE" x="565.404" y="259.461" size="1.778" layer="96"/>
</instance>
<instance part="GND223" gate="1" x="563.88" y="256.54" smashed="yes">
<attribute name="VALUE" x="561.34" y="254" size="1.778" layer="96"/>
</instance>
<instance part="C150" gate="G$1" x="579.12" y="261.62" smashed="yes">
<attribute name="NAME" x="580.644" y="262.001" size="1.778" layer="95"/>
<attribute name="VALUE" x="580.644" y="256.921" size="1.778" layer="96"/>
</instance>
<instance part="R53" gate="G$1" x="574.04" y="261.62" smashed="yes" rot="R90">
<attribute name="NAME" x="572.5414" y="257.81" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="577.342" y="257.81" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R54" gate="G$1" x="574.04" y="251.46" smashed="yes" rot="R90">
<attribute name="NAME" x="572.5414" y="247.65" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="577.342" y="247.65" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND224" gate="1" x="574.04" y="243.84" smashed="yes">
<attribute name="VALUE" x="571.5" y="241.3" size="1.778" layer="96"/>
</instance>
<instance part="C151" gate="G$1" x="640.08" y="241.3" smashed="yes">
<attribute name="NAME" x="641.604" y="241.681" size="1.778" layer="95"/>
<attribute name="VALUE" x="641.604" y="236.601" size="1.778" layer="96"/>
</instance>
<instance part="GND225" gate="1" x="640.08" y="233.68" smashed="yes">
<attribute name="VALUE" x="637.54" y="231.14" size="1.778" layer="96"/>
</instance>
<instance part="C152" gate="G$1" x="650.24" y="243.84" smashed="yes">
<attribute name="NAME" x="651.764" y="244.221" size="1.778" layer="95"/>
<attribute name="VALUE" x="651.764" y="239.141" size="1.778" layer="96"/>
</instance>
<instance part="GND226" gate="1" x="650.24" y="236.22" smashed="yes">
<attribute name="VALUE" x="647.7" y="233.68" size="1.778" layer="96"/>
</instance>
<instance part="C153" gate="G$1" x="662.94" y="254" smashed="yes">
<attribute name="NAME" x="664.464" y="254.381" size="1.778" layer="95"/>
<attribute name="VALUE" x="664.464" y="249.301" size="1.778" layer="96"/>
</instance>
<instance part="GND227" gate="1" x="662.94" y="246.38" smashed="yes">
<attribute name="VALUE" x="660.4" y="243.84" size="1.778" layer="96"/>
</instance>
<instance part="U33" gate="A" x="797.56" y="167.64" smashed="yes" rot="R90">
<attribute name="NAME" x="796.0614" y="162.9156" size="2.0828" layer="95" ratio="6" rot="SR90"/>
<attribute name="VALUE" x="801.1414" y="157.2006" size="2.0828" layer="96" ratio="6" rot="SR90"/>
</instance>
<instance part="U$21" gate="A" x="787.4" y="200.66" smashed="yes" rot="R90">
<attribute name="NAME" x="784.0472" y="199.7456" size="3.4798" layer="95" ratio="10" rot="SR90"/>
<attribute name="NAME" x="784.0472" y="199.7456" size="3.4798" layer="95" ratio="10" rot="SR90"/>
</instance>
<instance part="GND228" gate="1" x="812.8" y="185.42" smashed="yes" rot="R90">
<attribute name="VALUE" x="815.34" y="182.88" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C154" gate="G$1" x="795.02" y="190.5" smashed="yes" rot="R180">
<attribute name="NAME" x="793.496" y="190.119" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="793.496" y="195.199" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="R55" gate="G$1" x="792.48" y="218.44" smashed="yes" rot="R180">
<attribute name="NAME" x="796.29" y="216.9414" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="796.29" y="221.742" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="R56" gate="G$1" x="805.18" y="218.44" smashed="yes" rot="R180">
<attribute name="NAME" x="808.99" y="216.9414" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="808.99" y="221.742" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND229" gate="1" x="812.8" y="218.44" smashed="yes" rot="R90">
<attribute name="VALUE" x="815.34" y="215.9" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C155" gate="G$1" x="789.94" y="228.6" smashed="yes" rot="R90">
<attribute name="NAME" x="789.559" y="230.124" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="794.639" y="230.124" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C156" gate="G$1" x="789.94" y="236.22" smashed="yes" rot="R90">
<attribute name="NAME" x="789.559" y="237.744" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="794.639" y="237.744" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND230" gate="1" x="797.56" y="228.6" smashed="yes" rot="R90">
<attribute name="VALUE" x="800.1" y="226.06" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND231" gate="1" x="797.56" y="236.22" smashed="yes" rot="R90">
<attribute name="VALUE" x="800.1" y="233.68" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C157" gate="G$1" x="789.94" y="132.08" smashed="yes" rot="R90">
<attribute name="NAME" x="789.559" y="133.604" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="794.639" y="133.604" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C158" gate="G$1" x="789.94" y="121.92" smashed="yes" rot="R90">
<attribute name="NAME" x="789.559" y="123.444" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="794.639" y="123.444" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND232" gate="1" x="797.56" y="121.92" smashed="yes" rot="R90">
<attribute name="VALUE" x="800.1" y="119.38" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND233" gate="1" x="797.56" y="132.08" smashed="yes" rot="R90">
<attribute name="VALUE" x="800.1" y="129.54" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="X28" gate="-1" x="787.4" y="256.54" smashed="yes" rot="R90">
<attribute name="NAME" x="788.162" y="259.08" size="1.524" layer="95" rot="R90"/>
<attribute name="VALUE" x="786.003" y="258.318" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="X28" gate="-2" x="789.94" y="256.54" smashed="yes" rot="R90">
<attribute name="NAME" x="790.702" y="259.08" size="1.524" layer="95" rot="R90"/>
</instance>
<instance part="GND234" gate="1" x="792.48" y="248.92" smashed="yes" rot="R90">
<attribute name="VALUE" x="795.02" y="246.38" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="U34" gate="A" x="784.86" y="320.04" smashed="yes" rot="R90">
<attribute name="NAME" x="775.7414" y="338.1756" size="2.0828" layer="95" ratio="6" rot="SR90"/>
<attribute name="VALUE" x="778.2814" y="337.5406" size="2.0828" layer="96" ratio="6" rot="SR90"/>
</instance>
<instance part="GND235" gate="1" x="784.86" y="368.3" smashed="yes" rot="R180">
<attribute name="VALUE" x="787.4" y="370.84" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND236" gate="1" x="792.48" y="368.3" smashed="yes" rot="R180">
<attribute name="VALUE" x="795.02" y="370.84" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND237" gate="1" x="802.64" y="317.5" smashed="yes">
<attribute name="VALUE" x="800.1" y="314.96" size="1.778" layer="96"/>
</instance>
<instance part="C159" gate="G$1" x="787.4" y="294.64" smashed="yes" rot="R90">
<attribute name="NAME" x="787.019" y="296.164" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="792.099" y="296.164" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND238" gate="1" x="795.02" y="294.64" smashed="yes" rot="R90">
<attribute name="VALUE" x="797.56" y="292.1" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C160" gate="G$1" x="789.94" y="309.88" smashed="yes" rot="R90">
<attribute name="NAME" x="789.559" y="311.404" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="794.639" y="311.404" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="R57" gate="G$1" x="789.94" y="304.8" smashed="yes" rot="R180">
<attribute name="NAME" x="793.75" y="303.3014" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="793.75" y="308.102" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="R58" gate="G$1" x="800.1" y="304.8" smashed="yes" rot="R180">
<attribute name="NAME" x="803.91" y="303.3014" size="1.778" layer="95" rot="R180"/>
<attribute name="VALUE" x="803.91" y="308.102" size="1.778" layer="96" rot="R180"/>
</instance>
<instance part="GND239" gate="1" x="807.72" y="304.8" smashed="yes" rot="R90">
<attribute name="VALUE" x="810.26" y="302.26" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C161" gate="G$1" x="810.26" y="370.84" smashed="yes" rot="R90">
<attribute name="NAME" x="809.879" y="372.364" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="814.959" y="372.364" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND240" gate="1" x="817.88" y="370.84" smashed="yes" rot="R90">
<attribute name="VALUE" x="820.42" y="368.3" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C162" gate="G$1" x="807.72" y="381" smashed="yes" rot="R90">
<attribute name="NAME" x="807.339" y="382.524" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="812.419" y="382.524" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND241" gate="1" x="815.34" y="381" smashed="yes" rot="R90">
<attribute name="VALUE" x="817.88" y="378.46" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="C163" gate="G$1" x="797.56" y="393.7" smashed="yes" rot="R90">
<attribute name="NAME" x="797.179" y="395.224" size="1.778" layer="95" rot="R90"/>
<attribute name="VALUE" x="802.259" y="395.224" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="GND242" gate="1" x="805.18" y="393.7" smashed="yes" rot="R90">
<attribute name="VALUE" x="807.72" y="391.16" size="1.778" layer="96" rot="R90"/>
</instance>
<instance part="X4" gate="-1" x="177.8" y="482.6" smashed="yes">
<attribute name="NAME" x="180.34" y="481.838" size="1.524" layer="95"/>
<attribute name="VALUE" x="177.038" y="483.997" size="1.778" layer="96"/>
</instance>
<instance part="X4" gate="-2" x="177.8" y="480.06" smashed="yes">
<attribute name="NAME" x="180.34" y="479.298" size="1.524" layer="95"/>
</instance>
<instance part="GND138" gate="1" x="175.26" y="477.52" smashed="yes">
<attribute name="VALUE" x="172.72" y="474.98" size="1.778" layer="96"/>
</instance>
<instance part="X5" gate="-1" x="180.34" y="439.42" smashed="yes">
<attribute name="NAME" x="182.88" y="438.658" size="1.524" layer="95"/>
<attribute name="VALUE" x="179.578" y="440.817" size="1.778" layer="96"/>
</instance>
<instance part="X5" gate="-2" x="180.34" y="436.88" smashed="yes">
<attribute name="NAME" x="182.88" y="436.118" size="1.524" layer="95"/>
</instance>
<instance part="GND139" gate="1" x="177.8" y="434.34" smashed="yes">
<attribute name="VALUE" x="175.26" y="431.8" size="1.778" layer="96"/>
</instance>
<instance part="X6" gate="-1" x="20.32" y="195.58" smashed="yes" rot="MR0">
<attribute name="NAME" x="17.78" y="194.818" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="21.082" y="196.977" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X6" gate="-2" x="20.32" y="193.04" smashed="yes" rot="MR0">
<attribute name="NAME" x="17.78" y="192.278" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND140" gate="1" x="22.86" y="190.5" smashed="yes" rot="MR0">
<attribute name="VALUE" x="25.4" y="187.96" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X7" gate="-1" x="198.12" y="99.06" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="98.298" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="198.882" y="100.457" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X7" gate="-2" x="198.12" y="96.52" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="95.758" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND141" gate="1" x="200.66" y="93.98" smashed="yes" rot="MR0">
<attribute name="VALUE" x="203.2" y="91.44" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X8" gate="-1" x="198.12" y="149.86" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="149.098" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="198.882" y="151.257" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X8" gate="-2" x="198.12" y="147.32" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="146.558" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND142" gate="1" x="200.66" y="144.78" smashed="yes" rot="MR0">
<attribute name="VALUE" x="203.2" y="142.24" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X10" gate="-1" x="198.12" y="248.92" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="248.158" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="198.882" y="250.317" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X10" gate="-2" x="198.12" y="246.38" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="245.618" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND144" gate="1" x="200.66" y="243.84" smashed="yes" rot="MR0">
<attribute name="VALUE" x="203.2" y="241.3" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X11" gate="-1" x="198.12" y="299.72" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="298.958" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="198.882" y="301.117" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X11" gate="-2" x="198.12" y="297.18" smashed="yes" rot="MR0">
<attribute name="NAME" x="195.58" y="296.418" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND145" gate="1" x="200.66" y="294.64" smashed="yes" rot="MR0">
<attribute name="VALUE" x="203.2" y="292.1" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X12" gate="-1" x="195.58" y="347.98" smashed="yes" rot="MR0">
<attribute name="NAME" x="193.04" y="347.218" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="196.342" y="349.377" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X12" gate="-2" x="195.58" y="345.44" smashed="yes" rot="MR0">
<attribute name="NAME" x="193.04" y="344.678" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND146" gate="1" x="198.12" y="342.9" smashed="yes" rot="MR0">
<attribute name="VALUE" x="200.66" y="340.36" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X3" gate="-1" x="530.86" y="523.24" smashed="yes">
<attribute name="NAME" x="533.4" y="522.478" size="1.524" layer="95"/>
<attribute name="VALUE" x="530.098" y="524.637" size="1.778" layer="96"/>
</instance>
<instance part="X3" gate="-2" x="530.86" y="520.7" smashed="yes">
<attribute name="NAME" x="533.4" y="519.938" size="1.524" layer="95"/>
</instance>
<instance part="GND128" gate="1" x="528.32" y="518.16" smashed="yes">
<attribute name="VALUE" x="525.78" y="515.62" size="1.778" layer="96"/>
</instance>
<instance part="X13" gate="-1" x="533.4" y="416.56" smashed="yes">
<attribute name="NAME" x="535.94" y="415.798" size="1.524" layer="95"/>
<attribute name="VALUE" x="532.638" y="417.957" size="1.778" layer="96"/>
</instance>
<instance part="X13" gate="-2" x="533.4" y="414.02" smashed="yes">
<attribute name="NAME" x="535.94" y="413.258" size="1.524" layer="95"/>
</instance>
<instance part="GND147" gate="1" x="530.86" y="411.48" smashed="yes">
<attribute name="VALUE" x="528.32" y="408.94" size="1.778" layer="96"/>
</instance>
<instance part="X14" gate="-1" x="543.56" y="363.22" smashed="yes">
<attribute name="NAME" x="546.1" y="362.458" size="1.524" layer="95"/>
<attribute name="VALUE" x="542.798" y="364.617" size="1.778" layer="96"/>
</instance>
<instance part="X14" gate="-2" x="543.56" y="360.68" smashed="yes">
<attribute name="NAME" x="546.1" y="359.918" size="1.524" layer="95"/>
</instance>
<instance part="GND148" gate="1" x="541.02" y="358.14" smashed="yes">
<attribute name="VALUE" x="538.48" y="355.6" size="1.778" layer="96"/>
</instance>
<instance part="X15" gate="-1" x="546.1" y="317.5" smashed="yes">
<attribute name="NAME" x="548.64" y="316.738" size="1.524" layer="95"/>
<attribute name="VALUE" x="545.338" y="318.897" size="1.778" layer="96"/>
</instance>
<instance part="X15" gate="-2" x="546.1" y="314.96" smashed="yes">
<attribute name="NAME" x="548.64" y="314.198" size="1.524" layer="95"/>
</instance>
<instance part="GND149" gate="1" x="543.56" y="312.42" smashed="yes">
<attribute name="VALUE" x="541.02" y="309.88" size="1.778" layer="96"/>
</instance>
<instance part="X29" gate="-1" x="538.48" y="213.36" smashed="yes">
<attribute name="NAME" x="541.02" y="212.598" size="1.524" layer="95"/>
<attribute name="VALUE" x="537.718" y="214.757" size="1.778" layer="96"/>
</instance>
<instance part="X29" gate="-2" x="538.48" y="210.82" smashed="yes">
<attribute name="NAME" x="541.02" y="210.058" size="1.524" layer="95"/>
</instance>
<instance part="GND243" gate="1" x="535.94" y="208.28" smashed="yes">
<attribute name="VALUE" x="533.4" y="205.74" size="1.778" layer="96"/>
</instance>
<instance part="X30" gate="-1" x="546.1" y="165.1" smashed="yes">
<attribute name="NAME" x="548.64" y="164.338" size="1.524" layer="95"/>
<attribute name="VALUE" x="545.338" y="166.497" size="1.778" layer="96"/>
</instance>
<instance part="X30" gate="-2" x="546.1" y="162.56" smashed="yes">
<attribute name="NAME" x="548.64" y="161.798" size="1.524" layer="95"/>
</instance>
<instance part="GND244" gate="1" x="543.56" y="160.02" smashed="yes">
<attribute name="VALUE" x="541.02" y="157.48" size="1.778" layer="96"/>
</instance>
<instance part="X31" gate="-1" x="535.94" y="121.92" smashed="yes">
<attribute name="NAME" x="538.48" y="121.158" size="1.524" layer="95"/>
<attribute name="VALUE" x="535.178" y="123.317" size="1.778" layer="96"/>
</instance>
<instance part="X31" gate="-2" x="535.94" y="119.38" smashed="yes">
<attribute name="NAME" x="538.48" y="118.618" size="1.524" layer="95"/>
</instance>
<instance part="GND245" gate="1" x="533.4" y="116.84" smashed="yes">
<attribute name="VALUE" x="530.86" y="114.3" size="1.778" layer="96"/>
</instance>
<instance part="X32" gate="-1" x="538.48" y="78.74" smashed="yes">
<attribute name="NAME" x="541.02" y="77.978" size="1.524" layer="95"/>
<attribute name="VALUE" x="537.718" y="80.137" size="1.778" layer="96"/>
</instance>
<instance part="X32" gate="-2" x="538.48" y="76.2" smashed="yes">
<attribute name="NAME" x="541.02" y="75.438" size="1.524" layer="95"/>
</instance>
<instance part="GND246" gate="1" x="535.94" y="73.66" smashed="yes">
<attribute name="VALUE" x="533.4" y="71.12" size="1.778" layer="96"/>
</instance>
<instance part="X33" gate="-1" x="541.02" y="35.56" smashed="yes">
<attribute name="NAME" x="543.56" y="34.798" size="1.524" layer="95"/>
<attribute name="VALUE" x="540.258" y="36.957" size="1.778" layer="96"/>
</instance>
<instance part="X33" gate="-2" x="541.02" y="33.02" smashed="yes">
<attribute name="NAME" x="543.56" y="32.258" size="1.524" layer="95"/>
</instance>
<instance part="GND247" gate="1" x="538.48" y="30.48" smashed="yes">
<attribute name="VALUE" x="535.94" y="27.94" size="1.778" layer="96"/>
</instance>
<instance part="X34" gate="-1" x="551.18" y="256.54" smashed="yes" rot="MR0">
<attribute name="NAME" x="548.64" y="255.778" size="1.524" layer="95" rot="MR0"/>
<attribute name="VALUE" x="551.942" y="257.937" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X34" gate="-2" x="551.18" y="254" smashed="yes" rot="MR0">
<attribute name="NAME" x="548.64" y="253.238" size="1.524" layer="95" rot="MR0"/>
</instance>
<instance part="GND248" gate="1" x="553.72" y="251.46" smashed="yes" rot="MR0">
<attribute name="VALUE" x="556.26" y="248.92" size="1.778" layer="96" rot="MR0"/>
</instance>
<instance part="X35" gate="-1" x="800.1" y="279.4" smashed="yes" rot="R270">
<attribute name="NAME" x="799.338" y="276.86" size="1.524" layer="95" rot="R270"/>
<attribute name="VALUE" x="801.497" y="280.162" size="1.778" layer="96" rot="R270"/>
</instance>
<instance part="X35" gate="-2" x="797.56" y="279.4" smashed="yes" rot="R270">
<attribute name="NAME" x="796.798" y="276.86" size="1.524" layer="95" rot="R270"/>
</instance>
<instance part="GND249" gate="1" x="795.02" y="281.94" smashed="yes" rot="R270">
<attribute name="VALUE" x="792.48" y="284.48" size="1.778" layer="96" rot="R270"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="0">
<segment>
<pinref part="U1" gate="A" pin="GND"/>
<pinref part="GND1" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R2" gate="G$1" pin="1"/>
<pinref part="GND2" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C2" gate="G$1" pin="2"/>
<pinref part="GND3" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C3" gate="G$1" pin="2"/>
<pinref part="GND4" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C5" gate="G$1" pin="2"/>
<pinref part="GND5" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C4" gate="G$1" pin="2"/>
<pinref part="GND6" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U2" gate="A" pin="GND"/>
<pinref part="GND7" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R4" gate="G$1" pin="1"/>
<pinref part="GND8" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C7" gate="G$1" pin="2"/>
<pinref part="GND9" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C8" gate="G$1" pin="2"/>
<pinref part="GND10" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C10" gate="G$1" pin="2"/>
<pinref part="GND11" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C9" gate="G$1" pin="2"/>
<pinref part="GND12" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C11" gate="G$1" pin="2"/>
<pinref part="GND13" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U3" gate="A" pin="GND"/>
<pinref part="GND14" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R6" gate="G$1" pin="1"/>
<pinref part="GND15" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C13" gate="G$1" pin="2"/>
<pinref part="GND16" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C14" gate="G$1" pin="2"/>
<pinref part="GND17" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C16" gate="G$1" pin="2"/>
<pinref part="GND18" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C15" gate="G$1" pin="2"/>
<pinref part="GND19" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C17" gate="G$1" pin="2"/>
<pinref part="GND20" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U4" gate="A" pin="GND"/>
<pinref part="GND21" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R8" gate="G$1" pin="1"/>
<pinref part="GND22" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C19" gate="G$1" pin="2"/>
<pinref part="GND23" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C20" gate="G$1" pin="2"/>
<pinref part="GND24" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C22" gate="G$1" pin="2"/>
<pinref part="GND25" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C21" gate="G$1" pin="2"/>
<pinref part="GND26" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C23" gate="G$1" pin="2"/>
<pinref part="GND27" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U6" gate="A" pin="GND"/>
<pinref part="GND35" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R12" gate="G$1" pin="1"/>
<pinref part="GND36" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C31" gate="G$1" pin="2"/>
<pinref part="GND37" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C32" gate="G$1" pin="2"/>
<pinref part="GND38" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C34" gate="G$1" pin="2"/>
<pinref part="GND39" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C33" gate="G$1" pin="2"/>
<pinref part="GND40" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C35" gate="G$1" pin="2"/>
<pinref part="GND41" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U7" gate="A" pin="GND"/>
<pinref part="GND42" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R14" gate="G$1" pin="1"/>
<pinref part="GND43" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C37" gate="G$1" pin="2"/>
<pinref part="GND44" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C38" gate="G$1" pin="2"/>
<pinref part="GND45" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C40" gate="G$1" pin="2"/>
<pinref part="GND46" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C39" gate="G$1" pin="2"/>
<pinref part="GND47" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C41" gate="G$1" pin="2"/>
<pinref part="GND48" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U8" gate="A" pin="GND"/>
<pinref part="GND49" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R16" gate="G$1" pin="1"/>
<pinref part="GND50" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C43" gate="G$1" pin="2"/>
<pinref part="GND51" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C44" gate="G$1" pin="2"/>
<pinref part="GND52" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C46" gate="G$1" pin="2"/>
<pinref part="GND53" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C45" gate="G$1" pin="2"/>
<pinref part="GND54" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C47" gate="G$1" pin="2"/>
<pinref part="GND55" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U10" gate="A" pin="GND"/>
<pinref part="GND63" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R20" gate="G$1" pin="1"/>
<pinref part="GND64" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C55" gate="G$1" pin="2"/>
<pinref part="GND65" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C56" gate="G$1" pin="2"/>
<pinref part="GND66" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C58" gate="G$1" pin="2"/>
<pinref part="GND67" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C57" gate="G$1" pin="2"/>
<pinref part="GND68" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C59" gate="G$1" pin="2"/>
<pinref part="GND69" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U11" gate="A" pin="GND"/>
<pinref part="GND70" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R22" gate="G$1" pin="1"/>
<pinref part="GND71" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C61" gate="G$1" pin="2"/>
<pinref part="GND72" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C62" gate="G$1" pin="2"/>
<pinref part="GND73" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C64" gate="G$1" pin="2"/>
<pinref part="GND74" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C63" gate="G$1" pin="2"/>
<pinref part="GND75" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C65" gate="G$1" pin="2"/>
<pinref part="GND76" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U12" gate="A" pin="GND"/>
<pinref part="GND77" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R24" gate="G$1" pin="1"/>
<pinref part="GND78" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C67" gate="G$1" pin="2"/>
<pinref part="GND79" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C68" gate="G$1" pin="2"/>
<pinref part="GND80" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C70" gate="G$1" pin="2"/>
<pinref part="GND81" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C69" gate="G$1" pin="2"/>
<pinref part="GND82" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U13" gate="A" pin="GND"/>
<pinref part="GND83" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R26" gate="G$1" pin="1"/>
<pinref part="GND84" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C72" gate="G$1" pin="2"/>
<pinref part="GND85" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C73" gate="G$1" pin="2"/>
<pinref part="GND86" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C75" gate="G$1" pin="2"/>
<pinref part="GND87" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C74" gate="G$1" pin="2"/>
<pinref part="GND88" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U14" gate="A" pin="GND"/>
<pinref part="GND90" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R28" gate="G$1" pin="1"/>
<pinref part="GND91" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C78" gate="G$1" pin="2"/>
<pinref part="GND92" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C79" gate="G$1" pin="2"/>
<pinref part="GND93" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C81" gate="G$1" pin="2"/>
<pinref part="GND94" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C80" gate="G$1" pin="2"/>
<pinref part="GND95" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U15" gate="A" pin="GND"/>
<pinref part="GND97" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R30" gate="G$1" pin="1"/>
<pinref part="GND98" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C84" gate="G$1" pin="2"/>
<pinref part="GND99" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C85" gate="G$1" pin="2"/>
<pinref part="GND100" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C87" gate="G$1" pin="2"/>
<pinref part="GND101" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C86" gate="G$1" pin="2"/>
<pinref part="GND102" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U16" gate="A" pin="GND"/>
<pinref part="GND104" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R32" gate="G$1" pin="1"/>
<pinref part="GND105" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C90" gate="G$1" pin="2"/>
<pinref part="GND106" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C91" gate="G$1" pin="2"/>
<pinref part="GND107" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C93" gate="G$1" pin="2"/>
<pinref part="GND108" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C92" gate="G$1" pin="2"/>
<pinref part="GND109" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U17" gate="A" pin="GND"/>
<pinref part="GND89" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R34" gate="G$1" pin="1"/>
<pinref part="GND96" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C82" gate="G$1" pin="2"/>
<pinref part="GND103" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C88" gate="G$1" pin="2"/>
<pinref part="GND110" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C95" gate="G$1" pin="2"/>
<pinref part="GND111" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C94" gate="G$1" pin="2"/>
<pinref part="GND112" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C97" gate="G$1" pin="+"/>
<pinref part="GND113" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U18" gate="A" pin="LV"/>
<pinref part="GND114" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U18" gate="A" pin="GND"/>
<pinref part="GND115" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C99" gate="G$1" pin="+"/>
<pinref part="GND116" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U19" gate="A" pin="LV"/>
<pinref part="GND117" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U19" gate="A" pin="GND"/>
<pinref part="GND118" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C101" gate="G$1" pin="+"/>
<pinref part="GND119" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U20" gate="A" pin="LV"/>
<pinref part="GND120" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U20" gate="A" pin="GND"/>
<pinref part="GND121" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C103" gate="G$1" pin="+"/>
<pinref part="GND122" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U21" gate="A" pin="LV"/>
<pinref part="GND123" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U21" gate="A" pin="GND"/>
<pinref part="GND124" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C105" gate="G$1" pin="+"/>
<pinref part="GND125" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U22" gate="A" pin="LV"/>
<pinref part="GND126" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U22" gate="A" pin="GND"/>
<pinref part="GND127" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X16" gate="-2" pin="S"/>
<pinref part="GND129" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X18" gate="-2" pin="S"/>
<pinref part="GND131" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X19" gate="-2" pin="S"/>
<pinref part="GND132" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X20" gate="-2" pin="S"/>
<pinref part="GND133" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X21" gate="-2" pin="S"/>
<pinref part="GND134" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X22" gate="-2" pin="S"/>
<pinref part="GND135" gate="1" pin="GND"/>
<wire x1="160.02" y1="347.98" x2="165.1" y2="347.98" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="X23" gate="-2" pin="S"/>
<pinref part="GND136" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X24" gate="-2" pin="S"/>
<pinref part="GND137" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X1" gate="-2" pin="KL"/>
<pinref part="GND150" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="20"/>
<wire x1="279.4" y1="444.5" x2="279.4" y2="441.96" width="0.1524" layer="91"/>
<pinref part="GND167" gate="1" pin="GND"/>
<pinref part="SV1" gate="G$1" pin="12"/>
<wire x1="289.56" y1="444.5" x2="289.56" y2="441.96" width="0.1524" layer="91"/>
<wire x1="289.56" y1="441.96" x2="287.02" y2="441.96" width="0.1524" layer="91"/>
<junction x="279.4" y="441.96"/>
<pinref part="SV1" gate="G$1" pin="18"/>
<wire x1="287.02" y1="441.96" x2="284.48" y2="441.96" width="0.1524" layer="91"/>
<wire x1="284.48" y1="441.96" x2="281.94" y2="441.96" width="0.1524" layer="91"/>
<wire x1="281.94" y1="441.96" x2="279.4" y2="441.96" width="0.1524" layer="91"/>
<wire x1="281.94" y1="444.5" x2="281.94" y2="441.96" width="0.1524" layer="91"/>
<junction x="281.94" y="441.96"/>
<pinref part="SV1" gate="G$1" pin="16"/>
<wire x1="284.48" y1="444.5" x2="284.48" y2="441.96" width="0.1524" layer="91"/>
<junction x="284.48" y="441.96"/>
<pinref part="SV1" gate="G$1" pin="14"/>
<wire x1="287.02" y1="444.5" x2="287.02" y2="441.96" width="0.1524" layer="91"/>
<junction x="287.02" y="441.96"/>
<junction x="289.56" y="441.96"/>
</segment>
<segment>
<pinref part="X27" gate="-2" pin="S"/>
<pinref part="GND169" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C24" gate="G$1" pin="1"/>
<pinref part="GND28" gate="1" pin="GND"/>
<wire x1="241.3" y1="350.52" x2="238.76" y2="350.52" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C25" gate="G$1" pin="1"/>
<pinref part="GND29" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C26" gate="G$1" pin="1"/>
<pinref part="GND30" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U5" gate="A" pin="GND"/>
<pinref part="GND31" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R10" gate="G$1" pin="1"/>
<pinref part="GND32" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C27" gate="G$1" pin="1"/>
<pinref part="GND33" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C28" gate="G$1" pin="1"/>
<pinref part="GND34" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U5" gate="A" pin="EPAD"/>
<pinref part="GND56" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U9" gate="A" pin="GND"/>
<pinref part="GND57" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R18" gate="G$1" pin="1"/>
<pinref part="GND58" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C48" gate="G$1" pin="2"/>
<pinref part="GND59" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C49" gate="G$1" pin="2"/>
<pinref part="GND60" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C51" gate="G$1" pin="2"/>
<pinref part="GND61" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C50" gate="G$1" pin="2"/>
<pinref part="GND62" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X2" gate="-2" pin="S"/>
<pinref part="GND130" gate="1" pin="GND"/>
<wire x1="160.02" y1="299.72" x2="165.1" y2="299.72" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C52" gate="G$1" pin="1"/>
<pinref part="GND143" gate="1" pin="GND"/>
<wire x1="241.3" y1="302.26" x2="238.76" y2="302.26" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C53" gate="G$1" pin="1"/>
<pinref part="GND151" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C106" gate="G$1" pin="1"/>
<pinref part="GND152" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U23" gate="A" pin="GND"/>
<pinref part="GND153" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R36" gate="G$1" pin="1"/>
<pinref part="GND154" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C107" gate="G$1" pin="1"/>
<pinref part="GND155" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C108" gate="G$1" pin="1"/>
<pinref part="GND156" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U23" gate="A" pin="EPAD"/>
<pinref part="GND157" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U24" gate="A" pin="GND"/>
<pinref part="GND158" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R38" gate="G$1" pin="1"/>
<pinref part="GND159" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C110" gate="G$1" pin="2"/>
<pinref part="GND160" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C111" gate="G$1" pin="2"/>
<pinref part="GND161" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C113" gate="G$1" pin="2"/>
<pinref part="GND162" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C112" gate="G$1" pin="2"/>
<pinref part="GND163" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X9" gate="-2" pin="S"/>
<pinref part="GND164" gate="1" pin="GND"/>
<wire x1="160.02" y1="248.92" x2="165.1" y2="248.92" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C114" gate="G$1" pin="1"/>
<pinref part="GND165" gate="1" pin="GND"/>
<wire x1="241.3" y1="251.46" x2="238.76" y2="251.46" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C115" gate="G$1" pin="1"/>
<pinref part="GND166" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C116" gate="G$1" pin="1"/>
<pinref part="GND168" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U25" gate="A" pin="GND"/>
<pinref part="GND170" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R40" gate="G$1" pin="1"/>
<pinref part="GND171" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C117" gate="G$1" pin="1"/>
<pinref part="GND172" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C118" gate="G$1" pin="1"/>
<pinref part="GND173" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U25" gate="A" pin="EPAD"/>
<pinref part="GND174" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U26" gate="A" pin="GND"/>
<pinref part="GND175" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R42" gate="G$1" pin="1"/>
<pinref part="GND176" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C120" gate="G$1" pin="2"/>
<pinref part="GND177" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C121" gate="G$1" pin="2"/>
<pinref part="GND178" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C123" gate="G$1" pin="2"/>
<pinref part="GND179" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C122" gate="G$1" pin="2"/>
<pinref part="GND180" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X17" gate="-2" pin="S"/>
<pinref part="GND181" gate="1" pin="GND"/>
<wire x1="160.02" y1="149.86" x2="165.1" y2="149.86" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C124" gate="G$1" pin="1"/>
<pinref part="GND182" gate="1" pin="GND"/>
<wire x1="241.3" y1="152.4" x2="238.76" y2="152.4" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C125" gate="G$1" pin="1"/>
<pinref part="GND183" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C126" gate="G$1" pin="1"/>
<pinref part="GND184" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U27" gate="A" pin="GND"/>
<pinref part="GND185" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R44" gate="G$1" pin="1"/>
<pinref part="GND186" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C127" gate="G$1" pin="1"/>
<pinref part="GND187" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C128" gate="G$1" pin="1"/>
<pinref part="GND188" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U27" gate="A" pin="EPAD"/>
<pinref part="GND189" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U28" gate="A" pin="GND"/>
<pinref part="GND190" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R46" gate="G$1" pin="1"/>
<pinref part="GND191" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C130" gate="G$1" pin="2"/>
<pinref part="GND192" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C131" gate="G$1" pin="2"/>
<pinref part="GND193" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C133" gate="G$1" pin="2"/>
<pinref part="GND194" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C132" gate="G$1" pin="2"/>
<pinref part="GND195" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X25" gate="-2" pin="S"/>
<pinref part="GND196" gate="1" pin="GND"/>
<wire x1="160.02" y1="99.06" x2="165.1" y2="99.06" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C134" gate="G$1" pin="1"/>
<pinref part="GND197" gate="1" pin="GND"/>
<wire x1="241.3" y1="101.6" x2="238.76" y2="101.6" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C135" gate="G$1" pin="1"/>
<pinref part="GND198" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C136" gate="G$1" pin="1"/>
<pinref part="GND199" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U29" gate="A" pin="GND"/>
<pinref part="GND200" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R48" gate="G$1" pin="1"/>
<pinref part="GND201" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C137" gate="G$1" pin="1"/>
<pinref part="GND202" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C138" gate="G$1" pin="1"/>
<pinref part="GND203" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U29" gate="A" pin="EPAD"/>
<pinref part="GND204" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C139" gate="G$1" pin="1"/>
<pinref part="GND205" gate="1" pin="GND"/>
<wire x1="48.26" y1="198.12" x2="45.72" y2="198.12" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C140" gate="G$1" pin="1"/>
<pinref part="GND206" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C141" gate="G$1" pin="1"/>
<pinref part="GND207" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U30" gate="A" pin="GND"/>
<pinref part="GND208" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R50" gate="G$1" pin="1"/>
<pinref part="GND209" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C142" gate="G$1" pin="1"/>
<pinref part="GND210" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C143" gate="G$1" pin="1"/>
<pinref part="GND211" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U30" gate="A" pin="EPAD"/>
<pinref part="GND212" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U31" gate="A" pin="GND"/>
<pinref part="GND213" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R52" gate="G$1" pin="1"/>
<pinref part="GND214" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C145" gate="G$1" pin="2"/>
<pinref part="GND215" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C146" gate="G$1" pin="2"/>
<pinref part="GND216" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C148" gate="G$1" pin="2"/>
<pinref part="GND217" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C147" gate="G$1" pin="2"/>
<pinref part="GND218" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X26" gate="-2" pin="S"/>
<pinref part="GND219" gate="1" pin="GND"/>
<wire x1="518.16" y1="261.62" x2="523.24" y2="261.62" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U32" gate="A" pin="EPAD"/>
<pinref part="GND220" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U32" gate="A" pin="GND"/>
<pinref part="GND221" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U32" gate="A" pin="GND_2"/>
<pinref part="GND222" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C149" gate="G$1" pin="2"/>
<pinref part="GND223" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R54" gate="G$1" pin="1"/>
<pinref part="GND224" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C151" gate="G$1" pin="2"/>
<pinref part="GND225" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C152" gate="G$1" pin="2"/>
<pinref part="GND226" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C153" gate="G$1" pin="2"/>
<pinref part="GND227" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U33" gate="A" pin="GND"/>
<pinref part="GND228" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R56" gate="G$1" pin="1"/>
<pinref part="GND229" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C155" gate="G$1" pin="2"/>
<pinref part="GND230" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C156" gate="G$1" pin="2"/>
<pinref part="GND231" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C158" gate="G$1" pin="2"/>
<pinref part="GND232" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C157" gate="G$1" pin="2"/>
<pinref part="GND233" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X28" gate="-2" pin="S"/>
<pinref part="GND234" gate="1" pin="GND"/>
<wire x1="789.94" y1="248.92" x2="789.94" y2="254" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U34" gate="A" pin="EPAD"/>
<pinref part="GND235" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U34" gate="A" pin="GND"/>
<pinref part="GND236" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="U34" gate="A" pin="GND_2"/>
<pinref part="GND237" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C159" gate="G$1" pin="2"/>
<pinref part="GND238" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="R58" gate="G$1" pin="1"/>
<pinref part="GND239" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C161" gate="G$1" pin="2"/>
<pinref part="GND240" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C162" gate="G$1" pin="2"/>
<pinref part="GND241" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="C163" gate="G$1" pin="2"/>
<pinref part="GND242" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X4" gate="-2" pin="S"/>
<pinref part="GND138" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X5" gate="-2" pin="S"/>
<pinref part="GND139" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X6" gate="-2" pin="S"/>
<pinref part="GND140" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X7" gate="-2" pin="S"/>
<pinref part="GND141" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X8" gate="-2" pin="S"/>
<pinref part="GND142" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X10" gate="-2" pin="S"/>
<pinref part="GND144" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X11" gate="-2" pin="S"/>
<pinref part="GND145" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X12" gate="-2" pin="S"/>
<pinref part="GND146" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X3" gate="-2" pin="S"/>
<pinref part="GND128" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X13" gate="-2" pin="S"/>
<pinref part="GND147" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X14" gate="-2" pin="S"/>
<pinref part="GND148" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X15" gate="-2" pin="S"/>
<pinref part="GND149" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X29" gate="-2" pin="S"/>
<pinref part="GND243" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X30" gate="-2" pin="S"/>
<pinref part="GND244" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X31" gate="-2" pin="S"/>
<pinref part="GND245" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X32" gate="-2" pin="S"/>
<pinref part="GND246" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X33" gate="-2" pin="S"/>
<pinref part="GND247" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X34" gate="-2" pin="S"/>
<pinref part="GND248" gate="1" pin="GND"/>
</segment>
<segment>
<pinref part="X35" gate="-2" pin="S"/>
<pinref part="GND249" gate="1" pin="GND"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="U1" gate="A" pin="SW"/>
<pinref part="U$1" gate="A" pin="2"/>
<wire x1="96.52" y1="482.6" x2="106.68" y2="482.6" width="0.1524" layer="91"/>
<pinref part="C1" gate="G$1" pin="2"/>
<wire x1="106.68" y1="482.6" x2="111.76" y2="482.6" width="0.1524" layer="91"/>
<wire x1="106.68" y1="474.98" x2="106.68" y2="482.6" width="0.1524" layer="91"/>
<junction x="106.68" y="482.6"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="C1" gate="G$1" pin="1"/>
<pinref part="U1" gate="A" pin="VBST"/>
<wire x1="99.06" y1="474.98" x2="96.52" y2="474.98" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+1V0_FPGA" class="0">
<segment>
<pinref part="U$1" gate="A" pin="1"/>
<pinref part="R1" gate="G$1" pin="2"/>
<wire x1="127" y1="482.6" x2="129.54" y2="482.6" width="0.1524" layer="91"/>
<junction x="129.54" y="482.6"/>
<pinref part="C2" gate="G$1" pin="1"/>
<wire x1="139.7" y1="482.6" x2="129.54" y2="482.6" width="0.1524" layer="91"/>
<junction x="139.7" y="482.6"/>
<pinref part="C3" gate="G$1" pin="1"/>
<wire x1="139.7" y1="482.6" x2="147.32" y2="482.6" width="0.1524" layer="91"/>
<wire x1="147.32" y1="482.6" x2="160.02" y2="482.6" width="0.1524" layer="91"/>
<junction x="147.32" y="482.6"/>
<wire x1="160.02" y1="482.6" x2="160.02" y2="485.14" width="0.1524" layer="91"/>
<label x="160.02" y="485.14" size="1.778" layer="95"/>
<wire x1="160.02" y1="482.6" x2="175.26" y2="482.6" width="0.1524" layer="91"/>
<junction x="160.02" y="482.6"/>
<pinref part="X4" gate="-1" pin="S"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="R1" gate="G$1" pin="1"/>
<pinref part="R2" gate="G$1" pin="2"/>
<wire x1="129.54" y1="472.44" x2="129.54" y2="469.9" width="0.1524" layer="91"/>
<wire x1="129.54" y1="469.9" x2="111.76" y2="469.9" width="0.1524" layer="91"/>
<junction x="129.54" y="469.9"/>
<wire x1="111.76" y1="469.9" x2="111.76" y2="464.82" width="0.1524" layer="91"/>
<pinref part="U1" gate="A" pin="VFB"/>
<wire x1="111.76" y1="464.82" x2="96.52" y2="464.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="VIN" class="0">
<segment>
<pinref part="U1" gate="A" pin="VIN"/>
<pinref part="C4" gate="G$1" pin="1"/>
<wire x1="60.96" y1="482.6" x2="43.18" y2="482.6" width="0.1524" layer="91"/>
<pinref part="C5" gate="G$1" pin="1"/>
<wire x1="43.18" y1="482.6" x2="33.02" y2="482.6" width="0.1524" layer="91"/>
<junction x="43.18" y="482.6"/>
<wire x1="33.02" y1="482.6" x2="27.94" y2="482.6" width="0.1524" layer="91"/>
<junction x="33.02" y="482.6"/>
<wire x1="27.94" y1="482.6" x2="27.94" y2="485.14" width="0.1524" layer="91"/>
<label x="27.94" y="485.14" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U2" gate="A" pin="VIN"/>
<pinref part="C9" gate="G$1" pin="1"/>
<wire x1="60.96" y1="439.42" x2="43.18" y2="439.42" width="0.1524" layer="91"/>
<pinref part="C10" gate="G$1" pin="1"/>
<wire x1="43.18" y1="439.42" x2="33.02" y2="439.42" width="0.1524" layer="91"/>
<junction x="43.18" y="439.42"/>
<wire x1="33.02" y1="439.42" x2="27.94" y2="439.42" width="0.1524" layer="91"/>
<junction x="33.02" y="439.42"/>
<wire x1="27.94" y1="439.42" x2="27.94" y2="441.96" width="0.1524" layer="91"/>
<label x="27.94" y="441.96" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U3" gate="A" pin="VIN"/>
<pinref part="C15" gate="G$1" pin="1"/>
<wire x1="60.96" y1="525.78" x2="55.88" y2="525.78" width="0.1524" layer="91"/>
<pinref part="C16" gate="G$1" pin="1"/>
<wire x1="55.88" y1="525.78" x2="43.18" y2="525.78" width="0.1524" layer="91"/>
<wire x1="43.18" y1="525.78" x2="33.02" y2="525.78" width="0.1524" layer="91"/>
<junction x="43.18" y="525.78"/>
<wire x1="33.02" y1="525.78" x2="27.94" y2="525.78" width="0.1524" layer="91"/>
<junction x="33.02" y="525.78"/>
<wire x1="27.94" y1="525.78" x2="27.94" y2="528.32" width="0.1524" layer="91"/>
<label x="27.94" y="528.32" size="1.778" layer="95"/>
<pinref part="U3" gate="A" pin="EN"/>
<wire x1="60.96" y1="518.16" x2="55.88" y2="518.16" width="0.1524" layer="91"/>
<wire x1="55.88" y1="518.16" x2="55.88" y2="525.78" width="0.1524" layer="91"/>
<junction x="55.88" y="525.78"/>
</segment>
<segment>
<pinref part="U4" gate="A" pin="VIN"/>
<pinref part="C21" gate="G$1" pin="1"/>
<wire x1="60.96" y1="396.24" x2="43.18" y2="396.24" width="0.1524" layer="91"/>
<pinref part="C22" gate="G$1" pin="1"/>
<wire x1="43.18" y1="396.24" x2="33.02" y2="396.24" width="0.1524" layer="91"/>
<junction x="43.18" y="396.24"/>
<wire x1="33.02" y1="396.24" x2="27.94" y2="396.24" width="0.1524" layer="91"/>
<junction x="33.02" y="396.24"/>
<wire x1="27.94" y1="396.24" x2="27.94" y2="398.78" width="0.1524" layer="91"/>
<label x="27.94" y="398.78" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U6" gate="A" pin="VIN"/>
<pinref part="C33" gate="G$1" pin="1"/>
<wire x1="419.1" y1="363.22" x2="401.32" y2="363.22" width="0.1524" layer="91"/>
<pinref part="C34" gate="G$1" pin="1"/>
<wire x1="401.32" y1="363.22" x2="391.16" y2="363.22" width="0.1524" layer="91"/>
<junction x="401.32" y="363.22"/>
<wire x1="391.16" y1="363.22" x2="386.08" y2="363.22" width="0.1524" layer="91"/>
<junction x="391.16" y="363.22"/>
<wire x1="386.08" y1="363.22" x2="386.08" y2="365.76" width="0.1524" layer="91"/>
<label x="386.08" y="365.76" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U7" gate="A" pin="VIN"/>
<pinref part="C39" gate="G$1" pin="1"/>
<wire x1="419.1" y1="317.5" x2="401.32" y2="317.5" width="0.1524" layer="91"/>
<pinref part="C40" gate="G$1" pin="1"/>
<wire x1="401.32" y1="317.5" x2="391.16" y2="317.5" width="0.1524" layer="91"/>
<junction x="401.32" y="317.5"/>
<wire x1="391.16" y1="317.5" x2="386.08" y2="317.5" width="0.1524" layer="91"/>
<junction x="391.16" y="317.5"/>
<wire x1="386.08" y1="317.5" x2="386.08" y2="320.04" width="0.1524" layer="91"/>
<label x="386.08" y="320.04" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U8" gate="A" pin="VIN"/>
<pinref part="C45" gate="G$1" pin="1"/>
<wire x1="419.1" y1="165.1" x2="401.32" y2="165.1" width="0.1524" layer="91"/>
<pinref part="C46" gate="G$1" pin="1"/>
<wire x1="401.32" y1="165.1" x2="391.16" y2="165.1" width="0.1524" layer="91"/>
<junction x="401.32" y="165.1"/>
<wire x1="391.16" y1="165.1" x2="386.08" y2="165.1" width="0.1524" layer="91"/>
<junction x="391.16" y="165.1"/>
<wire x1="386.08" y1="165.1" x2="386.08" y2="167.64" width="0.1524" layer="91"/>
<label x="386.08" y="167.64" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U10" gate="A" pin="VIN"/>
<pinref part="C57" gate="G$1" pin="1"/>
<wire x1="419.1" y1="213.36" x2="401.32" y2="213.36" width="0.1524" layer="91"/>
<pinref part="C58" gate="G$1" pin="1"/>
<wire x1="401.32" y1="213.36" x2="391.16" y2="213.36" width="0.1524" layer="91"/>
<junction x="401.32" y="213.36"/>
<wire x1="391.16" y1="213.36" x2="386.08" y2="213.36" width="0.1524" layer="91"/>
<junction x="391.16" y="213.36"/>
<wire x1="386.08" y1="213.36" x2="386.08" y2="215.9" width="0.1524" layer="91"/>
<label x="386.08" y="215.9" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U11" gate="A" pin="VIN"/>
<pinref part="C63" gate="G$1" pin="1"/>
<wire x1="419.1" y1="472.44" x2="414.02" y2="472.44" width="0.1524" layer="91"/>
<pinref part="C64" gate="G$1" pin="1"/>
<wire x1="414.02" y1="472.44" x2="401.32" y2="472.44" width="0.1524" layer="91"/>
<wire x1="401.32" y1="472.44" x2="391.16" y2="472.44" width="0.1524" layer="91"/>
<junction x="401.32" y="472.44"/>
<wire x1="391.16" y1="472.44" x2="386.08" y2="472.44" width="0.1524" layer="91"/>
<junction x="391.16" y="472.44"/>
<wire x1="386.08" y1="472.44" x2="386.08" y2="474.98" width="0.1524" layer="91"/>
<label x="386.08" y="474.98" size="1.778" layer="95"/>
<pinref part="U11" gate="A" pin="EN"/>
<wire x1="419.1" y1="464.82" x2="414.02" y2="464.82" width="0.1524" layer="91"/>
<wire x1="414.02" y1="464.82" x2="414.02" y2="472.44" width="0.1524" layer="91"/>
<junction x="414.02" y="472.44"/>
</segment>
<segment>
<pinref part="U12" gate="A" pin="VIN"/>
<pinref part="C69" gate="G$1" pin="1"/>
<wire x1="60.96" y1="350.52" x2="55.88" y2="350.52" width="0.1524" layer="91"/>
<pinref part="C70" gate="G$1" pin="1"/>
<wire x1="55.88" y1="350.52" x2="43.18" y2="350.52" width="0.1524" layer="91"/>
<wire x1="43.18" y1="350.52" x2="33.02" y2="350.52" width="0.1524" layer="91"/>
<junction x="43.18" y="350.52"/>
<wire x1="33.02" y1="350.52" x2="27.94" y2="350.52" width="0.1524" layer="91"/>
<junction x="33.02" y="350.52"/>
<wire x1="27.94" y1="350.52" x2="27.94" y2="353.06" width="0.1524" layer="91"/>
<label x="27.94" y="353.06" size="1.778" layer="95"/>
<pinref part="U12" gate="A" pin="EN"/>
<wire x1="60.96" y1="342.9" x2="55.88" y2="342.9" width="0.1524" layer="91"/>
<wire x1="55.88" y1="342.9" x2="55.88" y2="350.52" width="0.1524" layer="91"/>
<junction x="55.88" y="350.52"/>
</segment>
<segment>
<pinref part="U13" gate="A" pin="VIN"/>
<pinref part="C74" gate="G$1" pin="1"/>
<pinref part="C75" gate="G$1" pin="1"/>
<wire x1="419.1" y1="416.56" x2="401.32" y2="416.56" width="0.1524" layer="91"/>
<wire x1="401.32" y1="416.56" x2="391.16" y2="416.56" width="0.1524" layer="91"/>
<junction x="401.32" y="416.56"/>
<wire x1="391.16" y1="416.56" x2="386.08" y2="416.56" width="0.1524" layer="91"/>
<junction x="391.16" y="416.56"/>
<wire x1="386.08" y1="416.56" x2="386.08" y2="419.1" width="0.1524" layer="91"/>
<label x="386.08" y="419.1" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U14" gate="A" pin="VIN"/>
<pinref part="C80" gate="G$1" pin="1"/>
<pinref part="C81" gate="G$1" pin="1"/>
<wire x1="419.1" y1="121.92" x2="401.32" y2="121.92" width="0.1524" layer="91"/>
<wire x1="401.32" y1="121.92" x2="391.16" y2="121.92" width="0.1524" layer="91"/>
<junction x="401.32" y="121.92"/>
<wire x1="391.16" y1="121.92" x2="386.08" y2="121.92" width="0.1524" layer="91"/>
<junction x="391.16" y="121.92"/>
<wire x1="386.08" y1="121.92" x2="386.08" y2="124.46" width="0.1524" layer="91"/>
<label x="386.08" y="124.46" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U15" gate="A" pin="VIN"/>
<pinref part="C86" gate="G$1" pin="1"/>
<pinref part="C87" gate="G$1" pin="1"/>
<wire x1="419.1" y1="78.74" x2="401.32" y2="78.74" width="0.1524" layer="91"/>
<wire x1="401.32" y1="78.74" x2="391.16" y2="78.74" width="0.1524" layer="91"/>
<junction x="401.32" y="78.74"/>
<wire x1="391.16" y1="78.74" x2="386.08" y2="78.74" width="0.1524" layer="91"/>
<junction x="391.16" y="78.74"/>
<wire x1="386.08" y1="78.74" x2="386.08" y2="81.28" width="0.1524" layer="91"/>
<label x="386.08" y="81.28" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U16" gate="A" pin="VIN"/>
<pinref part="C92" gate="G$1" pin="1"/>
<pinref part="C93" gate="G$1" pin="1"/>
<wire x1="419.1" y1="35.56" x2="401.32" y2="35.56" width="0.1524" layer="91"/>
<wire x1="401.32" y1="35.56" x2="391.16" y2="35.56" width="0.1524" layer="91"/>
<junction x="401.32" y="35.56"/>
<wire x1="391.16" y1="35.56" x2="386.08" y2="35.56" width="0.1524" layer="91"/>
<junction x="391.16" y="35.56"/>
<wire x1="386.08" y1="35.56" x2="386.08" y2="38.1" width="0.1524" layer="91"/>
<label x="386.08" y="38.1" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U17" gate="A" pin="VIN"/>
<pinref part="C94" gate="G$1" pin="1"/>
<pinref part="C95" gate="G$1" pin="1"/>
<wire x1="419.1" y1="523.24" x2="401.32" y2="523.24" width="0.1524" layer="91"/>
<wire x1="401.32" y1="523.24" x2="391.16" y2="523.24" width="0.1524" layer="91"/>
<junction x="401.32" y="523.24"/>
<wire x1="391.16" y1="523.24" x2="386.08" y2="523.24" width="0.1524" layer="91"/>
<junction x="391.16" y="523.24"/>
<wire x1="386.08" y1="523.24" x2="386.08" y2="525.78" width="0.1524" layer="91"/>
<label x="386.08" y="525.78" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="X1" gate="-1" pin="KL"/>
<wire x1="284.48" y1="515.62" x2="292.1" y2="515.62" width="0.1524" layer="91"/>
<wire x1="292.1" y1="515.62" x2="292.1" y2="518.16" width="0.1524" layer="91"/>
<label x="292.1" y="518.16" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U9" gate="A" pin="VIN"/>
<pinref part="C50" gate="G$1" pin="1"/>
<wire x1="60.96" y1="302.26" x2="55.88" y2="302.26" width="0.1524" layer="91"/>
<pinref part="C51" gate="G$1" pin="1"/>
<wire x1="55.88" y1="302.26" x2="43.18" y2="302.26" width="0.1524" layer="91"/>
<wire x1="43.18" y1="302.26" x2="33.02" y2="302.26" width="0.1524" layer="91"/>
<junction x="43.18" y="302.26"/>
<wire x1="33.02" y1="302.26" x2="27.94" y2="302.26" width="0.1524" layer="91"/>
<junction x="33.02" y="302.26"/>
<wire x1="27.94" y1="302.26" x2="27.94" y2="304.8" width="0.1524" layer="91"/>
<label x="27.94" y="304.8" size="1.778" layer="95"/>
<pinref part="U9" gate="A" pin="EN"/>
<wire x1="60.96" y1="294.64" x2="55.88" y2="294.64" width="0.1524" layer="91"/>
<wire x1="55.88" y1="294.64" x2="55.88" y2="302.26" width="0.1524" layer="91"/>
<junction x="55.88" y="302.26"/>
</segment>
<segment>
<pinref part="U24" gate="A" pin="VIN"/>
<pinref part="C112" gate="G$1" pin="1"/>
<wire x1="60.96" y1="251.46" x2="55.88" y2="251.46" width="0.1524" layer="91"/>
<pinref part="C113" gate="G$1" pin="1"/>
<wire x1="55.88" y1="251.46" x2="43.18" y2="251.46" width="0.1524" layer="91"/>
<wire x1="43.18" y1="251.46" x2="33.02" y2="251.46" width="0.1524" layer="91"/>
<junction x="43.18" y="251.46"/>
<wire x1="33.02" y1="251.46" x2="27.94" y2="251.46" width="0.1524" layer="91"/>
<junction x="33.02" y="251.46"/>
<wire x1="27.94" y1="251.46" x2="27.94" y2="254" width="0.1524" layer="91"/>
<label x="27.94" y="254" size="1.778" layer="95"/>
<pinref part="U24" gate="A" pin="EN"/>
<wire x1="60.96" y1="243.84" x2="55.88" y2="243.84" width="0.1524" layer="91"/>
<wire x1="55.88" y1="243.84" x2="55.88" y2="251.46" width="0.1524" layer="91"/>
<junction x="55.88" y="251.46"/>
</segment>
<segment>
<pinref part="U26" gate="A" pin="VIN"/>
<pinref part="C122" gate="G$1" pin="1"/>
<wire x1="60.96" y1="152.4" x2="55.88" y2="152.4" width="0.1524" layer="91"/>
<pinref part="C123" gate="G$1" pin="1"/>
<wire x1="55.88" y1="152.4" x2="43.18" y2="152.4" width="0.1524" layer="91"/>
<wire x1="43.18" y1="152.4" x2="33.02" y2="152.4" width="0.1524" layer="91"/>
<junction x="43.18" y="152.4"/>
<wire x1="33.02" y1="152.4" x2="27.94" y2="152.4" width="0.1524" layer="91"/>
<junction x="33.02" y="152.4"/>
<wire x1="27.94" y1="152.4" x2="27.94" y2="154.94" width="0.1524" layer="91"/>
<label x="27.94" y="154.94" size="1.778" layer="95"/>
<pinref part="U26" gate="A" pin="EN"/>
<wire x1="60.96" y1="144.78" x2="55.88" y2="144.78" width="0.1524" layer="91"/>
<wire x1="55.88" y1="144.78" x2="55.88" y2="152.4" width="0.1524" layer="91"/>
<junction x="55.88" y="152.4"/>
</segment>
<segment>
<pinref part="U28" gate="A" pin="VIN"/>
<pinref part="C132" gate="G$1" pin="1"/>
<wire x1="60.96" y1="101.6" x2="55.88" y2="101.6" width="0.1524" layer="91"/>
<pinref part="C133" gate="G$1" pin="1"/>
<wire x1="55.88" y1="101.6" x2="43.18" y2="101.6" width="0.1524" layer="91"/>
<wire x1="43.18" y1="101.6" x2="33.02" y2="101.6" width="0.1524" layer="91"/>
<junction x="43.18" y="101.6"/>
<wire x1="33.02" y1="101.6" x2="27.94" y2="101.6" width="0.1524" layer="91"/>
<junction x="33.02" y="101.6"/>
<wire x1="27.94" y1="101.6" x2="27.94" y2="104.14" width="0.1524" layer="91"/>
<label x="27.94" y="104.14" size="1.778" layer="95"/>
<pinref part="U28" gate="A" pin="EN"/>
<wire x1="60.96" y1="93.98" x2="55.88" y2="93.98" width="0.1524" layer="91"/>
<wire x1="55.88" y1="93.98" x2="55.88" y2="101.6" width="0.1524" layer="91"/>
<junction x="55.88" y="101.6"/>
</segment>
<segment>
<pinref part="U30" gate="A" pin="VIN"/>
<wire x1="109.22" y1="195.58" x2="111.76" y2="195.58" width="0.1524" layer="91"/>
<pinref part="C143" gate="G$1" pin="2"/>
<label x="132.08" y="195.58" size="1.778" layer="95"/>
<pinref part="U30" gate="A" pin="EN"/>
<wire x1="111.76" y1="195.58" x2="144.78" y2="195.58" width="0.1524" layer="91"/>
<wire x1="109.22" y1="193.04" x2="111.76" y2="193.04" width="0.1524" layer="91"/>
<wire x1="111.76" y1="193.04" x2="111.76" y2="195.58" width="0.1524" layer="91"/>
<junction x="111.76" y="195.58"/>
</segment>
<segment>
<pinref part="U31" gate="A" pin="VIN"/>
<pinref part="C147" gate="G$1" pin="1"/>
<wire x1="419.1" y1="264.16" x2="414.02" y2="264.16" width="0.1524" layer="91"/>
<pinref part="C148" gate="G$1" pin="1"/>
<wire x1="414.02" y1="264.16" x2="401.32" y2="264.16" width="0.1524" layer="91"/>
<wire x1="401.32" y1="264.16" x2="391.16" y2="264.16" width="0.1524" layer="91"/>
<junction x="401.32" y="264.16"/>
<wire x1="391.16" y1="264.16" x2="386.08" y2="264.16" width="0.1524" layer="91"/>
<junction x="391.16" y="264.16"/>
<wire x1="386.08" y1="264.16" x2="386.08" y2="266.7" width="0.1524" layer="91"/>
<label x="386.08" y="266.7" size="1.778" layer="95"/>
<pinref part="U31" gate="A" pin="EN"/>
<wire x1="419.1" y1="256.54" x2="414.02" y2="256.54" width="0.1524" layer="91"/>
<wire x1="414.02" y1="256.54" x2="414.02" y2="264.16" width="0.1524" layer="91"/>
<junction x="414.02" y="264.16"/>
</segment>
<segment>
<pinref part="U33" gate="A" pin="VIN"/>
<pinref part="C157" gate="G$1" pin="1"/>
<wire x1="787.4" y1="149.86" x2="787.4" y2="144.78" width="0.1524" layer="91"/>
<pinref part="C158" gate="G$1" pin="1"/>
<wire x1="787.4" y1="144.78" x2="787.4" y2="132.08" width="0.1524" layer="91"/>
<wire x1="787.4" y1="132.08" x2="787.4" y2="121.92" width="0.1524" layer="91"/>
<junction x="787.4" y="132.08"/>
<wire x1="787.4" y1="121.92" x2="787.4" y2="116.84" width="0.1524" layer="91"/>
<junction x="787.4" y="121.92"/>
<wire x1="787.4" y1="116.84" x2="784.86" y2="116.84" width="0.1524" layer="91"/>
<label x="784.86" y="116.84" size="1.778" layer="95" rot="R90"/>
<pinref part="U33" gate="A" pin="EN"/>
<wire x1="795.02" y1="149.86" x2="795.02" y2="144.78" width="0.1524" layer="91"/>
<wire x1="795.02" y1="144.78" x2="787.4" y2="144.78" width="0.1524" layer="91"/>
<junction x="787.4" y="144.78"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U2" gate="A" pin="SW"/>
<pinref part="U$2" gate="A" pin="2"/>
<wire x1="96.52" y1="439.42" x2="106.68" y2="439.42" width="0.1524" layer="91"/>
<pinref part="C6" gate="G$1" pin="2"/>
<wire x1="106.68" y1="439.42" x2="111.76" y2="439.42" width="0.1524" layer="91"/>
<wire x1="106.68" y1="431.8" x2="106.68" y2="439.42" width="0.1524" layer="91"/>
<junction x="106.68" y="439.42"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="C6" gate="G$1" pin="1"/>
<pinref part="U2" gate="A" pin="VBST"/>
<wire x1="99.06" y1="431.8" x2="96.52" y2="431.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="R3" gate="G$1" pin="1"/>
<pinref part="R4" gate="G$1" pin="2"/>
<wire x1="129.54" y1="429.26" x2="129.54" y2="426.72" width="0.1524" layer="91"/>
<wire x1="129.54" y1="426.72" x2="111.76" y2="426.72" width="0.1524" layer="91"/>
<junction x="129.54" y="426.72"/>
<wire x1="111.76" y1="426.72" x2="111.76" y2="421.64" width="0.1524" layer="91"/>
<pinref part="U2" gate="A" pin="VFB"/>
<wire x1="111.76" y1="421.64" x2="96.52" y2="421.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+1V8_FPGA" class="0">
<segment>
<pinref part="U$2" gate="A" pin="1"/>
<pinref part="R3" gate="G$1" pin="2"/>
<wire x1="127" y1="439.42" x2="129.54" y2="439.42" width="0.1524" layer="91"/>
<junction x="129.54" y="439.42"/>
<pinref part="C7" gate="G$1" pin="1"/>
<wire x1="139.7" y1="439.42" x2="129.54" y2="439.42" width="0.1524" layer="91"/>
<junction x="139.7" y="439.42"/>
<pinref part="C8" gate="G$1" pin="1"/>
<wire x1="139.7" y1="439.42" x2="147.32" y2="439.42" width="0.1524" layer="91"/>
<wire x1="147.32" y1="439.42" x2="154.94" y2="439.42" width="0.1524" layer="91"/>
<junction x="147.32" y="439.42"/>
<wire x1="154.94" y1="439.42" x2="160.02" y2="439.42" width="0.1524" layer="91"/>
<wire x1="160.02" y1="439.42" x2="160.02" y2="441.96" width="0.1524" layer="91"/>
<label x="160.02" y="441.96" size="1.778" layer="95"/>
<pinref part="C11" gate="G$1" pin="1"/>
<junction x="154.94" y="439.42"/>
<wire x1="177.8" y1="439.42" x2="160.02" y2="439.42" width="0.1524" layer="91"/>
<junction x="160.02" y="439.42"/>
<pinref part="X5" gate="-1" pin="S"/>
</segment>
</net>
<net name="EN_+1V8_FPGA" class="0">
<segment>
<pinref part="U2" gate="A" pin="EN"/>
<wire x1="60.96" y1="431.8" x2="55.88" y2="431.8" width="0.1524" layer="91"/>
<label x="55.88" y="414.02" size="1.778" layer="95" rot="R90"/>
<wire x1="55.88" y1="431.8" x2="55.88" y2="411.48" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="3"/>
<wire x1="299.72" y1="459.74" x2="299.72" y2="462.28" width="0.1524" layer="91"/>
<label x="299.72" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U3" gate="A" pin="SW"/>
<pinref part="U$3" gate="A" pin="2"/>
<wire x1="96.52" y1="525.78" x2="106.68" y2="525.78" width="0.1524" layer="91"/>
<pinref part="C12" gate="G$1" pin="2"/>
<wire x1="106.68" y1="525.78" x2="111.76" y2="525.78" width="0.1524" layer="91"/>
<wire x1="106.68" y1="518.16" x2="106.68" y2="525.78" width="0.1524" layer="91"/>
<junction x="106.68" y="525.78"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="C12" gate="G$1" pin="1"/>
<pinref part="U3" gate="A" pin="VBST"/>
<wire x1="99.06" y1="518.16" x2="96.52" y2="518.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="R5" gate="G$1" pin="1"/>
<pinref part="R6" gate="G$1" pin="2"/>
<wire x1="129.54" y1="515.62" x2="129.54" y2="513.08" width="0.1524" layer="91"/>
<wire x1="129.54" y1="513.08" x2="111.76" y2="513.08" width="0.1524" layer="91"/>
<junction x="129.54" y="513.08"/>
<wire x1="111.76" y1="513.08" x2="111.76" y2="508" width="0.1524" layer="91"/>
<pinref part="U3" gate="A" pin="VFB"/>
<wire x1="111.76" y1="508" x2="96.52" y2="508" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="U4" gate="A" pin="SW"/>
<pinref part="U$4" gate="A" pin="2"/>
<wire x1="96.52" y1="396.24" x2="106.68" y2="396.24" width="0.1524" layer="91"/>
<pinref part="C18" gate="G$1" pin="2"/>
<wire x1="106.68" y1="396.24" x2="111.76" y2="396.24" width="0.1524" layer="91"/>
<wire x1="106.68" y1="388.62" x2="106.68" y2="396.24" width="0.1524" layer="91"/>
<junction x="106.68" y="396.24"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="C18" gate="G$1" pin="1"/>
<pinref part="U4" gate="A" pin="VBST"/>
<wire x1="99.06" y1="388.62" x2="96.52" y2="388.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="R7" gate="G$1" pin="1"/>
<pinref part="R8" gate="G$1" pin="2"/>
<wire x1="129.54" y1="386.08" x2="129.54" y2="383.54" width="0.1524" layer="91"/>
<wire x1="129.54" y1="383.54" x2="111.76" y2="383.54" width="0.1524" layer="91"/>
<junction x="129.54" y="383.54"/>
<wire x1="111.76" y1="383.54" x2="111.76" y2="378.46" width="0.1524" layer="91"/>
<pinref part="U4" gate="A" pin="VFB"/>
<wire x1="111.76" y1="378.46" x2="96.52" y2="378.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V3" class="0">
<segment>
<pinref part="U$3" gate="A" pin="1"/>
<pinref part="R5" gate="G$1" pin="2"/>
<wire x1="127" y1="525.78" x2="129.54" y2="525.78" width="0.1524" layer="91"/>
<junction x="129.54" y="525.78"/>
<pinref part="C13" gate="G$1" pin="1"/>
<wire x1="139.7" y1="525.78" x2="129.54" y2="525.78" width="0.1524" layer="91"/>
<junction x="139.7" y="525.78"/>
<pinref part="C14" gate="G$1" pin="1"/>
<wire x1="139.7" y1="525.78" x2="147.32" y2="525.78" width="0.1524" layer="91"/>
<wire x1="147.32" y1="525.78" x2="154.94" y2="525.78" width="0.1524" layer="91"/>
<junction x="147.32" y="525.78"/>
<wire x1="154.94" y1="525.78" x2="160.02" y2="525.78" width="0.1524" layer="91"/>
<wire x1="160.02" y1="525.78" x2="160.02" y2="528.32" width="0.1524" layer="91"/>
<label x="160.02" y="528.32" size="1.778" layer="95"/>
<pinref part="C17" gate="G$1" pin="1"/>
<junction x="154.94" y="525.78"/>
<pinref part="X16" gate="-1" pin="S"/>
<wire x1="177.8" y1="525.78" x2="160.02" y2="525.78" width="0.1524" layer="91"/>
<junction x="160.02" y="525.78"/>
</segment>
</net>
<net name="EN_+3V3_FPGA" class="0">
<segment>
<pinref part="U4" gate="A" pin="EN"/>
<wire x1="60.96" y1="388.62" x2="55.88" y2="388.62" width="0.1524" layer="91"/>
<label x="55.88" y="370.84" size="1.778" layer="95" rot="R90"/>
<wire x1="55.88" y1="368.3" x2="55.88" y2="388.62" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="5"/>
<wire x1="297.18" y1="459.74" x2="297.18" y2="462.28" width="0.1524" layer="91"/>
<label x="297.18" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+3V3_FPGA" class="0">
<segment>
<pinref part="U$4" gate="A" pin="1"/>
<pinref part="R7" gate="G$1" pin="2"/>
<wire x1="127" y1="396.24" x2="129.54" y2="396.24" width="0.1524" layer="91"/>
<junction x="129.54" y="396.24"/>
<pinref part="C19" gate="G$1" pin="1"/>
<wire x1="139.7" y1="396.24" x2="129.54" y2="396.24" width="0.1524" layer="91"/>
<junction x="139.7" y="396.24"/>
<pinref part="C20" gate="G$1" pin="1"/>
<wire x1="139.7" y1="396.24" x2="147.32" y2="396.24" width="0.1524" layer="91"/>
<wire x1="147.32" y1="396.24" x2="154.94" y2="396.24" width="0.1524" layer="91"/>
<junction x="147.32" y="396.24"/>
<wire x1="154.94" y1="396.24" x2="160.02" y2="396.24" width="0.1524" layer="91"/>
<wire x1="160.02" y1="396.24" x2="160.02" y2="398.78" width="0.1524" layer="91"/>
<label x="160.02" y="398.78" size="1.778" layer="95"/>
<pinref part="C23" gate="G$1" pin="1"/>
<junction x="154.94" y="396.24"/>
<junction x="160.02" y="396.24"/>
<pinref part="X27" gate="-1" pin="S"/>
<wire x1="177.8" y1="396.24" x2="160.02" y2="396.24" width="0.1524" layer="91"/>
<wire x1="182.88" y1="408.94" x2="177.8" y2="408.94" width="0.1524" layer="91"/>
<wire x1="177.8" y1="408.94" x2="177.8" y2="396.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="U6" gate="A" pin="SW"/>
<pinref part="U$6" gate="A" pin="2"/>
<wire x1="454.66" y1="363.22" x2="464.82" y2="363.22" width="0.1524" layer="91"/>
<pinref part="C30" gate="G$1" pin="2"/>
<wire x1="464.82" y1="363.22" x2="469.9" y2="363.22" width="0.1524" layer="91"/>
<wire x1="464.82" y1="355.6" x2="464.82" y2="363.22" width="0.1524" layer="91"/>
<junction x="464.82" y="363.22"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<pinref part="C30" gate="G$1" pin="1"/>
<pinref part="U6" gate="A" pin="VBST"/>
<wire x1="457.2" y1="355.6" x2="454.66" y2="355.6" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="R11" gate="G$1" pin="1"/>
<pinref part="R12" gate="G$1" pin="2"/>
<wire x1="487.68" y1="353.06" x2="487.68" y2="350.52" width="0.1524" layer="91"/>
<wire x1="487.68" y1="350.52" x2="469.9" y2="350.52" width="0.1524" layer="91"/>
<junction x="487.68" y="350.52"/>
<wire x1="469.9" y1="350.52" x2="469.9" y2="345.44" width="0.1524" layer="91"/>
<pinref part="U6" gate="A" pin="VFB"/>
<wire x1="469.9" y1="345.44" x2="454.66" y2="345.44" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="U7" gate="A" pin="SW"/>
<pinref part="U$7" gate="A" pin="2"/>
<wire x1="454.66" y1="317.5" x2="464.82" y2="317.5" width="0.1524" layer="91"/>
<pinref part="C36" gate="G$1" pin="2"/>
<wire x1="464.82" y1="317.5" x2="469.9" y2="317.5" width="0.1524" layer="91"/>
<wire x1="464.82" y1="309.88" x2="464.82" y2="317.5" width="0.1524" layer="91"/>
<junction x="464.82" y="317.5"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<pinref part="C36" gate="G$1" pin="1"/>
<pinref part="U7" gate="A" pin="VBST"/>
<wire x1="457.2" y1="309.88" x2="454.66" y2="309.88" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$21" class="0">
<segment>
<pinref part="R13" gate="G$1" pin="1"/>
<pinref part="R14" gate="G$1" pin="2"/>
<wire x1="487.68" y1="307.34" x2="487.68" y2="304.8" width="0.1524" layer="91"/>
<wire x1="487.68" y1="304.8" x2="469.9" y2="304.8" width="0.1524" layer="91"/>
<junction x="487.68" y="304.8"/>
<wire x1="469.9" y1="304.8" x2="469.9" y2="299.72" width="0.1524" layer="91"/>
<pinref part="U7" gate="A" pin="VFB"/>
<wire x1="469.9" y1="299.72" x2="454.66" y2="299.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$22" class="0">
<segment>
<pinref part="U8" gate="A" pin="SW"/>
<pinref part="U$8" gate="A" pin="2"/>
<wire x1="454.66" y1="165.1" x2="464.82" y2="165.1" width="0.1524" layer="91"/>
<pinref part="C42" gate="G$1" pin="2"/>
<wire x1="464.82" y1="165.1" x2="469.9" y2="165.1" width="0.1524" layer="91"/>
<wire x1="464.82" y1="157.48" x2="464.82" y2="165.1" width="0.1524" layer="91"/>
<junction x="464.82" y="165.1"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<pinref part="C42" gate="G$1" pin="1"/>
<pinref part="U8" gate="A" pin="VBST"/>
<wire x1="457.2" y1="157.48" x2="454.66" y2="157.48" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$24" class="0">
<segment>
<pinref part="R15" gate="G$1" pin="1"/>
<pinref part="R16" gate="G$1" pin="2"/>
<wire x1="487.68" y1="154.94" x2="487.68" y2="152.4" width="0.1524" layer="91"/>
<wire x1="487.68" y1="152.4" x2="469.9" y2="152.4" width="0.1524" layer="91"/>
<junction x="487.68" y="152.4"/>
<wire x1="469.9" y1="152.4" x2="469.9" y2="147.32" width="0.1524" layer="91"/>
<pinref part="U8" gate="A" pin="VFB"/>
<wire x1="469.9" y1="147.32" x2="454.66" y2="147.32" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$28" class="0">
<segment>
<pinref part="U10" gate="A" pin="SW"/>
<pinref part="U$10" gate="A" pin="2"/>
<wire x1="454.66" y1="213.36" x2="464.82" y2="213.36" width="0.1524" layer="91"/>
<pinref part="C54" gate="G$1" pin="2"/>
<wire x1="464.82" y1="213.36" x2="469.9" y2="213.36" width="0.1524" layer="91"/>
<wire x1="464.82" y1="205.74" x2="464.82" y2="213.36" width="0.1524" layer="91"/>
<junction x="464.82" y="213.36"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<pinref part="C54" gate="G$1" pin="1"/>
<pinref part="U10" gate="A" pin="VBST"/>
<wire x1="457.2" y1="205.74" x2="454.66" y2="205.74" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$30" class="0">
<segment>
<pinref part="R19" gate="G$1" pin="1"/>
<pinref part="R20" gate="G$1" pin="2"/>
<wire x1="487.68" y1="203.2" x2="487.68" y2="200.66" width="0.1524" layer="91"/>
<wire x1="487.68" y1="200.66" x2="469.9" y2="200.66" width="0.1524" layer="91"/>
<junction x="487.68" y="200.66"/>
<wire x1="469.9" y1="200.66" x2="469.9" y2="195.58" width="0.1524" layer="91"/>
<pinref part="U10" gate="A" pin="VFB"/>
<wire x1="469.9" y1="195.58" x2="454.66" y2="195.58" width="0.1524" layer="91"/>
</segment>
</net>
<net name="EN_+3V3_ADAR12" class="0">
<segment>
<pinref part="U6" gate="A" pin="EN"/>
<wire x1="419.1" y1="355.6" x2="414.02" y2="355.6" width="0.1524" layer="91"/>
<label x="414.02" y="337.82" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="355.6" x2="414.02" y2="335.28" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="9"/>
<wire x1="292.1" y1="459.74" x2="292.1" y2="462.28" width="0.1524" layer="91"/>
<label x="292.1" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+3V3_ADAR_12" class="0">
<segment>
<pinref part="U$6" gate="A" pin="1"/>
<pinref part="R11" gate="G$1" pin="2"/>
<wire x1="485.14" y1="363.22" x2="487.68" y2="363.22" width="0.1524" layer="91"/>
<junction x="487.68" y="363.22"/>
<pinref part="C31" gate="G$1" pin="1"/>
<wire x1="497.84" y1="363.22" x2="487.68" y2="363.22" width="0.1524" layer="91"/>
<junction x="497.84" y="363.22"/>
<pinref part="C32" gate="G$1" pin="1"/>
<wire x1="497.84" y1="363.22" x2="505.46" y2="363.22" width="0.1524" layer="91"/>
<wire x1="505.46" y1="363.22" x2="513.08" y2="363.22" width="0.1524" layer="91"/>
<junction x="505.46" y="363.22"/>
<wire x1="513.08" y1="363.22" x2="518.16" y2="363.22" width="0.1524" layer="91"/>
<wire x1="518.16" y1="363.22" x2="518.16" y2="365.76" width="0.1524" layer="91"/>
<label x="518.16" y="365.76" size="1.778" layer="95"/>
<pinref part="C35" gate="G$1" pin="1"/>
<junction x="513.08" y="363.22"/>
<wire x1="541.02" y1="363.22" x2="518.16" y2="363.22" width="0.1524" layer="91"/>
<junction x="518.16" y="363.22"/>
<pinref part="X14" gate="-1" pin="S"/>
</segment>
</net>
<net name="EN_+3V3_ADAR34" class="0">
<segment>
<pinref part="U7" gate="A" pin="EN"/>
<wire x1="419.1" y1="309.88" x2="414.02" y2="309.88" width="0.1524" layer="91"/>
<label x="414.02" y="292.1" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="309.88" x2="414.02" y2="289.56" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="11"/>
<wire x1="289.56" y1="459.74" x2="289.56" y2="462.28" width="0.1524" layer="91"/>
<label x="289.56" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+3V3_ADAR_34" class="0">
<segment>
<pinref part="U$7" gate="A" pin="1"/>
<pinref part="R13" gate="G$1" pin="2"/>
<wire x1="485.14" y1="317.5" x2="487.68" y2="317.5" width="0.1524" layer="91"/>
<junction x="487.68" y="317.5"/>
<pinref part="C37" gate="G$1" pin="1"/>
<wire x1="497.84" y1="317.5" x2="487.68" y2="317.5" width="0.1524" layer="91"/>
<junction x="497.84" y="317.5"/>
<pinref part="C38" gate="G$1" pin="1"/>
<wire x1="497.84" y1="317.5" x2="505.46" y2="317.5" width="0.1524" layer="91"/>
<wire x1="505.46" y1="317.5" x2="513.08" y2="317.5" width="0.1524" layer="91"/>
<junction x="505.46" y="317.5"/>
<wire x1="513.08" y1="317.5" x2="518.16" y2="317.5" width="0.1524" layer="91"/>
<wire x1="518.16" y1="317.5" x2="518.16" y2="320.04" width="0.1524" layer="91"/>
<label x="518.16" y="320.04" size="1.778" layer="95"/>
<pinref part="C41" gate="G$1" pin="1"/>
<junction x="513.08" y="317.5"/>
<wire x1="543.56" y1="317.5" x2="518.16" y2="317.5" width="0.1524" layer="91"/>
<junction x="518.16" y="317.5"/>
<pinref part="X15" gate="-1" pin="S"/>
</segment>
</net>
<net name="EN_+3V3_ADTR" class="0">
<segment>
<pinref part="SV1" gate="G$1" pin="13"/>
<wire x1="287.02" y1="459.74" x2="287.02" y2="462.28" width="0.1524" layer="91"/>
<label x="287.02" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
<segment>
<pinref part="U32" gate="A" pin="EN"/>
<wire x1="635" y1="248.92" x2="637.54" y2="248.92" width="0.1524" layer="91"/>
<label x="637.54" y="248.92" size="1.778" layer="95"/>
</segment>
</net>
<net name="EN_+3V3_SW" class="0">
<segment>
<pinref part="U10" gate="A" pin="EN"/>
<wire x1="419.1" y1="205.74" x2="414.02" y2="205.74" width="0.1524" layer="91"/>
<label x="414.02" y="187.96" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="182.88" x2="414.02" y2="205.74" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="15"/>
<wire x1="284.48" y1="459.74" x2="284.48" y2="462.28" width="0.1524" layer="91"/>
<label x="284.48" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+3V3_SW" class="0">
<segment>
<pinref part="U$10" gate="A" pin="1"/>
<pinref part="R19" gate="G$1" pin="2"/>
<wire x1="485.14" y1="213.36" x2="487.68" y2="213.36" width="0.1524" layer="91"/>
<junction x="487.68" y="213.36"/>
<pinref part="C55" gate="G$1" pin="1"/>
<wire x1="497.84" y1="213.36" x2="487.68" y2="213.36" width="0.1524" layer="91"/>
<junction x="497.84" y="213.36"/>
<pinref part="C56" gate="G$1" pin="1"/>
<wire x1="497.84" y1="213.36" x2="505.46" y2="213.36" width="0.1524" layer="91"/>
<wire x1="505.46" y1="213.36" x2="513.08" y2="213.36" width="0.1524" layer="91"/>
<junction x="505.46" y="213.36"/>
<wire x1="513.08" y1="213.36" x2="518.16" y2="213.36" width="0.1524" layer="91"/>
<wire x1="518.16" y1="213.36" x2="518.16" y2="215.9" width="0.1524" layer="91"/>
<label x="518.16" y="215.9" size="1.778" layer="95"/>
<pinref part="C59" gate="G$1" pin="1"/>
<junction x="513.08" y="213.36"/>
<wire x1="535.94" y1="213.36" x2="518.16" y2="213.36" width="0.1524" layer="91"/>
<junction x="518.16" y="213.36"/>
<pinref part="X29" gate="-1" pin="S"/>
</segment>
<segment>
<pinref part="U18" gate="A" pin="V+"/>
<wire x1="627.38" y1="210.82" x2="645.16" y2="210.82" width="0.1524" layer="91"/>
<label x="645.16" y="210.82" size="1.778" layer="95"/>
</segment>
</net>
<net name="EN_+3V3_VDD_SW" class="0">
<segment>
<pinref part="U8" gate="A" pin="EN"/>
<wire x1="419.1" y1="157.48" x2="414.02" y2="157.48" width="0.1524" layer="91"/>
<label x="414.02" y="139.7" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="157.48" x2="414.02" y2="137.16" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="17"/>
<wire x1="281.94" y1="459.74" x2="281.94" y2="462.28" width="0.1524" layer="91"/>
<label x="281.94" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+3V3_VDD_SW" class="0">
<segment>
<pinref part="U$8" gate="A" pin="1"/>
<pinref part="R15" gate="G$1" pin="2"/>
<wire x1="485.14" y1="165.1" x2="487.68" y2="165.1" width="0.1524" layer="91"/>
<junction x="487.68" y="165.1"/>
<pinref part="C43" gate="G$1" pin="1"/>
<wire x1="497.84" y1="165.1" x2="487.68" y2="165.1" width="0.1524" layer="91"/>
<junction x="497.84" y="165.1"/>
<pinref part="C44" gate="G$1" pin="1"/>
<wire x1="497.84" y1="165.1" x2="505.46" y2="165.1" width="0.1524" layer="91"/>
<wire x1="505.46" y1="165.1" x2="513.08" y2="165.1" width="0.1524" layer="91"/>
<junction x="505.46" y="165.1"/>
<wire x1="513.08" y1="165.1" x2="518.16" y2="165.1" width="0.1524" layer="91"/>
<wire x1="518.16" y1="165.1" x2="518.16" y2="167.64" width="0.1524" layer="91"/>
<label x="518.16" y="167.64" size="1.778" layer="95"/>
<pinref part="C47" gate="G$1" pin="1"/>
<junction x="513.08" y="165.1"/>
<wire x1="543.56" y1="165.1" x2="518.16" y2="165.1" width="0.1524" layer="91"/>
<junction x="518.16" y="165.1"/>
<pinref part="X30" gate="-1" pin="S"/>
</segment>
</net>
<net name="N$31" class="0">
<segment>
<pinref part="U11" gate="A" pin="SW"/>
<pinref part="U$11" gate="A" pin="2"/>
<wire x1="454.66" y1="472.44" x2="464.82" y2="472.44" width="0.1524" layer="91"/>
<pinref part="C60" gate="G$1" pin="2"/>
<wire x1="464.82" y1="472.44" x2="469.9" y2="472.44" width="0.1524" layer="91"/>
<wire x1="464.82" y1="464.82" x2="464.82" y2="472.44" width="0.1524" layer="91"/>
<junction x="464.82" y="472.44"/>
</segment>
</net>
<net name="N$32" class="0">
<segment>
<pinref part="C60" gate="G$1" pin="1"/>
<pinref part="U11" gate="A" pin="VBST"/>
<wire x1="457.2" y1="464.82" x2="454.66" y2="464.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$33" class="0">
<segment>
<pinref part="R21" gate="G$1" pin="1"/>
<pinref part="R22" gate="G$1" pin="2"/>
<wire x1="487.68" y1="462.28" x2="487.68" y2="459.74" width="0.1524" layer="91"/>
<wire x1="487.68" y1="459.74" x2="469.9" y2="459.74" width="0.1524" layer="91"/>
<junction x="487.68" y="459.74"/>
<wire x1="469.9" y1="459.74" x2="469.9" y2="454.66" width="0.1524" layer="91"/>
<pinref part="U11" gate="A" pin="VFB"/>
<wire x1="469.9" y1="454.66" x2="454.66" y2="454.66" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V4" class="0">
<segment>
<pinref part="U$11" gate="A" pin="1"/>
<pinref part="R21" gate="G$1" pin="2"/>
<wire x1="485.14" y1="472.44" x2="487.68" y2="472.44" width="0.1524" layer="91"/>
<junction x="487.68" y="472.44"/>
<pinref part="C61" gate="G$1" pin="1"/>
<wire x1="497.84" y1="472.44" x2="487.68" y2="472.44" width="0.1524" layer="91"/>
<junction x="497.84" y="472.44"/>
<pinref part="C62" gate="G$1" pin="1"/>
<wire x1="497.84" y1="472.44" x2="505.46" y2="472.44" width="0.1524" layer="91"/>
<wire x1="505.46" y1="472.44" x2="513.08" y2="472.44" width="0.1524" layer="91"/>
<junction x="505.46" y="472.44"/>
<wire x1="513.08" y1="472.44" x2="518.16" y2="472.44" width="0.1524" layer="91"/>
<wire x1="518.16" y1="472.44" x2="518.16" y2="474.98" width="0.1524" layer="91"/>
<label x="518.16" y="474.98" size="1.778" layer="95"/>
<pinref part="C65" gate="G$1" pin="1"/>
<junction x="513.08" y="472.44"/>
<pinref part="X23" gate="-1" pin="S"/>
<wire x1="528.32" y1="472.44" x2="518.16" y2="472.44" width="0.1524" layer="91"/>
<junction x="518.16" y="472.44"/>
</segment>
<segment>
<pinref part="U19" gate="A" pin="V+"/>
<wire x1="619.76" y1="469.9" x2="637.54" y2="469.9" width="0.1524" layer="91"/>
<label x="637.54" y="469.9" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$34" class="0">
<segment>
<pinref part="U12" gate="A" pin="SW"/>
<pinref part="U$12" gate="A" pin="2"/>
<wire x1="96.52" y1="350.52" x2="106.68" y2="350.52" width="0.1524" layer="91"/>
<pinref part="C66" gate="G$1" pin="2"/>
<wire x1="106.68" y1="350.52" x2="111.76" y2="350.52" width="0.1524" layer="91"/>
<wire x1="106.68" y1="342.9" x2="106.68" y2="350.52" width="0.1524" layer="91"/>
<junction x="106.68" y="350.52"/>
</segment>
</net>
<net name="N$35" class="0">
<segment>
<pinref part="C66" gate="G$1" pin="1"/>
<pinref part="U12" gate="A" pin="VBST"/>
<wire x1="99.06" y1="342.9" x2="96.52" y2="342.9" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$36" class="0">
<segment>
<pinref part="R23" gate="G$1" pin="1"/>
<pinref part="R24" gate="G$1" pin="2"/>
<wire x1="129.54" y1="340.36" x2="129.54" y2="337.82" width="0.1524" layer="91"/>
<wire x1="129.54" y1="337.82" x2="111.76" y2="337.82" width="0.1524" layer="91"/>
<junction x="129.54" y="337.82"/>
<wire x1="111.76" y1="337.82" x2="111.76" y2="332.74" width="0.1524" layer="91"/>
<pinref part="U12" gate="A" pin="VFB"/>
<wire x1="111.76" y1="332.74" x2="96.52" y2="332.74" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+5V0_4" class="0">
<segment>
<pinref part="U$19" gate="A" pin="1"/>
<pinref part="R45" gate="G$1" pin="2"/>
<wire x1="127" y1="101.6" x2="129.54" y2="101.6" width="0.1524" layer="91"/>
<junction x="129.54" y="101.6"/>
<pinref part="C130" gate="G$1" pin="1"/>
<wire x1="139.7" y1="101.6" x2="129.54" y2="101.6" width="0.1524" layer="91"/>
<junction x="139.7" y="101.6"/>
<pinref part="C131" gate="G$1" pin="1"/>
<wire x1="139.7" y1="101.6" x2="147.32" y2="101.6" width="0.1524" layer="91"/>
<wire x1="147.32" y1="101.6" x2="157.48" y2="101.6" width="0.1524" layer="91"/>
<junction x="147.32" y="101.6"/>
<wire x1="157.48" y1="101.6" x2="157.48" y2="104.14" width="0.1524" layer="91"/>
<label x="157.48" y="104.14" size="1.778" layer="95"/>
<pinref part="X25" gate="-1" pin="S"/>
<wire x1="165.1" y1="101.6" x2="157.48" y2="101.6" width="0.1524" layer="91"/>
<junction x="157.48" y="101.6"/>
</segment>
<segment>
<pinref part="U29" gate="A" pin="VIN"/>
<wire x1="302.26" y1="99.06" x2="304.8" y2="99.06" width="0.1524" layer="91"/>
<pinref part="C138" gate="G$1" pin="2"/>
<label x="325.12" y="99.06" size="1.778" layer="95"/>
<pinref part="U29" gate="A" pin="EN"/>
<wire x1="304.8" y1="99.06" x2="337.82" y2="99.06" width="0.1524" layer="91"/>
<wire x1="302.26" y1="96.52" x2="304.8" y2="96.52" width="0.1524" layer="91"/>
<wire x1="304.8" y1="96.52" x2="304.8" y2="99.06" width="0.1524" layer="91"/>
<junction x="304.8" y="99.06"/>
</segment>
</net>
<net name="N$37" class="0">
<segment>
<pinref part="U13" gate="A" pin="SW"/>
<pinref part="U$13" gate="A" pin="2"/>
<wire x1="454.66" y1="416.56" x2="464.82" y2="416.56" width="0.1524" layer="91"/>
<pinref part="C71" gate="G$1" pin="2"/>
<wire x1="464.82" y1="416.56" x2="469.9" y2="416.56" width="0.1524" layer="91"/>
<wire x1="464.82" y1="408.94" x2="464.82" y2="416.56" width="0.1524" layer="91"/>
<junction x="464.82" y="416.56"/>
</segment>
</net>
<net name="N$38" class="0">
<segment>
<pinref part="C71" gate="G$1" pin="1"/>
<pinref part="U13" gate="A" pin="VBST"/>
<wire x1="457.2" y1="408.94" x2="454.66" y2="408.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$39" class="0">
<segment>
<pinref part="R25" gate="G$1" pin="1"/>
<pinref part="R26" gate="G$1" pin="2"/>
<wire x1="487.68" y1="406.4" x2="487.68" y2="403.86" width="0.1524" layer="91"/>
<wire x1="487.68" y1="403.86" x2="469.9" y2="403.86" width="0.1524" layer="91"/>
<junction x="487.68" y="403.86"/>
<wire x1="469.9" y1="403.86" x2="469.9" y2="398.78" width="0.1524" layer="91"/>
<pinref part="U13" gate="A" pin="VFB"/>
<wire x1="469.9" y1="398.78" x2="454.66" y2="398.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="EN_+5V0_ADAR" class="0">
<segment>
<pinref part="U13" gate="A" pin="EN"/>
<wire x1="419.1" y1="408.94" x2="414.02" y2="408.94" width="0.1524" layer="91"/>
<label x="414.02" y="391.16" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="388.62" x2="414.02" y2="408.94" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="7"/>
<wire x1="294.64" y1="459.74" x2="294.64" y2="462.28" width="0.1524" layer="91"/>
<label x="294.64" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+5V0_ADAR" class="0">
<segment>
<pinref part="U$13" gate="A" pin="1"/>
<pinref part="R25" gate="G$1" pin="2"/>
<wire x1="485.14" y1="416.56" x2="487.68" y2="416.56" width="0.1524" layer="91"/>
<junction x="487.68" y="416.56"/>
<pinref part="C72" gate="G$1" pin="1"/>
<wire x1="497.84" y1="416.56" x2="487.68" y2="416.56" width="0.1524" layer="91"/>
<junction x="497.84" y="416.56"/>
<pinref part="C73" gate="G$1" pin="1"/>
<wire x1="497.84" y1="416.56" x2="505.46" y2="416.56" width="0.1524" layer="91"/>
<wire x1="505.46" y1="416.56" x2="518.16" y2="416.56" width="0.1524" layer="91"/>
<junction x="505.46" y="416.56"/>
<wire x1="518.16" y1="416.56" x2="518.16" y2="419.1" width="0.1524" layer="91"/>
<label x="518.16" y="419.1" size="1.778" layer="95"/>
<wire x1="530.86" y1="416.56" x2="518.16" y2="416.56" width="0.1524" layer="91"/>
<junction x="518.16" y="416.56"/>
<pinref part="X13" gate="-1" pin="S"/>
</segment>
<segment>
<pinref part="U20" gate="A" pin="V+"/>
<wire x1="629.92" y1="431.8" x2="647.7" y2="431.8" width="0.1524" layer="91"/>
<label x="647.7" y="431.8" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U21" gate="A" pin="V+"/>
<wire x1="629.92" y1="398.78" x2="647.7" y2="398.78" width="0.1524" layer="91"/>
<label x="647.7" y="398.78" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$40" class="0">
<segment>
<pinref part="U14" gate="A" pin="SW"/>
<pinref part="U$14" gate="A" pin="2"/>
<wire x1="454.66" y1="121.92" x2="464.82" y2="121.92" width="0.1524" layer="91"/>
<pinref part="C77" gate="G$1" pin="2"/>
<wire x1="464.82" y1="121.92" x2="469.9" y2="121.92" width="0.1524" layer="91"/>
<wire x1="464.82" y1="114.3" x2="464.82" y2="121.92" width="0.1524" layer="91"/>
<junction x="464.82" y="121.92"/>
</segment>
</net>
<net name="N$41" class="0">
<segment>
<pinref part="C77" gate="G$1" pin="1"/>
<pinref part="U14" gate="A" pin="VBST"/>
<wire x1="457.2" y1="114.3" x2="454.66" y2="114.3" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$42" class="0">
<segment>
<pinref part="R27" gate="G$1" pin="1"/>
<pinref part="R28" gate="G$1" pin="2"/>
<wire x1="487.68" y1="111.76" x2="487.68" y2="109.22" width="0.1524" layer="91"/>
<wire x1="487.68" y1="109.22" x2="469.9" y2="109.22" width="0.1524" layer="91"/>
<junction x="487.68" y="109.22"/>
<wire x1="469.9" y1="109.22" x2="469.9" y2="104.14" width="0.1524" layer="91"/>
<pinref part="U14" gate="A" pin="VFB"/>
<wire x1="469.9" y1="104.14" x2="454.66" y2="104.14" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$43" class="0">
<segment>
<pinref part="U15" gate="A" pin="SW"/>
<pinref part="U$15" gate="A" pin="2"/>
<wire x1="454.66" y1="78.74" x2="464.82" y2="78.74" width="0.1524" layer="91"/>
<pinref part="C83" gate="G$1" pin="2"/>
<wire x1="464.82" y1="78.74" x2="469.9" y2="78.74" width="0.1524" layer="91"/>
<wire x1="464.82" y1="71.12" x2="464.82" y2="78.74" width="0.1524" layer="91"/>
<junction x="464.82" y="78.74"/>
</segment>
</net>
<net name="N$44" class="0">
<segment>
<pinref part="C83" gate="G$1" pin="1"/>
<pinref part="U15" gate="A" pin="VBST"/>
<wire x1="457.2" y1="71.12" x2="454.66" y2="71.12" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$45" class="0">
<segment>
<pinref part="R29" gate="G$1" pin="1"/>
<pinref part="R30" gate="G$1" pin="2"/>
<wire x1="487.68" y1="68.58" x2="487.68" y2="66.04" width="0.1524" layer="91"/>
<wire x1="487.68" y1="66.04" x2="469.9" y2="66.04" width="0.1524" layer="91"/>
<junction x="487.68" y="66.04"/>
<wire x1="469.9" y1="66.04" x2="469.9" y2="60.96" width="0.1524" layer="91"/>
<pinref part="U15" gate="A" pin="VFB"/>
<wire x1="469.9" y1="60.96" x2="454.66" y2="60.96" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$46" class="0">
<segment>
<pinref part="U16" gate="A" pin="SW"/>
<pinref part="U$16" gate="A" pin="2"/>
<wire x1="454.66" y1="35.56" x2="464.82" y2="35.56" width="0.1524" layer="91"/>
<pinref part="C89" gate="G$1" pin="2"/>
<wire x1="464.82" y1="35.56" x2="469.9" y2="35.56" width="0.1524" layer="91"/>
<wire x1="464.82" y1="27.94" x2="464.82" y2="35.56" width="0.1524" layer="91"/>
<junction x="464.82" y="35.56"/>
</segment>
</net>
<net name="N$47" class="0">
<segment>
<pinref part="C89" gate="G$1" pin="1"/>
<pinref part="U16" gate="A" pin="VBST"/>
<wire x1="457.2" y1="27.94" x2="454.66" y2="27.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$48" class="0">
<segment>
<pinref part="R31" gate="G$1" pin="1"/>
<pinref part="R32" gate="G$1" pin="2"/>
<wire x1="487.68" y1="25.4" x2="487.68" y2="22.86" width="0.1524" layer="91"/>
<wire x1="487.68" y1="22.86" x2="469.9" y2="22.86" width="0.1524" layer="91"/>
<junction x="487.68" y="22.86"/>
<wire x1="469.9" y1="22.86" x2="469.9" y2="17.78" width="0.1524" layer="91"/>
<pinref part="U16" gate="A" pin="VFB"/>
<wire x1="469.9" y1="17.78" x2="454.66" y2="17.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="EN_+5V0_PA1" class="0">
<segment>
<pinref part="U14" gate="A" pin="EN"/>
<wire x1="419.1" y1="114.3" x2="414.02" y2="114.3" width="0.1524" layer="91"/>
<label x="414.02" y="96.52" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="91.44" x2="414.02" y2="114.3" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="19"/>
<wire x1="279.4" y1="459.74" x2="279.4" y2="462.28" width="0.1524" layer="91"/>
<label x="279.4" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="+5V0_PA_1" class="0">
<segment>
<pinref part="U$14" gate="A" pin="1"/>
<pinref part="R27" gate="G$1" pin="2"/>
<wire x1="485.14" y1="121.92" x2="487.68" y2="121.92" width="0.1524" layer="91"/>
<junction x="487.68" y="121.92"/>
<pinref part="C78" gate="G$1" pin="1"/>
<wire x1="497.84" y1="121.92" x2="487.68" y2="121.92" width="0.1524" layer="91"/>
<junction x="497.84" y="121.92"/>
<pinref part="C79" gate="G$1" pin="1"/>
<wire x1="497.84" y1="121.92" x2="505.46" y2="121.92" width="0.1524" layer="91"/>
<wire x1="505.46" y1="121.92" x2="518.16" y2="121.92" width="0.1524" layer="91"/>
<junction x="505.46" y="121.92"/>
<wire x1="518.16" y1="121.92" x2="518.16" y2="124.46" width="0.1524" layer="91"/>
<label x="518.16" y="124.46" size="1.778" layer="95"/>
<wire x1="533.4" y1="121.92" x2="518.16" y2="121.92" width="0.1524" layer="91"/>
<junction x="518.16" y="121.92"/>
<pinref part="X31" gate="-1" pin="S"/>
</segment>
</net>
<net name="EN_+5V0_PA2" class="0">
<segment>
<pinref part="U15" gate="A" pin="EN"/>
<wire x1="419.1" y1="71.12" x2="414.02" y2="71.12" width="0.1524" layer="91"/>
<label x="414.02" y="53.34" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="50.8" x2="414.02" y2="71.12" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="2"/>
<wire x1="302.26" y1="444.5" x2="302.26" y2="441.96" width="0.1524" layer="91"/>
<label x="302.26" y="441.96" size="1.778" layer="95" rot="R270"/>
</segment>
</net>
<net name="+5V0_PA_2" class="0">
<segment>
<pinref part="U$15" gate="A" pin="1"/>
<pinref part="R29" gate="G$1" pin="2"/>
<wire x1="485.14" y1="78.74" x2="487.68" y2="78.74" width="0.1524" layer="91"/>
<junction x="487.68" y="78.74"/>
<pinref part="C84" gate="G$1" pin="1"/>
<wire x1="497.84" y1="78.74" x2="487.68" y2="78.74" width="0.1524" layer="91"/>
<junction x="497.84" y="78.74"/>
<pinref part="C85" gate="G$1" pin="1"/>
<wire x1="497.84" y1="78.74" x2="505.46" y2="78.74" width="0.1524" layer="91"/>
<wire x1="505.46" y1="78.74" x2="518.16" y2="78.74" width="0.1524" layer="91"/>
<junction x="505.46" y="78.74"/>
<wire x1="518.16" y1="78.74" x2="518.16" y2="81.28" width="0.1524" layer="91"/>
<label x="518.16" y="81.28" size="1.778" layer="95"/>
<wire x1="535.94" y1="78.74" x2="518.16" y2="78.74" width="0.1524" layer="91"/>
<junction x="518.16" y="78.74"/>
<pinref part="X32" gate="-1" pin="S"/>
</segment>
</net>
<net name="EN_+5V0_PA3" class="0">
<segment>
<pinref part="U16" gate="A" pin="EN"/>
<wire x1="419.1" y1="27.94" x2="414.02" y2="27.94" width="0.1524" layer="91"/>
<label x="414.02" y="10.16" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="7.62" x2="414.02" y2="27.94" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="4"/>
<wire x1="299.72" y1="444.5" x2="299.72" y2="441.96" width="0.1524" layer="91"/>
<label x="299.72" y="441.96" size="1.778" layer="95" rot="R270"/>
</segment>
</net>
<net name="+5V0_PA_3" class="0">
<segment>
<pinref part="U$16" gate="A" pin="1"/>
<pinref part="R31" gate="G$1" pin="2"/>
<wire x1="485.14" y1="35.56" x2="487.68" y2="35.56" width="0.1524" layer="91"/>
<junction x="487.68" y="35.56"/>
<pinref part="C90" gate="G$1" pin="1"/>
<wire x1="497.84" y1="35.56" x2="487.68" y2="35.56" width="0.1524" layer="91"/>
<junction x="497.84" y="35.56"/>
<pinref part="C91" gate="G$1" pin="1"/>
<wire x1="497.84" y1="35.56" x2="505.46" y2="35.56" width="0.1524" layer="91"/>
<wire x1="505.46" y1="35.56" x2="518.16" y2="35.56" width="0.1524" layer="91"/>
<junction x="505.46" y="35.56"/>
<wire x1="518.16" y1="35.56" x2="518.16" y2="38.1" width="0.1524" layer="91"/>
<label x="518.16" y="38.1" size="1.778" layer="95"/>
<wire x1="538.48" y1="35.56" x2="518.16" y2="35.56" width="0.1524" layer="91"/>
<junction x="518.16" y="35.56"/>
<pinref part="X33" gate="-1" pin="S"/>
</segment>
</net>
<net name="N$49" class="0">
<segment>
<pinref part="U17" gate="A" pin="SW"/>
<pinref part="U$17" gate="A" pin="2"/>
<wire x1="454.66" y1="523.24" x2="464.82" y2="523.24" width="0.1524" layer="91"/>
<pinref part="C76" gate="G$1" pin="2"/>
<wire x1="464.82" y1="523.24" x2="469.9" y2="523.24" width="0.1524" layer="91"/>
<wire x1="464.82" y1="515.62" x2="464.82" y2="523.24" width="0.1524" layer="91"/>
<junction x="464.82" y="523.24"/>
</segment>
</net>
<net name="N$50" class="0">
<segment>
<pinref part="C76" gate="G$1" pin="1"/>
<pinref part="U17" gate="A" pin="VBST"/>
<wire x1="457.2" y1="515.62" x2="454.66" y2="515.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$51" class="0">
<segment>
<pinref part="R33" gate="G$1" pin="1"/>
<pinref part="R34" gate="G$1" pin="2"/>
<wire x1="487.68" y1="513.08" x2="487.68" y2="510.54" width="0.1524" layer="91"/>
<wire x1="487.68" y1="510.54" x2="469.9" y2="510.54" width="0.1524" layer="91"/>
<junction x="487.68" y="510.54"/>
<wire x1="469.9" y1="510.54" x2="469.9" y2="505.46" width="0.1524" layer="91"/>
<pinref part="U17" gate="A" pin="VFB"/>
<wire x1="469.9" y1="505.46" x2="454.66" y2="505.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="EN_+5V5_PA" class="0">
<segment>
<pinref part="U17" gate="A" pin="EN"/>
<wire x1="419.1" y1="515.62" x2="414.02" y2="515.62" width="0.1524" layer="91"/>
<label x="414.02" y="497.84" size="1.778" layer="95" rot="R90"/>
<wire x1="414.02" y1="492.76" x2="414.02" y2="515.62" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SV1" gate="G$1" pin="6"/>
<wire x1="297.18" y1="444.5" x2="297.18" y2="441.96" width="0.1524" layer="91"/>
<label x="297.18" y="441.96" size="1.778" layer="95" rot="R270"/>
</segment>
</net>
<net name="+5V5_PA" class="0">
<segment>
<pinref part="U$17" gate="A" pin="1"/>
<pinref part="R33" gate="G$1" pin="2"/>
<wire x1="485.14" y1="523.24" x2="487.68" y2="523.24" width="0.1524" layer="91"/>
<junction x="487.68" y="523.24"/>
<pinref part="C82" gate="G$1" pin="1"/>
<wire x1="497.84" y1="523.24" x2="487.68" y2="523.24" width="0.1524" layer="91"/>
<junction x="497.84" y="523.24"/>
<pinref part="C88" gate="G$1" pin="1"/>
<wire x1="497.84" y1="523.24" x2="505.46" y2="523.24" width="0.1524" layer="91"/>
<wire x1="505.46" y1="523.24" x2="518.16" y2="523.24" width="0.1524" layer="91"/>
<junction x="505.46" y="523.24"/>
<wire x1="518.16" y1="523.24" x2="518.16" y2="525.78" width="0.1524" layer="91"/>
<label x="518.16" y="525.78" size="1.778" layer="95"/>
<wire x1="528.32" y1="523.24" x2="518.16" y2="523.24" width="0.1524" layer="91"/>
<junction x="518.16" y="523.24"/>
<pinref part="X3" gate="-1" pin="S"/>
</segment>
<segment>
<pinref part="U22" gate="A" pin="V+"/>
<wire x1="617.22" y1="518.16" x2="635" y2="518.16" width="0.1524" layer="91"/>
<label x="635" y="518.16" size="1.778" layer="95"/>
</segment>
</net>
<net name="-3V3_SW" class="0">
<segment>
<pinref part="U18" gate="A" pin="OUT"/>
<pinref part="C97" gate="G$1" pin="-"/>
<wire x1="627.38" y1="203.2" x2="637.54" y2="203.2" width="0.1524" layer="91"/>
<junction x="637.54" y="203.2"/>
<label x="645.16" y="203.2" size="1.778" layer="95"/>
<pinref part="X18" gate="-1" pin="S"/>
<wire x1="662.94" y1="203.2" x2="637.54" y2="203.2" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$54" class="0">
<segment>
<pinref part="C96" gate="G$1" pin="+"/>
<wire x1="558.8" y1="213.36" x2="566.42" y2="213.36" width="0.1524" layer="91"/>
<wire x1="566.42" y1="213.36" x2="566.42" y2="208.28" width="0.1524" layer="91"/>
<pinref part="U18" gate="A" pin="C1+"/>
<wire x1="566.42" y1="208.28" x2="576.58" y2="208.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$55" class="0">
<segment>
<pinref part="U18" gate="A" pin="C1-"/>
<wire x1="576.58" y1="203.2" x2="566.42" y2="203.2" width="0.1524" layer="91"/>
<wire x1="566.42" y1="203.2" x2="566.42" y2="200.66" width="0.1524" layer="91"/>
<pinref part="C96" gate="G$1" pin="-"/>
<wire x1="566.42" y1="200.66" x2="558.8" y2="200.66" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$52" class="0">
<segment>
<pinref part="C98" gate="G$1" pin="+"/>
<wire x1="551.18" y1="472.44" x2="558.8" y2="472.44" width="0.1524" layer="91"/>
<wire x1="558.8" y1="472.44" x2="558.8" y2="467.36" width="0.1524" layer="91"/>
<pinref part="U19" gate="A" pin="C1+"/>
<wire x1="558.8" y1="467.36" x2="568.96" y2="467.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$53" class="0">
<segment>
<pinref part="U19" gate="A" pin="C1-"/>
<wire x1="568.96" y1="462.28" x2="558.8" y2="462.28" width="0.1524" layer="91"/>
<wire x1="558.8" y1="462.28" x2="558.8" y2="459.74" width="0.1524" layer="91"/>
<pinref part="C98" gate="G$1" pin="-"/>
<wire x1="558.8" y1="459.74" x2="551.18" y2="459.74" width="0.1524" layer="91"/>
</segment>
</net>
<net name="-3V4" class="0">
<segment>
<pinref part="U19" gate="A" pin="OUT"/>
<pinref part="C99" gate="G$1" pin="-"/>
<wire x1="619.76" y1="462.28" x2="629.92" y2="462.28" width="0.1524" layer="91"/>
<junction x="629.92" y="462.28"/>
<label x="637.54" y="462.28" size="1.778" layer="95"/>
<pinref part="X24" gate="-1" pin="S"/>
<wire x1="655.32" y1="462.28" x2="629.92" y2="462.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$56" class="0">
<segment>
<pinref part="C100" gate="G$1" pin="+"/>
<wire x1="561.34" y1="434.34" x2="568.96" y2="434.34" width="0.1524" layer="91"/>
<wire x1="568.96" y1="434.34" x2="568.96" y2="429.26" width="0.1524" layer="91"/>
<pinref part="U20" gate="A" pin="C1+"/>
<wire x1="568.96" y1="429.26" x2="579.12" y2="429.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$57" class="0">
<segment>
<pinref part="U20" gate="A" pin="C1-"/>
<wire x1="579.12" y1="424.18" x2="568.96" y2="424.18" width="0.1524" layer="91"/>
<wire x1="568.96" y1="424.18" x2="568.96" y2="421.64" width="0.1524" layer="91"/>
<pinref part="C100" gate="G$1" pin="-"/>
<wire x1="568.96" y1="421.64" x2="561.34" y2="421.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$58" class="0">
<segment>
<pinref part="C102" gate="G$1" pin="+"/>
<wire x1="561.34" y1="401.32" x2="568.96" y2="401.32" width="0.1524" layer="91"/>
<wire x1="568.96" y1="401.32" x2="568.96" y2="396.24" width="0.1524" layer="91"/>
<pinref part="U21" gate="A" pin="C1+"/>
<wire x1="568.96" y1="396.24" x2="579.12" y2="396.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$59" class="0">
<segment>
<pinref part="U21" gate="A" pin="C1-"/>
<wire x1="579.12" y1="391.16" x2="568.96" y2="391.16" width="0.1524" layer="91"/>
<wire x1="568.96" y1="391.16" x2="568.96" y2="388.62" width="0.1524" layer="91"/>
<pinref part="C102" gate="G$1" pin="-"/>
<wire x1="568.96" y1="388.62" x2="561.34" y2="388.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="-5V0_ADAR12" class="0">
<segment>
<pinref part="U20" gate="A" pin="OUT"/>
<pinref part="C101" gate="G$1" pin="-"/>
<wire x1="629.92" y1="424.18" x2="640.08" y2="424.18" width="0.1524" layer="91"/>
<junction x="640.08" y="424.18"/>
<label x="647.7" y="424.18" size="1.778" layer="95"/>
<pinref part="X21" gate="-1" pin="S"/>
<wire x1="673.1" y1="424.18" x2="640.08" y2="424.18" width="0.1524" layer="91"/>
</segment>
</net>
<net name="-5V0_ADAR34" class="0">
<segment>
<pinref part="U21" gate="A" pin="OUT"/>
<pinref part="C103" gate="G$1" pin="-"/>
<wire x1="629.92" y1="391.16" x2="640.08" y2="391.16" width="0.1524" layer="91"/>
<junction x="640.08" y="391.16"/>
<label x="647.7" y="391.16" size="1.778" layer="95"/>
<pinref part="X20" gate="-1" pin="S"/>
<wire x1="673.1" y1="391.16" x2="640.08" y2="391.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$60" class="0">
<segment>
<pinref part="C104" gate="G$1" pin="+"/>
<wire x1="548.64" y1="520.7" x2="556.26" y2="520.7" width="0.1524" layer="91"/>
<wire x1="556.26" y1="520.7" x2="556.26" y2="515.62" width="0.1524" layer="91"/>
<pinref part="U22" gate="A" pin="C1+"/>
<wire x1="556.26" y1="515.62" x2="566.42" y2="515.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$61" class="0">
<segment>
<pinref part="U22" gate="A" pin="C1-"/>
<wire x1="566.42" y1="510.54" x2="556.26" y2="510.54" width="0.1524" layer="91"/>
<wire x1="556.26" y1="510.54" x2="556.26" y2="508" width="0.1524" layer="91"/>
<pinref part="C104" gate="G$1" pin="-"/>
<wire x1="556.26" y1="508" x2="548.64" y2="508" width="0.1524" layer="91"/>
</segment>
</net>
<net name="-5V5_PA" class="0">
<segment>
<pinref part="U22" gate="A" pin="OUT"/>
<pinref part="C105" gate="G$1" pin="-"/>
<wire x1="617.22" y1="510.54" x2="627.38" y2="510.54" width="0.1524" layer="91"/>
<junction x="627.38" y="510.54"/>
<label x="635" y="510.54" size="1.778" layer="95"/>
<pinref part="X19" gate="-1" pin="S"/>
<wire x1="650.24" y1="510.54" x2="627.38" y2="510.54" width="0.1524" layer="91"/>
</segment>
</net>
<net name="EN_+1V8_CLOCK" class="0">
<segment>
<pinref part="SV1" gate="G$1" pin="8"/>
<wire x1="294.64" y1="444.5" x2="294.64" y2="441.96" width="0.1524" layer="91"/>
<label x="294.64" y="441.96" size="1.778" layer="95" rot="R270"/>
</segment>
<segment>
<pinref part="U25" gate="A" pin="EN"/>
<wire x1="302.26" y1="246.38" x2="304.8" y2="246.38" width="0.1524" layer="91"/>
<label x="304.8" y="246.38" size="1.778" layer="95"/>
</segment>
</net>
<net name="EN_+3V3_CLOCK" class="0">
<segment>
<pinref part="SV1" gate="G$1" pin="10"/>
<wire x1="292.1" y1="444.5" x2="292.1" y2="441.96" width="0.1524" layer="91"/>
<label x="292.1" y="441.96" size="1.778" layer="95" rot="R270"/>
</segment>
<segment>
<pinref part="U23" gate="A" pin="EN"/>
<wire x1="302.26" y1="297.18" x2="304.8" y2="297.18" width="0.1524" layer="91"/>
<label x="304.8" y="297.18" size="1.778" layer="95"/>
</segment>
</net>
<net name="EN_+1V0_FPGA" class="0">
<segment>
<pinref part="SV1" gate="G$1" pin="1"/>
<wire x1="302.26" y1="459.74" x2="302.26" y2="462.28" width="0.1524" layer="91"/>
<label x="302.26" y="462.28" size="1.778" layer="95" rot="R90"/>
</segment>
<segment>
<pinref part="U1" gate="A" pin="EN"/>
<wire x1="60.96" y1="474.98" x2="55.88" y2="474.98" width="0.1524" layer="91"/>
<label x="55.88" y="457.2" size="1.778" layer="95" rot="R90"/>
<wire x1="55.88" y1="474.98" x2="55.88" y2="454.66" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="U5" gate="A" pin="VREG"/>
<pinref part="C24" gate="G$1" pin="2"/>
<wire x1="251.46" y1="350.52" x2="248.92" y2="350.52" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V3_AN" class="0">
<segment>
<pinref part="U5" gate="A" pin="VOUT"/>
<pinref part="C25" gate="G$1" pin="2"/>
<wire x1="251.46" y1="347.98" x2="226.06" y2="347.98" width="0.1524" layer="91"/>
<junction x="226.06" y="347.98"/>
<label x="208.28" y="347.98" size="1.778" layer="95"/>
<pinref part="X12" gate="-1" pin="S"/>
<wire x1="198.12" y1="347.98" x2="226.06" y2="347.98" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="U5" gate="A" pin="BYP"/>
<pinref part="C26" gate="G$1" pin="2"/>
<wire x1="251.46" y1="345.44" x2="238.76" y2="345.44" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$25" class="0">
<segment>
<pinref part="R9" gate="G$1" pin="1"/>
<pinref part="R10" gate="G$1" pin="2"/>
<pinref part="U5" gate="A" pin="REF_SENSE"/>
<wire x1="302.26" y1="340.36" x2="302.26" y2="332.74" width="0.1524" layer="91"/>
<wire x1="302.26" y1="332.74" x2="314.96" y2="332.74" width="0.1524" layer="91"/>
<junction x="314.96" y="332.74"/>
</segment>
</net>
<net name="N$27" class="0">
<segment>
<pinref part="U5" gate="A" pin="REF"/>
<pinref part="R9" gate="G$1" pin="2"/>
<wire x1="302.26" y1="342.9" x2="314.96" y2="342.9" width="0.1524" layer="91"/>
<pinref part="C27" gate="G$1" pin="2"/>
<wire x1="330.2" y1="342.9" x2="314.96" y2="342.9" width="0.1524" layer="91"/>
<junction x="314.96" y="342.9"/>
</segment>
</net>
<net name="N$26" class="0">
<segment>
<pinref part="U9" gate="A" pin="SW"/>
<pinref part="U$5" gate="A" pin="2"/>
<wire x1="96.52" y1="302.26" x2="106.68" y2="302.26" width="0.1524" layer="91"/>
<pinref part="C29" gate="G$1" pin="2"/>
<wire x1="106.68" y1="302.26" x2="111.76" y2="302.26" width="0.1524" layer="91"/>
<wire x1="106.68" y1="294.64" x2="106.68" y2="302.26" width="0.1524" layer="91"/>
<junction x="106.68" y="302.26"/>
</segment>
</net>
<net name="N$64" class="0">
<segment>
<pinref part="C29" gate="G$1" pin="1"/>
<pinref part="U9" gate="A" pin="VBST"/>
<wire x1="99.06" y1="294.64" x2="96.52" y2="294.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$65" class="0">
<segment>
<pinref part="R17" gate="G$1" pin="1"/>
<pinref part="R18" gate="G$1" pin="2"/>
<wire x1="129.54" y1="292.1" x2="129.54" y2="289.56" width="0.1524" layer="91"/>
<wire x1="129.54" y1="289.56" x2="111.76" y2="289.56" width="0.1524" layer="91"/>
<junction x="129.54" y="289.56"/>
<wire x1="111.76" y1="289.56" x2="111.76" y2="284.48" width="0.1524" layer="91"/>
<pinref part="U9" gate="A" pin="VFB"/>
<wire x1="111.76" y1="284.48" x2="96.52" y2="284.48" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$66" class="0">
<segment>
<pinref part="U23" gate="A" pin="VREG"/>
<pinref part="C52" gate="G$1" pin="2"/>
<wire x1="251.46" y1="302.26" x2="248.92" y2="302.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V3_CLOCK" class="0">
<segment>
<pinref part="U23" gate="A" pin="VOUT"/>
<pinref part="C53" gate="G$1" pin="2"/>
<wire x1="251.46" y1="299.72" x2="226.06" y2="299.72" width="0.1524" layer="91"/>
<junction x="226.06" y="299.72"/>
<label x="203.2" y="299.72" size="1.778" layer="95"/>
<pinref part="X11" gate="-1" pin="S"/>
<wire x1="200.66" y1="299.72" x2="226.06" y2="299.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$68" class="0">
<segment>
<pinref part="U23" gate="A" pin="BYP"/>
<pinref part="C106" gate="G$1" pin="2"/>
<wire x1="251.46" y1="297.18" x2="238.76" y2="297.18" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$69" class="0">
<segment>
<pinref part="R35" gate="G$1" pin="1"/>
<pinref part="R36" gate="G$1" pin="2"/>
<pinref part="U23" gate="A" pin="REF_SENSE"/>
<wire x1="302.26" y1="292.1" x2="302.26" y2="284.48" width="0.1524" layer="91"/>
<wire x1="302.26" y1="284.48" x2="314.96" y2="284.48" width="0.1524" layer="91"/>
<junction x="314.96" y="284.48"/>
</segment>
</net>
<net name="N$70" class="0">
<segment>
<pinref part="U23" gate="A" pin="REF"/>
<pinref part="R35" gate="G$1" pin="2"/>
<wire x1="302.26" y1="294.64" x2="314.96" y2="294.64" width="0.1524" layer="91"/>
<pinref part="C107" gate="G$1" pin="2"/>
<wire x1="330.2" y1="294.64" x2="314.96" y2="294.64" width="0.1524" layer="91"/>
<junction x="314.96" y="294.64"/>
</segment>
</net>
<net name="N$73" class="0">
<segment>
<pinref part="U24" gate="A" pin="SW"/>
<pinref part="U$9" gate="A" pin="2"/>
<wire x1="96.52" y1="251.46" x2="106.68" y2="251.46" width="0.1524" layer="91"/>
<pinref part="C109" gate="G$1" pin="2"/>
<wire x1="106.68" y1="251.46" x2="111.76" y2="251.46" width="0.1524" layer="91"/>
<wire x1="106.68" y1="243.84" x2="106.68" y2="251.46" width="0.1524" layer="91"/>
<junction x="106.68" y="251.46"/>
</segment>
</net>
<net name="N$74" class="0">
<segment>
<pinref part="C109" gate="G$1" pin="1"/>
<pinref part="U24" gate="A" pin="VBST"/>
<wire x1="99.06" y1="243.84" x2="96.52" y2="243.84" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$75" class="0">
<segment>
<pinref part="R37" gate="G$1" pin="1"/>
<pinref part="R38" gate="G$1" pin="2"/>
<wire x1="129.54" y1="241.3" x2="129.54" y2="238.76" width="0.1524" layer="91"/>
<wire x1="129.54" y1="238.76" x2="111.76" y2="238.76" width="0.1524" layer="91"/>
<junction x="129.54" y="238.76"/>
<wire x1="111.76" y1="238.76" x2="111.76" y2="233.68" width="0.1524" layer="91"/>
<pinref part="U24" gate="A" pin="VFB"/>
<wire x1="111.76" y1="233.68" x2="96.52" y2="233.68" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$76" class="0">
<segment>
<pinref part="U25" gate="A" pin="VREG"/>
<pinref part="C114" gate="G$1" pin="2"/>
<wire x1="251.46" y1="251.46" x2="248.92" y2="251.46" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+1V8_CLOCK" class="0">
<segment>
<pinref part="U25" gate="A" pin="VOUT"/>
<pinref part="C115" gate="G$1" pin="2"/>
<wire x1="251.46" y1="248.92" x2="226.06" y2="248.92" width="0.1524" layer="91"/>
<junction x="226.06" y="248.92"/>
<label x="205.74" y="248.92" size="1.778" layer="95"/>
<pinref part="X10" gate="-1" pin="S"/>
<wire x1="200.66" y1="248.92" x2="226.06" y2="248.92" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$78" class="0">
<segment>
<pinref part="U25" gate="A" pin="BYP"/>
<pinref part="C116" gate="G$1" pin="2"/>
<wire x1="251.46" y1="246.38" x2="238.76" y2="246.38" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$79" class="0">
<segment>
<pinref part="R39" gate="G$1" pin="1"/>
<pinref part="R40" gate="G$1" pin="2"/>
<pinref part="U25" gate="A" pin="REF_SENSE"/>
<wire x1="302.26" y1="241.3" x2="302.26" y2="233.68" width="0.1524" layer="91"/>
<wire x1="302.26" y1="233.68" x2="314.96" y2="233.68" width="0.1524" layer="91"/>
<junction x="314.96" y="233.68"/>
</segment>
</net>
<net name="N$80" class="0">
<segment>
<pinref part="U25" gate="A" pin="REF"/>
<pinref part="R39" gate="G$1" pin="2"/>
<wire x1="302.26" y1="243.84" x2="314.96" y2="243.84" width="0.1524" layer="91"/>
<pinref part="C117" gate="G$1" pin="2"/>
<wire x1="330.2" y1="243.84" x2="314.96" y2="243.84" width="0.1524" layer="91"/>
<junction x="314.96" y="243.84"/>
</segment>
</net>
<net name="N$83" class="0">
<segment>
<pinref part="U26" gate="A" pin="SW"/>
<pinref part="U$18" gate="A" pin="2"/>
<wire x1="96.52" y1="152.4" x2="106.68" y2="152.4" width="0.1524" layer="91"/>
<pinref part="C119" gate="G$1" pin="2"/>
<wire x1="106.68" y1="152.4" x2="111.76" y2="152.4" width="0.1524" layer="91"/>
<wire x1="106.68" y1="144.78" x2="106.68" y2="152.4" width="0.1524" layer="91"/>
<junction x="106.68" y="152.4"/>
</segment>
</net>
<net name="N$84" class="0">
<segment>
<pinref part="C119" gate="G$1" pin="1"/>
<pinref part="U26" gate="A" pin="VBST"/>
<wire x1="99.06" y1="144.78" x2="96.52" y2="144.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$85" class="0">
<segment>
<pinref part="R41" gate="G$1" pin="1"/>
<pinref part="R42" gate="G$1" pin="2"/>
<wire x1="129.54" y1="142.24" x2="129.54" y2="139.7" width="0.1524" layer="91"/>
<wire x1="129.54" y1="139.7" x2="111.76" y2="139.7" width="0.1524" layer="91"/>
<junction x="129.54" y="139.7"/>
<wire x1="111.76" y1="139.7" x2="111.76" y2="134.62" width="0.1524" layer="91"/>
<pinref part="U26" gate="A" pin="VFB"/>
<wire x1="111.76" y1="134.62" x2="96.52" y2="134.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$86" class="0">
<segment>
<pinref part="U27" gate="A" pin="VREG"/>
<pinref part="C124" gate="G$1" pin="2"/>
<wire x1="251.46" y1="152.4" x2="248.92" y2="152.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V3_LO_1" class="0">
<segment>
<pinref part="U27" gate="A" pin="VOUT"/>
<pinref part="C125" gate="G$1" pin="2"/>
<wire x1="251.46" y1="149.86" x2="226.06" y2="149.86" width="0.1524" layer="91"/>
<junction x="226.06" y="149.86"/>
<label x="203.2" y="149.86" size="1.778" layer="95"/>
<pinref part="X8" gate="-1" pin="S"/>
<wire x1="226.06" y1="149.86" x2="200.66" y2="149.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$88" class="0">
<segment>
<pinref part="U27" gate="A" pin="BYP"/>
<pinref part="C126" gate="G$1" pin="2"/>
<wire x1="251.46" y1="147.32" x2="238.76" y2="147.32" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$89" class="0">
<segment>
<pinref part="R43" gate="G$1" pin="1"/>
<pinref part="R44" gate="G$1" pin="2"/>
<pinref part="U27" gate="A" pin="REF_SENSE"/>
<wire x1="302.26" y1="142.24" x2="302.26" y2="134.62" width="0.1524" layer="91"/>
<wire x1="302.26" y1="134.62" x2="314.96" y2="134.62" width="0.1524" layer="91"/>
<junction x="314.96" y="134.62"/>
</segment>
</net>
<net name="N$90" class="0">
<segment>
<pinref part="U27" gate="A" pin="REF"/>
<pinref part="R43" gate="G$1" pin="2"/>
<wire x1="302.26" y1="144.78" x2="314.96" y2="144.78" width="0.1524" layer="91"/>
<pinref part="C127" gate="G$1" pin="2"/>
<wire x1="330.2" y1="144.78" x2="314.96" y2="144.78" width="0.1524" layer="91"/>
<junction x="314.96" y="144.78"/>
</segment>
</net>
<net name="N$93" class="0">
<segment>
<pinref part="U28" gate="A" pin="SW"/>
<pinref part="U$19" gate="A" pin="2"/>
<wire x1="96.52" y1="101.6" x2="106.68" y2="101.6" width="0.1524" layer="91"/>
<pinref part="C129" gate="G$1" pin="2"/>
<wire x1="106.68" y1="101.6" x2="111.76" y2="101.6" width="0.1524" layer="91"/>
<wire x1="106.68" y1="93.98" x2="106.68" y2="101.6" width="0.1524" layer="91"/>
<junction x="106.68" y="101.6"/>
</segment>
</net>
<net name="N$94" class="0">
<segment>
<pinref part="C129" gate="G$1" pin="1"/>
<pinref part="U28" gate="A" pin="VBST"/>
<wire x1="99.06" y1="93.98" x2="96.52" y2="93.98" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$95" class="0">
<segment>
<pinref part="R45" gate="G$1" pin="1"/>
<pinref part="R46" gate="G$1" pin="2"/>
<wire x1="129.54" y1="91.44" x2="129.54" y2="88.9" width="0.1524" layer="91"/>
<wire x1="129.54" y1="88.9" x2="111.76" y2="88.9" width="0.1524" layer="91"/>
<junction x="129.54" y="88.9"/>
<wire x1="111.76" y1="88.9" x2="111.76" y2="83.82" width="0.1524" layer="91"/>
<pinref part="U28" gate="A" pin="VFB"/>
<wire x1="111.76" y1="83.82" x2="96.52" y2="83.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$96" class="0">
<segment>
<pinref part="U29" gate="A" pin="VREG"/>
<pinref part="C134" gate="G$1" pin="2"/>
<wire x1="251.46" y1="101.6" x2="248.92" y2="101.6" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+3V3_LO_2" class="0">
<segment>
<pinref part="U29" gate="A" pin="VOUT"/>
<pinref part="C135" gate="G$1" pin="2"/>
<wire x1="251.46" y1="99.06" x2="226.06" y2="99.06" width="0.1524" layer="91"/>
<junction x="226.06" y="99.06"/>
<label x="203.2" y="99.06" size="1.778" layer="95"/>
<pinref part="X7" gate="-1" pin="S"/>
<wire x1="226.06" y1="99.06" x2="200.66" y2="99.06" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$98" class="0">
<segment>
<pinref part="U29" gate="A" pin="BYP"/>
<pinref part="C136" gate="G$1" pin="2"/>
<wire x1="251.46" y1="96.52" x2="238.76" y2="96.52" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$99" class="0">
<segment>
<pinref part="R47" gate="G$1" pin="1"/>
<pinref part="R48" gate="G$1" pin="2"/>
<pinref part="U29" gate="A" pin="REF_SENSE"/>
<wire x1="302.26" y1="91.44" x2="302.26" y2="83.82" width="0.1524" layer="91"/>
<wire x1="302.26" y1="83.82" x2="314.96" y2="83.82" width="0.1524" layer="91"/>
<junction x="314.96" y="83.82"/>
</segment>
</net>
<net name="N$100" class="0">
<segment>
<pinref part="U29" gate="A" pin="REF"/>
<pinref part="R47" gate="G$1" pin="2"/>
<wire x1="302.26" y1="93.98" x2="314.96" y2="93.98" width="0.1524" layer="91"/>
<pinref part="C137" gate="G$1" pin="2"/>
<wire x1="330.2" y1="93.98" x2="314.96" y2="93.98" width="0.1524" layer="91"/>
<junction x="314.96" y="93.98"/>
</segment>
</net>
<net name="+5V0_0" class="0">
<segment>
<pinref part="U$12" gate="A" pin="1"/>
<pinref part="R23" gate="G$1" pin="2"/>
<wire x1="127" y1="350.52" x2="129.54" y2="350.52" width="0.1524" layer="91"/>
<junction x="129.54" y="350.52"/>
<pinref part="C67" gate="G$1" pin="1"/>
<wire x1="139.7" y1="350.52" x2="129.54" y2="350.52" width="0.1524" layer="91"/>
<junction x="139.7" y="350.52"/>
<pinref part="C68" gate="G$1" pin="1"/>
<wire x1="139.7" y1="350.52" x2="147.32" y2="350.52" width="0.1524" layer="91"/>
<wire x1="147.32" y1="350.52" x2="157.48" y2="350.52" width="0.1524" layer="91"/>
<junction x="147.32" y="350.52"/>
<wire x1="157.48" y1="350.52" x2="157.48" y2="353.06" width="0.1524" layer="91"/>
<label x="157.48" y="353.06" size="1.778" layer="95"/>
<pinref part="X22" gate="-1" pin="S"/>
<wire x1="165.1" y1="350.52" x2="157.48" y2="350.52" width="0.1524" layer="91"/>
<junction x="157.48" y="350.52"/>
</segment>
<segment>
<pinref part="U5" gate="A" pin="EN"/>
<wire x1="302.26" y1="345.44" x2="304.8" y2="345.44" width="0.1524" layer="91"/>
<pinref part="U5" gate="A" pin="VIN"/>
<wire x1="302.26" y1="347.98" x2="304.8" y2="347.98" width="0.1524" layer="91"/>
<pinref part="C28" gate="G$1" pin="2"/>
<wire x1="304.8" y1="347.98" x2="337.82" y2="347.98" width="0.1524" layer="91"/>
<wire x1="304.8" y1="345.44" x2="304.8" y2="347.98" width="0.1524" layer="91"/>
<junction x="304.8" y="347.98"/>
<label x="337.82" y="347.98" size="1.778" layer="95"/>
</segment>
</net>
<net name="+5V0_1" class="0">
<segment>
<pinref part="U$5" gate="A" pin="1"/>
<pinref part="R17" gate="G$1" pin="2"/>
<wire x1="127" y1="302.26" x2="129.54" y2="302.26" width="0.1524" layer="91"/>
<junction x="129.54" y="302.26"/>
<pinref part="C48" gate="G$1" pin="1"/>
<wire x1="139.7" y1="302.26" x2="129.54" y2="302.26" width="0.1524" layer="91"/>
<junction x="139.7" y="302.26"/>
<pinref part="C49" gate="G$1" pin="1"/>
<wire x1="139.7" y1="302.26" x2="147.32" y2="302.26" width="0.1524" layer="91"/>
<wire x1="147.32" y1="302.26" x2="157.48" y2="302.26" width="0.1524" layer="91"/>
<junction x="147.32" y="302.26"/>
<wire x1="157.48" y1="302.26" x2="157.48" y2="304.8" width="0.1524" layer="91"/>
<label x="157.48" y="304.8" size="1.778" layer="95"/>
<pinref part="X2" gate="-1" pin="S"/>
<wire x1="165.1" y1="302.26" x2="157.48" y2="302.26" width="0.1524" layer="91"/>
<junction x="157.48" y="302.26"/>
</segment>
<segment>
<pinref part="U23" gate="A" pin="VIN"/>
<wire x1="302.26" y1="299.72" x2="337.82" y2="299.72" width="0.1524" layer="91"/>
<pinref part="C108" gate="G$1" pin="2"/>
<label x="337.82" y="299.72" size="1.778" layer="95"/>
</segment>
</net>
<net name="+5V0_2" class="0">
<segment>
<pinref part="U$9" gate="A" pin="1"/>
<pinref part="R37" gate="G$1" pin="2"/>
<wire x1="127" y1="251.46" x2="129.54" y2="251.46" width="0.1524" layer="91"/>
<junction x="129.54" y="251.46"/>
<pinref part="C110" gate="G$1" pin="1"/>
<wire x1="139.7" y1="251.46" x2="129.54" y2="251.46" width="0.1524" layer="91"/>
<junction x="139.7" y="251.46"/>
<pinref part="C111" gate="G$1" pin="1"/>
<wire x1="139.7" y1="251.46" x2="147.32" y2="251.46" width="0.1524" layer="91"/>
<wire x1="147.32" y1="251.46" x2="157.48" y2="251.46" width="0.1524" layer="91"/>
<junction x="147.32" y="251.46"/>
<wire x1="157.48" y1="251.46" x2="157.48" y2="254" width="0.1524" layer="91"/>
<label x="157.48" y="254" size="1.778" layer="95"/>
<pinref part="X9" gate="-1" pin="S"/>
<wire x1="165.1" y1="251.46" x2="157.48" y2="251.46" width="0.1524" layer="91"/>
<junction x="157.48" y="251.46"/>
</segment>
<segment>
<pinref part="U25" gate="A" pin="VIN"/>
<wire x1="302.26" y1="248.92" x2="337.82" y2="248.92" width="0.1524" layer="91"/>
<pinref part="C118" gate="G$1" pin="2"/>
<label x="337.82" y="248.92" size="1.778" layer="95"/>
</segment>
</net>
<net name="+5V0_3" class="0">
<segment>
<pinref part="U$18" gate="A" pin="1"/>
<pinref part="R41" gate="G$1" pin="2"/>
<wire x1="127" y1="152.4" x2="129.54" y2="152.4" width="0.1524" layer="91"/>
<junction x="129.54" y="152.4"/>
<pinref part="C120" gate="G$1" pin="1"/>
<wire x1="139.7" y1="152.4" x2="129.54" y2="152.4" width="0.1524" layer="91"/>
<junction x="139.7" y="152.4"/>
<pinref part="C121" gate="G$1" pin="1"/>
<wire x1="139.7" y1="152.4" x2="147.32" y2="152.4" width="0.1524" layer="91"/>
<wire x1="147.32" y1="152.4" x2="157.48" y2="152.4" width="0.1524" layer="91"/>
<junction x="147.32" y="152.4"/>
<wire x1="157.48" y1="152.4" x2="157.48" y2="154.94" width="0.1524" layer="91"/>
<label x="157.48" y="154.94" size="1.778" layer="95"/>
<pinref part="X17" gate="-1" pin="S"/>
<wire x1="165.1" y1="152.4" x2="157.48" y2="152.4" width="0.1524" layer="91"/>
<junction x="157.48" y="152.4"/>
</segment>
<segment>
<pinref part="U27" gate="A" pin="VIN"/>
<wire x1="302.26" y1="149.86" x2="304.8" y2="149.86" width="0.1524" layer="91"/>
<pinref part="C128" gate="G$1" pin="2"/>
<label x="332.74" y="149.86" size="1.778" layer="95"/>
<pinref part="U27" gate="A" pin="EN"/>
<wire x1="304.8" y1="149.86" x2="337.82" y2="149.86" width="0.1524" layer="91"/>
<wire x1="302.26" y1="147.32" x2="304.8" y2="147.32" width="0.1524" layer="91"/>
<wire x1="304.8" y1="147.32" x2="304.8" y2="149.86" width="0.1524" layer="91"/>
<junction x="304.8" y="149.86"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="U30" gate="A" pin="VREG"/>
<pinref part="C139" gate="G$1" pin="2"/>
<wire x1="58.42" y1="198.12" x2="55.88" y2="198.12" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$62" class="0">
<segment>
<pinref part="U30" gate="A" pin="BYP"/>
<pinref part="C141" gate="G$1" pin="2"/>
<wire x1="58.42" y1="193.04" x2="45.72" y2="193.04" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$63" class="0">
<segment>
<pinref part="R49" gate="G$1" pin="1"/>
<pinref part="R50" gate="G$1" pin="2"/>
<pinref part="U30" gate="A" pin="REF_SENSE"/>
<wire x1="109.22" y1="187.96" x2="109.22" y2="180.34" width="0.1524" layer="91"/>
<wire x1="109.22" y1="180.34" x2="121.92" y2="180.34" width="0.1524" layer="91"/>
<junction x="121.92" y="180.34"/>
</segment>
</net>
<net name="N$67" class="0">
<segment>
<pinref part="U30" gate="A" pin="REF"/>
<pinref part="R49" gate="G$1" pin="2"/>
<wire x1="109.22" y1="190.5" x2="121.92" y2="190.5" width="0.1524" layer="91"/>
<pinref part="C142" gate="G$1" pin="2"/>
<wire x1="137.16" y1="190.5" x2="121.92" y2="190.5" width="0.1524" layer="91"/>
<junction x="121.92" y="190.5"/>
</segment>
</net>
<net name="+5V0_LO" class="0">
<segment>
<pinref part="U30" gate="A" pin="VOUT"/>
<pinref part="C140" gate="G$1" pin="2"/>
<wire x1="58.42" y1="195.58" x2="33.02" y2="195.58" width="0.1524" layer="91"/>
<wire x1="33.02" y1="195.58" x2="22.86" y2="195.58" width="0.1524" layer="91"/>
<junction x="33.02" y="195.58"/>
<label x="17.78" y="129.54" size="1.778" layer="95"/>
<pinref part="X6" gate="-1" pin="S"/>
<label x="27.94" y="195.58" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="N$71" class="0">
<segment>
<pinref part="U31" gate="A" pin="SW"/>
<pinref part="U$20" gate="A" pin="2"/>
<wire x1="454.66" y1="264.16" x2="464.82" y2="264.16" width="0.1524" layer="91"/>
<pinref part="C144" gate="G$1" pin="2"/>
<wire x1="464.82" y1="264.16" x2="469.9" y2="264.16" width="0.1524" layer="91"/>
<wire x1="464.82" y1="256.54" x2="464.82" y2="264.16" width="0.1524" layer="91"/>
<junction x="464.82" y="264.16"/>
</segment>
</net>
<net name="N$72" class="0">
<segment>
<pinref part="C144" gate="G$1" pin="1"/>
<pinref part="U31" gate="A" pin="VBST"/>
<wire x1="457.2" y1="256.54" x2="454.66" y2="256.54" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$77" class="0">
<segment>
<pinref part="R51" gate="G$1" pin="1"/>
<pinref part="R52" gate="G$1" pin="2"/>
<wire x1="487.68" y1="254" x2="487.68" y2="251.46" width="0.1524" layer="91"/>
<wire x1="487.68" y1="251.46" x2="469.9" y2="251.46" width="0.1524" layer="91"/>
<junction x="487.68" y="251.46"/>
<wire x1="469.9" y1="251.46" x2="469.9" y2="246.38" width="0.1524" layer="91"/>
<pinref part="U31" gate="A" pin="VFB"/>
<wire x1="469.9" y1="246.38" x2="454.66" y2="246.38" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+5V0_ADTR" class="0">
<segment>
<pinref part="U$20" gate="A" pin="1"/>
<pinref part="R51" gate="G$1" pin="2"/>
<wire x1="485.14" y1="264.16" x2="487.68" y2="264.16" width="0.1524" layer="91"/>
<junction x="487.68" y="264.16"/>
<pinref part="C145" gate="G$1" pin="1"/>
<wire x1="497.84" y1="264.16" x2="487.68" y2="264.16" width="0.1524" layer="91"/>
<junction x="497.84" y="264.16"/>
<pinref part="C146" gate="G$1" pin="1"/>
<wire x1="497.84" y1="264.16" x2="505.46" y2="264.16" width="0.1524" layer="91"/>
<wire x1="505.46" y1="264.16" x2="515.62" y2="264.16" width="0.1524" layer="91"/>
<junction x="505.46" y="264.16"/>
<wire x1="515.62" y1="264.16" x2="515.62" y2="266.7" width="0.1524" layer="91"/>
<label x="508" y="266.7" size="1.778" layer="95"/>
<pinref part="X26" gate="-1" pin="S"/>
<wire x1="523.24" y1="264.16" x2="515.62" y2="264.16" width="0.1524" layer="91"/>
<junction x="515.62" y="264.16"/>
</segment>
<segment>
<pinref part="U32" gate="A" pin="IN_2"/>
<pinref part="U32" gate="A" pin="IN"/>
<wire x1="635" y1="251.46" x2="635" y2="254" width="0.1524" layer="91"/>
<pinref part="U32" gate="A" pin="IN_3"/>
<wire x1="635" y1="254" x2="635" y2="256.54" width="0.1524" layer="91"/>
<junction x="635" y="254"/>
<pinref part="C153" gate="G$1" pin="1"/>
<wire x1="635" y1="256.54" x2="662.94" y2="256.54" width="0.1524" layer="91"/>
<junction x="635" y="256.54"/>
<label x="650.24" y="256.54" size="1.778" layer="95"/>
</segment>
</net>
<net name="+3V3_ADTR" class="0">
<segment>
<pinref part="U32" gate="A" pin="OUT"/>
<pinref part="U32" gate="A" pin="OUT_3"/>
<wire x1="635" y1="264.16" x2="635" y2="261.62" width="0.1524" layer="91"/>
<wire x1="635" y1="261.62" x2="645.16" y2="261.62" width="0.1524" layer="91"/>
<wire x1="645.16" y1="261.62" x2="645.16" y2="279.4" width="0.1524" layer="91"/>
<junction x="635" y="261.62"/>
<wire x1="645.16" y1="279.4" x2="589.28" y2="279.4" width="0.1524" layer="91"/>
<pinref part="U32" gate="A" pin="OUT_2"/>
<wire x1="589.28" y1="279.4" x2="589.28" y2="266.7" width="0.1524" layer="91"/>
<wire x1="589.28" y1="266.7" x2="574.04" y2="266.7" width="0.1524" layer="91"/>
<junction x="589.28" y="266.7"/>
<pinref part="C149" gate="G$1" pin="1"/>
<wire x1="574.04" y1="266.7" x2="563.88" y2="266.7" width="0.1524" layer="91"/>
<junction x="563.88" y="266.7"/>
<pinref part="R53" gate="G$1" pin="2"/>
<junction x="574.04" y="266.7"/>
<label x="548.64" y="266.7" size="1.778" layer="95"/>
<pinref part="X34" gate="-1" pin="S"/>
<wire x1="563.88" y1="266.7" x2="553.72" y2="266.7" width="0.1524" layer="91"/>
<wire x1="553.72" y1="266.7" x2="553.72" y2="256.54" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$82" class="0">
<segment>
<pinref part="U32" gate="A" pin="SNS"/>
<pinref part="C150" gate="G$1" pin="1"/>
<wire x1="589.28" y1="264.16" x2="579.12" y2="264.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$91" class="0">
<segment>
<pinref part="R53" gate="G$1" pin="1"/>
<pinref part="R54" gate="G$1" pin="2"/>
<wire x1="574.04" y1="256.54" x2="576.58" y2="256.54" width="0.1524" layer="91"/>
<junction x="574.04" y="256.54"/>
<wire x1="576.58" y1="256.54" x2="576.58" y2="254" width="0.1524" layer="91"/>
<wire x1="576.58" y1="254" x2="586.74" y2="254" width="0.1524" layer="91"/>
<pinref part="U32" gate="A" pin="FB"/>
<wire x1="589.28" y1="261.62" x2="586.74" y2="261.62" width="0.1524" layer="91"/>
<wire x1="586.74" y1="261.62" x2="584.2" y2="261.62" width="0.1524" layer="91"/>
<wire x1="584.2" y1="261.62" x2="584.2" y2="256.54" width="0.1524" layer="91"/>
<pinref part="C150" gate="G$1" pin="2"/>
<wire x1="584.2" y1="256.54" x2="579.12" y2="256.54" width="0.1524" layer="91"/>
<wire x1="586.74" y1="254" x2="586.74" y2="261.62" width="0.1524" layer="91"/>
<junction x="586.74" y="261.62"/>
</segment>
</net>
<net name="N$92" class="0">
<segment>
<pinref part="C151" gate="G$1" pin="1"/>
<pinref part="U32" gate="A" pin="BIAS"/>
<wire x1="640.08" y1="243.84" x2="635" y2="243.84" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$101" class="0">
<segment>
<pinref part="C152" gate="G$1" pin="1"/>
<pinref part="U32" gate="A" pin="NR/SS"/>
<wire x1="650.24" y1="246.38" x2="635" y2="246.38" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$81" class="0">
<segment>
<pinref part="U33" gate="A" pin="SW"/>
<pinref part="U$21" gate="A" pin="2"/>
<wire x1="787.4" y1="185.42" x2="787.4" y2="195.58" width="0.1524" layer="91"/>
<pinref part="C154" gate="G$1" pin="2"/>
<wire x1="787.4" y1="195.58" x2="787.4" y2="200.66" width="0.1524" layer="91"/>
<wire x1="795.02" y1="195.58" x2="787.4" y2="195.58" width="0.1524" layer="91"/>
<junction x="787.4" y="195.58"/>
</segment>
</net>
<net name="N$87" class="0">
<segment>
<pinref part="C154" gate="G$1" pin="1"/>
<pinref part="U33" gate="A" pin="VBST"/>
<wire x1="795.02" y1="187.96" x2="795.02" y2="185.42" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$97" class="0">
<segment>
<pinref part="R55" gate="G$1" pin="1"/>
<pinref part="R56" gate="G$1" pin="2"/>
<wire x1="797.56" y1="218.44" x2="800.1" y2="218.44" width="0.1524" layer="91"/>
<wire x1="800.1" y1="218.44" x2="800.1" y2="200.66" width="0.1524" layer="91"/>
<junction x="800.1" y="218.44"/>
<wire x1="800.1" y1="200.66" x2="805.18" y2="200.66" width="0.1524" layer="91"/>
<pinref part="U33" gate="A" pin="VFB"/>
<wire x1="805.18" y1="200.66" x2="805.18" y2="185.42" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$102" class="0">
<segment>
<pinref part="U34" gate="A" pin="SNS"/>
<pinref part="C160" gate="G$1" pin="1"/>
<wire x1="787.4" y1="320.04" x2="787.4" y2="309.88" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$103" class="0">
<segment>
<pinref part="R57" gate="G$1" pin="1"/>
<pinref part="R58" gate="G$1" pin="2"/>
<wire x1="795.02" y1="304.8" x2="795.02" y2="307.34" width="0.1524" layer="91"/>
<junction x="795.02" y="304.8"/>
<wire x1="795.02" y1="307.34" x2="797.56" y2="307.34" width="0.1524" layer="91"/>
<wire x1="797.56" y1="307.34" x2="797.56" y2="317.5" width="0.1524" layer="91"/>
<pinref part="U34" gate="A" pin="FB"/>
<wire x1="789.94" y1="320.04" x2="789.94" y2="317.5" width="0.1524" layer="91"/>
<wire x1="789.94" y1="317.5" x2="789.94" y2="314.96" width="0.1524" layer="91"/>
<wire x1="789.94" y1="314.96" x2="795.02" y2="314.96" width="0.1524" layer="91"/>
<pinref part="C160" gate="G$1" pin="2"/>
<wire x1="795.02" y1="314.96" x2="795.02" y2="309.88" width="0.1524" layer="91"/>
<wire x1="797.56" y1="317.5" x2="789.94" y2="317.5" width="0.1524" layer="91"/>
<junction x="789.94" y="317.5"/>
</segment>
</net>
<net name="N$104" class="0">
<segment>
<pinref part="C161" gate="G$1" pin="1"/>
<pinref part="U34" gate="A" pin="BIAS"/>
<wire x1="807.72" y1="370.84" x2="807.72" y2="365.76" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$105" class="0">
<segment>
<pinref part="C162" gate="G$1" pin="1"/>
<pinref part="U34" gate="A" pin="NR/SS"/>
<wire x1="805.18" y1="381" x2="805.18" y2="365.76" width="0.1524" layer="91"/>
</segment>
</net>
<net name="+5V0_5" class="0">
<segment>
<pinref part="U$21" gate="A" pin="1"/>
<pinref part="R55" gate="G$1" pin="2"/>
<wire x1="787.4" y1="215.9" x2="787.4" y2="218.44" width="0.1524" layer="91"/>
<junction x="787.4" y="218.44"/>
<pinref part="C155" gate="G$1" pin="1"/>
<wire x1="787.4" y1="228.6" x2="787.4" y2="218.44" width="0.1524" layer="91"/>
<junction x="787.4" y="228.6"/>
<pinref part="C156" gate="G$1" pin="1"/>
<wire x1="787.4" y1="228.6" x2="787.4" y2="236.22" width="0.1524" layer="91"/>
<wire x1="787.4" y1="236.22" x2="787.4" y2="246.38" width="0.1524" layer="91"/>
<junction x="787.4" y="236.22"/>
<wire x1="787.4" y1="246.38" x2="784.86" y2="246.38" width="0.1524" layer="91"/>
<label x="784.86" y="238.76" size="1.778" layer="95" rot="R90"/>
<pinref part="X28" gate="-1" pin="S"/>
<wire x1="787.4" y1="254" x2="787.4" y2="246.38" width="0.1524" layer="91"/>
<junction x="787.4" y="246.38"/>
</segment>
<segment>
<pinref part="U34" gate="A" pin="IN_2"/>
<pinref part="U34" gate="A" pin="IN"/>
<wire x1="800.1" y1="365.76" x2="797.56" y2="365.76" width="0.1524" layer="91"/>
<pinref part="U34" gate="A" pin="IN_3"/>
<wire x1="797.56" y1="365.76" x2="795.02" y2="365.76" width="0.1524" layer="91"/>
<junction x="797.56" y="365.76"/>
<pinref part="C163" gate="G$1" pin="1"/>
<wire x1="795.02" y1="365.76" x2="795.02" y2="375.92" width="0.1524" layer="91"/>
<junction x="795.02" y="365.76"/>
<label x="795.02" y="381" size="1.778" layer="95" rot="R90"/>
<pinref part="U34" gate="A" pin="EN"/>
<wire x1="795.02" y1="375.92" x2="795.02" y2="393.7" width="0.1524" layer="91"/>
<wire x1="802.64" y1="365.76" x2="802.64" y2="375.92" width="0.1524" layer="91"/>
<wire x1="802.64" y1="375.92" x2="795.02" y2="375.92" width="0.1524" layer="91"/>
<junction x="795.02" y="375.92"/>
</segment>
</net>
<net name="+3V3_XO" class="0">
<segment>
<pinref part="U34" gate="A" pin="OUT"/>
<pinref part="U34" gate="A" pin="OUT_3"/>
<wire x1="787.4" y1="365.76" x2="789.94" y2="365.76" width="0.1524" layer="91"/>
<wire x1="789.94" y1="365.76" x2="789.94" y2="375.92" width="0.1524" layer="91"/>
<wire x1="789.94" y1="375.92" x2="772.16" y2="375.92" width="0.1524" layer="91"/>
<junction x="789.94" y="365.76"/>
<wire x1="772.16" y1="375.92" x2="772.16" y2="320.04" width="0.1524" layer="91"/>
<pinref part="U34" gate="A" pin="OUT_2"/>
<wire x1="772.16" y1="320.04" x2="784.86" y2="320.04" width="0.1524" layer="91"/>
<wire x1="784.86" y1="320.04" x2="784.86" y2="304.8" width="0.1524" layer="91"/>
<junction x="784.86" y="320.04"/>
<pinref part="C159" gate="G$1" pin="1"/>
<wire x1="784.86" y1="304.8" x2="784.86" y2="294.64" width="0.1524" layer="91"/>
<junction x="784.86" y="294.64"/>
<pinref part="R57" gate="G$1" pin="2"/>
<junction x="784.86" y="304.8"/>
<label x="784.86" y="281.94" size="1.778" layer="95" rot="R90"/>
<wire x1="784.86" y1="294.64" x2="784.86" y2="287.02" width="0.1524" layer="91"/>
<wire x1="784.86" y1="287.02" x2="800.1" y2="287.02" width="0.1524" layer="91"/>
<pinref part="X35" gate="-1" pin="S"/>
<wire x1="800.1" y1="287.02" x2="800.1" y2="281.94" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
<note version="8.4" severity="warning">
Since Version 8.4, EAGLE supports properties for SPICE simulation. 
Probes in schematics and SPICE mapping objects found in parts and library devices
will not be understood with this version. Update EAGLE to the latest version
for full support of SPICE simulation. 
</note>
</compatibility>
</eagle>
