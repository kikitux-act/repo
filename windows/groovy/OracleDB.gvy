def images = []
def powerShellCommand = 'c:\\ps\\list_oracle.ps1 '

def shellCommand = "powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command \"${powerShellCommand}\""

def process = shellCommand.execute()
process.waitFor()
def outputStream = new StringBuffer();
process.waitForProcessOutput(outputStream, System.err)
if(process.exitValue()){
println process.err.text
} else {
println outputStream
images = outputStream.tokenize("|")
}
return images
