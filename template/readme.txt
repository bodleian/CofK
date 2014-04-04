This folder contains XML files and XSLT files that are used to generate the CofK prosopography input form.


group.xml
----------------
Defines field groups and fields in the input form

section.xml
-------------------
Defines sections of the input form

template2XML.xslt
------------------------------
Transforms group.xml and section.xml to XML file that is used to generate the CofK prosopography input form


result.xml
----------------
Result of transformation using tempalte2XML.xslt


templateBootstrap.xslt
------------------------------------
transforms result.xml to HTML file containing CofK prosopography input form, using bootstrap

templateFoundation.xslt
--------------------------------------
transforms result.xml to HTML file containing CofK prosopography input form, using Foundation
