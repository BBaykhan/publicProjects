#Persistent
#NoEnv
SendMode Input


;=======================================================================================
;Website login 

; Coordinates for the login input
loginX := 950
loginY := 660

; Activate the Edge browser window
WinActivate, ahk_exe msedge.exe

; Navigate to the initial page to check login status
NavigateURL := "http://13.230.123.114/facsimiles/add"
Navigate(NavigateURL)

; Wait for a moment to allow the page to load
Sleep, 3000



; Function to navigate to a URL
Navigate(URL) {
    Run, msedge.exe %URL%
}

; Function to check if the user is logged in
CheckIfLoggedIn() {
    ; Get the title of the active Edge window
    WinGetTitle, pageTitle, ahk_exe msedge.exe  ; Get the title of the Edge window

    ; Return true if the title contains "ログイン" (meaning user is logged out)
    return !InStr(pageTitle, "ログイン")  ; Return true if "ログイン" is not found
}


faxFilePath := "???"

; Open the Fax Management Excel file
	oExcel := ComObjCreate("Excel.Application")
	oExcel.Visible := true
	oWorkbook := oExcel.Workbooks.Open(faxFilePath)

	; Get the login, and password

	login := oWorkbook.Sheets(1).Range("J15").Value
	password := oWorkbook.Sheets(1).Range("J18").Value
	month := Round(oWorkbook.Sheets(1).Range("H11").Value)
	day := oWorkbook.Sheets(1).Range("O11").Value
	weekOfMonth := oWorkbook.Sheets(1).Range("Q18").Value
	
	; Close the workbook without saving changes
	oWorkbook.Close(false)  ; 'false' means don't save changes
	
	; Quit the Excel application
	oExcel.Quit()  ; This will close the Excel application

; Check if logged in
If !CheckIfLoggedIn() {
	
	
    ; Not logged in, proceed to log in
    Click, %loginX%, %loginY%  ; Click on the login input using the coordinates
    Sleep, 500  ; Wait a bit for the click to register

    ; Fill in the username (replace with your actual username)
    Send, login  ; Replace "YourUsername" with your actual username
    Send, {Tab}  ; Move to the password field

    ; Fill in the password (replace with your actual password)
    Send, password  ; Replace "YourPassword" with your actual password

    ; Press Enter to submit the form
    Send, {Enter}

    ; Wait for the login to process
    Sleep, 1000  
	
	; After login 
	Navigate(NavigateURL)
} 

Sleep, 1000


;=======================================================================================
; Exception list


; Define the exception list
exceptionList := "
(
    その他の修理業
    その他の専門サービス業
    その他の廃棄物処理業
    その他の物品賃貸業
    一般貨物自動車運送業
    一般廃棄物処理業
    映像・音声・文字情報制作に附帯するサービス業
    各種物品賃貸業
    機械修理業（電気機械器具を除く）
    警備業
    建物サービス業
    建物売買業，土地売買業
    広告制作業
    産業廃棄物処理業
    産業用機械器具賃貸業
    市町村機関
    事業協同組合（他に分類されないもの）
    事務用機械器具賃貸業
    自動車小売業
    自動車整備業
    自動車賃貸業
    出版業
    他に分類されない事業サービス業
    他に分類されない非営利的団体
    貸家業，貸間業
    電気機械器具修理業
    土木建築サービス業
    農林水産業協同組合（他に分類されないもの）
    農林水産金融業
    表具業
    不動産管理業
    不動産賃貸業（貸家業，貸間業を除く）
    分類不能の産業
    法律事務所，特許事務所
    労働者派遣業
)"

; Assume isException is false initially
isException := false

;=======================================================================================
;Copy paste from .xlsx to website


; Full path to the Excel file
excelFilePath := "???"

; Read the text file containing the visible rows' addresses
FileRead, visibleRows, ???

; Try to open the Excel application
try {
    oExcel := ComObjCreate("Excel.Application")  ; Create an Excel instance
    oExcel.Visible := True  ; Optional: Set to True if you want to see Excel while it's working
} catch {
    MsgBox, Could not open Excel. Exiting script.
    ExitApp
}

; Attempt to open the specific workbook
try {
    mainWorkbook := oExcel.Workbooks.Open(excelFilePath)
} catch {
    MsgBox, Could not open workbook. Exiting script.
    ExitApp
}

