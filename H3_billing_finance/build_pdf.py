import os
import subprocess

# Paths definitions
chrome_path = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
html_path = r"c:\Users\LEGION\Desktop\Hospital_Dataset\Submit\subsystem_analysis_report.html"
pdf_path = r"c:\Users\LEGION\Desktop\Hospital_Dataset\Submit\SUBSYSTEM_ANALYSIS_u68001.pdf"

if not os.path.exists(chrome_path):
    # Try alternative Chrome path
    alternative_path = r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    if os.path.exists(alternative_path):
        chrome_path = alternative_path
    else:
        print("Error: Google Chrome not found. Please verify the installation path.")
        exit(1)

print(f"Found Google Chrome at: {chrome_path}")
print(f"Compiling {html_path} to PDF...")

try:
    # Run chrome headless command to output PDF
    cmd = [
        chrome_path,
        "--headless",
        "--disable-gpu",
        "--no-sandbox",
        "--print-to-pdf-no-header",
        f"--print-to-pdf={pdf_path}",
        html_path
    ]
    
    subprocess.run(cmd, check=True)
    
    if os.path.exists(pdf_path) and os.path.getsize(pdf_path) > 0:
        print(f"Successfully generated PDF: {pdf_path}")
        print(f"File size: {os.path.getsize(pdf_path)} bytes")
    else:
        print("Error: PDF file was not created or is empty.")
        exit(1)
        
except subprocess.CalledProcessError as e:
    print(f"Error during PDF generation: {e}")
    exit(1)
except Exception as e:
    print(f"Unexpected error: {e}")
    exit(1)
