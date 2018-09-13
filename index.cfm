<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>CF Email Obfuscator Test</title>
  </head>
  <body>
  <cfset cfObfuscator = new emailObfuscator()>
  
  <cfoutput>
  	#cfObfuscator.munge('no_spam_for_me@mailinator.com')#
  </cfoutput>
  </body>
</html>