; Access the active sheet (the filtered sheet should already be active)
activeSheet := mainWorkbook.ActiveSheet


; Split the visible rows' addresses into an array
visibleRowArray := StrSplit(visibleRows, ",")


;=======================================================================================
;Getting main category for searching file later



; Retrieve the address of the first row from the txt file
firstCellAddress := Trim(visibleRowArray[1])

; Get the value from column A of the first row
firstCellValueColumnA := activeSheet.Range(firstCellAddress).Cells(1, 1).Value

; Copy the value from column A to the clipboard with a unique name
ClipboardColumnA := firstCellValueColumnA



;=======================================================================================
;Copy pasting column C category to the website


; Loop through the array of visible row addresses
for index, cellAddress in visibleRowArray {

; Trim any spaces around the cellAddress
cellAddress  := Trim(cellAddress )
	
cellValue := activeSheet.Range(cellAddress).Cells(1, 3).Value

		; Check if category is in exception list
	if InStr(exceptionList, category) {
		isException := true
	}


	; Copy the value from the current cell in column C
	clipboard := cellValue
	Clipboard := Clipboard  ; Ensure clipboard uses Unicode

	Sleep, 500  ; Give some time to copy (adjust if necessary)
	
    ; Switch to the Edge browser window
    WinActivate, ahk_class Chrome_WidgetWin_1
	
	Sleep, 200
	
	; Simulate pressing the Down Arrow key to imitate selecting the suggestion
    Send, {Down}

    ; Click at the specified coordinates 
    Click, 975, 467


    ; Wait for a moment to ensure the clipboard is set
    Sleep, 700
	
	; Select all text in the input field
	Send, ^a  ; Ctrl+A to select all text

	; Wait a moment after selecting
	Sleep, 300

	; Delete the selected text
	Send, {Delete}

	; Wait a moment after deleting
	Sleep, 300

	; Click at the specified coordinates 
    Click, 975, 467
	
    ; Send Ctrl+V to paste the text from the clipboard
    Send, ^v

    ; Wait a moment after pasting
    Sleep, 500
	
	; Simulate pressing the Down Arrow key to imitate selecting the suggestion
    Send, {Down}

    ; Wait a moment before pressing Enter
    Sleep, 500

    ; Simulate pressing Enter to confirm the selection
    Send, {Enter}
	
	; Wait for a moment to ensure the Enter action is processed
	Sleep, 100  ; Adjust the sleep time if necessary

    ; Pause between each row (adjust based on the process needs)
    Sleep, 800
}

;=======================================================================================
;Calendar check

Sleep, 1000

; Click at the specified coordinates to open the calendar
Click, 1315, 470 
Sleep, 1000 ; Wait for the calendar to load

; Open Developer Console (F12)
Send, ^+i  ; Shortcut for opening Developer Tools in most browsers (Ctrl+Shift+I)
Sleep, 500 ; Wait for Developer Console to open

; Clicking Dev Tools icon
Click, 1550, 120
Sleep, 300

;Putting aim to text field
Click, 1550, 555

; Injecting JavaScript into the console for date
Send, var day = %day%;{Enter}
Sleep, 200
Send, var cells = document.querySelectorAll('td.available div span');{Enter}
SendRaw, for (var i = 0; i < cells.length; i++) { if (cells[i].textContent.trim() == day.toString()) { cells[i].click(); break; }}
Sleep, 200
Send, {Enter}

Sleep, 500

; Closing Dev Tools
Send, ^+i  ; Close Developer Tools with the same shortcut
Sleep, 1000

; Choosing time
Click, 1650, 465
Sleep, 400

Send, {Down}
Sleep, 200

Send, {Down}
Sleep, 200

Send, {Enter}
Sleep, 300

; Searching
Click, 660, 570
Sleep, 25000

;Going to FAX設定
Click, 1500, 255

Sleep, 1000

;=======================================================================================
;Selecting tsuikyaku files

; Opening Dev Tools and aiming it
Send, ^+i 
Sleep, 300

Click, 460, 673
Sleep, 5000

Send, {Down}
Sleep, 400

Send, {Enter}
Sleep, 300

Send, {Down}
Sleep, 400

Send, {Enter}
Sleep, 300



