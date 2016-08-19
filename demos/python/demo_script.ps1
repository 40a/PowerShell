$VerbosePreference = "continue"

Write-Verbose "---  Demo simple interoperation between PowerShell and Python"

Write-Verbose "---  Basic execution of a Python script fragment"
python -c "print('Hi!')"

Write-Verbose "---  Capture output in a variable"
$data = python -c "print('Hi!')"

Write-Verbose "---  And show the data"
$data

Write-Verbose "---  Use in expressions"
5 + (python -c "print(2 + 3)") + 7

Write-Verbose "---  Create a Python script using a PowerShell here-string, no extension"
@"
#!/usr/bin/env python3
print('Hi!')
"@ | out-file -encoding ascii hi

Write-Verbose "---  Make it executable"
chmod +x hi

Write-Verbose "---  Run it - shows that PowerShell really is a shell"
./hi

Write-Verbose "---  A more complex script that outputs JSON"
cat class1.py

Write-Verbose "---  Run the script"
./class1.py

Write-Verbose "---  Capture the data as structured objects (arrays and hashtables)"
$data = ./class1.py | ConvertFrom-JSON

Write-Verbose "---  look at the first element of the returned array"
$data[0]

Write-Verbose "---  Look at the second"
$data[1]

Write-Verbose "---  Get a specific element from the data"
$data[1].buz[1]

Write-Verbose "---  Finally wrap it all up so it looks like a simple PowerShell command"
cat class1.ps1

Write-Verbose "---  And run it, treating the output as structured data."
$X = (./class1)[1].buz[1]
$X
Write-Verbose "--- Output of X is expected before this line (but is postponed!): $X ---"

Write-Verbose "---  Finally a PowerShell script with in-line Python"
cat inline_python.ps1

Write-Verbose "---  and run it... Look ma - here goes postponet output!"
./inline_python


Write-Verbose "---  cleanup"
rm hi
