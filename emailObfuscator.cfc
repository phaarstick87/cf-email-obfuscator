<!--- LICENSE, IMPORTANT STUFF 													--->
<!--- Author: Paul Haarstick phaarstick@paulnet.net 							--->
<!--- Date:   Sept 13, 2018														--->
<!--- GitHub: https://github.com/phaarstick87/cf-email-obfuscator				--->
<!--- Distributed as freeware as long as you leave these attributions here 		--->
<!--- Email obfuscator script 2.1 by Tim Williams, University of Arizona 		--->
<!--- Random encryption key feature by Andrew Moulden, Site Engineering Ltd 	--->
<!--- PHP version coded by Ross Killen, Celtic Productions Ltd 					--->
<!--- This code is freeware provided these six comment lines remain intact 		--->
<!--- A wizard to generate this code is at http://www.jottings.com/obfuscator 	--->
<!--- The PHP code may be obtained from http://www.celticproductions.net/ 		--->
<!--- CF Version available at Git Hub URL above 								--->

<cfcomponent hint="I obfuscate emails">
	
	<!--- Author: phaarstick - Date: 9/13/2018 --->     
    <cffunction name="munge" output="false" access="public" returntype="string" hint="">
    	<cfargument name="email" type="string" required="true"/>
    	<cfset var address = arguments.email>
		<cfset var coded = "" >
		<cfset var chr = 0>
		<cfset var rtn = ""><!--- I am the text returned --->
		
		<cfset var unmixedkey = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@">
		<cfset var inprogresskey = unmixedkey >
		<cfset var mixedkey="" >
		
		<cfset var unshuffled = len(unmixedkey)>
		
		<cfset var ranpos = 0>
		<cfset var nextchar = "">
		<cfset var mixedkey = "">
		<cfset var before = "">
		<cfset var after = "">
		<cfset var inprogresskey = "">
		<cfset var cipher = "">
		<cfset var shift = len(address)>
		
		
		<!--- Iterators --->
		<cfset var i = 1>
		<cfset var j = 1>
		
		<!--- Make the Cipher --->
		<cfloop from="1" to="#len(unmixedkey)#" index="i">
			<cfset ranpos = randrange(1,unshuffled)>
			<cfset nextchar = Mid(inprogresskey,ranpos,1)>
			<cfset mixedkey &= nextchar>
			<cfset before = mid(inprogresskey,1,ranpos-1)>
			<cfset after = mid(inprogresskey,ranpos+1,unshuffled-ranpos+1)>
			<cfset inprogresskey = before & after>
			<cfset unshuffled-->
		</cfloop>
		
		<cfset cipher = mixedkey>
		
		<!--- Encode the email address--->
		<cfloop from="1" to="#len(address)#" index="j" >
			<cfif find(mid(address,j,1),cipher) EQ 0> <!--- String not found --->
				<cfset chr = mid(address,j,1)>
				<cfset coded &= mid(address,j,1)>
			<cfelse>
				<cfset chr = (find(mid(address,j,1),cipher)-1 + shift) % len(cipher)>
				<cfset coded &= getAtPosition(cipher,chr)> 
			</cfif>
		</cfloop>
		
		<cfsavecontent variable="rtn" >
		<script type="text/javascript" language="javascript"> 
			<!--
			// Email obfuscator script 2.1 by Tim Williams, University of Arizona
			// Random encryption key feature coded by Andrew Moulden
			// PHP version coded by Ross Killen, Celtic Productions Ltd 	
			// ColdFusion Version coded by Paul Haarstick, paulnet
			// This code is freeware provided these eight comment lines remain intact
			// A wizard to generate this code is at http://www.jottings.com/obfuscator/
			// The PHP code may be obtained from http://www.celticproductions.net/ 
			// The CF code may be obtrained from https://github.com/phaarstick87/cf-email-obfuscator/
			coded = "<cfoutput>#coded#</cfoutput>";
			key = "<cfoutput>#cipher#</cfoutput>";
			shift = coded.length;
			link="" 
			for (i=0; i<coded.length; i++) { 
				if (key.indexOf(coded.charAt(i))==-1) { 
					ltr = coded.charAt(i) 
					link += (ltr) 
				} else { 
					ltr = (key.indexOf(coded.charAt(i))-shift+key.length) % key.length 
					link += (key.charAt(ltr)) 
				} 
			} 
			document.write("<a href='mailto:"+link+"'>"+link+"</a>") 
		//-->
		</script><noscript>Sorry, you need Javascript on to email me.</noscript>
		</cfsavecontent>
		
    <cfreturn trim(rtn) />     
    </cffunction>
	
	
	<!--- Author: phaarstick - Date: 9/13/2018 ---> 
	<cffunction name="getAtPosition" output="false" access="private" returntype="string" hint="Since everyone else starts lists at 0 and CF doesn't, I need to accommodate.">
		<cfargument name="string" type="string" required="true"/>
		<cfargument name="position" type="numeric" required="true"/> <!--- acceptable values 0 thru len(string)-1 --->
		<cfset var cfPosition = arguments.position+1>
		
		<cfreturn Mid(arguments.string,cfPosition,1) /> 
	</cffunction>
</cfcomponent>