; Construct the search text
	;searchText := "2024" . month

	;Send, var items = document.querySelectorAll('li.el-select-dropdown__item, li.el-select-dropdown__item.hover');{Enter}
	;Sleep, 1500
	;SendRaw, for (var i = 0; i < items.length; i++) { var span = items[i].querySelector('span'); if (span && span.textContent.includes(" %searchText% ")) { span.click(); } }
	;Send, {Enter}
	;Sleep, 300

	;Send, var items = document.querySelectorAll('li.el-select-dropdown__item.hover');{Enter}
	;Sleep, 300
	;SendRaw, for (var i = 0; i < items.length; i++) { var span = items[i].querySelector('span'); if (span && span.textContent.includes(" %searchText% ")) { span.click(); } }
	;Send, {Enter}

	;Sleep, 300


;=======================================================================================
;Choosing the folder



searchTextWeek := "week" . weekOfMonth

;Opening 選択
Click, 515, 500
Sleep, 300

Click, 640, 330
Sleep, 300

; Page down
Send, {PgDn} 
Sleep, 300 

;Retargeting on Dev Tools
Click, 1550, 1060
Sleep, 300


; Sending JavaScript commands line by line
Send, var searchText = %searchText%;{Enter}
		
Send, var elements = document.querySelectorAll('span');{Enter}
Sleep, 200

SendRaw, for (var i = 0; i < elements.length; i++) { if (elements[i].textContent.trim() == searchText.toString()) { elements[i].click(); break; }}

Sleep, 100

Send, {Enter}
Sleep, 300


;=======================================================================================
;Choosing the inner folder

Send, var searchTextWeek = "%searchTextWeek%";{Enter}
Sleep, 200

Send, var elementsWeek = document.querySelectorAll('tr.el-table__row td.el-table__cell div.cell.el-tooltip');{Enter}
Sleep, 200

SendRaw, for (var i = 0; i < elementsWeek.length; i++) { if (elementsWeek[i].textContent.includes(searchTextWeek)) { var element = elementsWeek[i]; var event = new MouseEvent('dblclick', { bubbles: true, cancelable: true }); element.dispatchEvent(event); break; }}
Send, {Enter}
Sleep, 500


;=======================================================================================
;Searching the necessary file and adding exception list



if isException {
    ; Right-click at 700, 370 if it's an exception
    Click, Right, 700, 370
} else {
    ; Check the value of 'ClipboardColumnA' and right-click on corresponding coordinates
    if (ClipboardColumnA = "医療，福祉") {
        Click, Right, 700, 425
    } else if (ClipboardColumnA = "卸売業，小売業") {
        Click, Right, 700, 485
    } else if (ClipboardColumnA = "宿泊業，飲食サービス業" or ClipboardColumnA = "飲食業" or ClipboardColumnA = "生活関連サービス業，娯楽業") {
        Click, Right, 700, 545
    } else if (ClipboardColumnA = "建設業") {
        Click, Right, 700, 605
    } else if (ClipboardColumnA = "教育，学習支援業") {
        Click, Right, 700, 665
    } else if (ClipboardColumnA = "製造業") {
        Click, Right, 700, 725
    } else if (ClipboardColumnA = "農業，林業") {
        Click, Right, 700, 785
    } else if (ClipboardColumnA = "追客") {
        Click, Right, 700, 850
    } else if (ClipboardColumnA = "運輸業，郵便業") {
        Click, Right, 700, 910
    } else if (ClipboardColumnA = "鉱業，採石業，砂利採取業") {
        Click, Right, 700, 965
    } else if (ClipboardColumnA = "電気・ガス・熱供給・水道業") {
        Click, Right, 700, 1015
    }
}


;Retargeting on Dev Tools
Click, 1550, 1060
Sleep, 300


;Handling popup and selecting 選択
Send, var popupOptions = document.querySelectorAll('li.el-dropdown-menu__item span');{Enter}
Sleep, 200

SendRaw, for (var i = 0; i < popupOptions.length; i++) { if (popupOptions[i].textContent.trim() == "選択") { popupOptions[i].click(); break; }}
Send, {Enter}

Sleep, 500

Send, ^+i 
Sleep, 200



Sleep, 10000
; close the workbook
mainWorkbook.Close(False)  ; False to close without asking to save again

; Quit Excel to release resources
oExcel.Quit()





; Exit the script after all pasting is done
ExitApp

; Hotkey to manually exit the script
^q::ExitApp  ; Press Ctrl+Q to exit the script manually