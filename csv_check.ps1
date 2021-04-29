#Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Param($strPath)
$OutArys = @()
$sinseiListss = @()
$strP =Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "ファイル読み込み中。。。（ファイル大きいと時間かかります。）
　　　 ∧　　/ヽ
　　　/／￣￣＼|
　　 ∠＿╋＿＿〉
　　/　①八①　ヽ ＿　＜ヨシ
　 工ﾆf(_人_)ｴ二|′)ヽ
　　＼ヽヽノノ ノ ヘ |
⊂⌒)_＞―――′イ (＿)
　`ー､_ノ/￣ヽ　｜
　　 ＿|｜　 |　｜
　　(　 人＿ノ　Λ
　　 ＼ス￣￣ﾚ-Λ ＼
　　(￣　)　/ /　＼ﾉ＼
　　 ￣￣　(　ヽ　 ＼_)
　　　　　　＼ノ"
if($strPath -eq $null){
    Write-Host "ファイルはドラッグアンドドロップしてください。"
    pause
    exit
}
get-childItem $strP"\csv\" | foreach {
    $sinseiList = Import-Csv -Path $strP"\csv\"$_ | Select accountName
    $sinseiListss += $sinseiList.accountName
}
if($sinseiListss.Length -eq 0){
    Write-Host "申請書ないです。"
    pause
    exit
}
$Lists = Import-Csv $strPath -Encoding Default

$Count = 0
$ResultInt = 0
$prs = 1
foreach($List in $Lists){
    ####################################
    # ここにifなどでチェックする。
    # チェックに該当したものは$OutArysに入れる
    # チェックに該当した時は$ResultIntに1加算しておく
    ####################################
    if(($prs % 100) -eq 0){
            $OutArys += $OutAry
        $prss = $prs / ($Lists.Length / 100)
        Write-Progress -Activity "チェック中…" -Status "しばらくおまちください" -PercentComplete $prss -CurrentOperation "$prss % 完了"
    }
    $prs +=1
}
if ($ResultInt -ne 0){
    $OutArys | Export-Csv -NoTypeInformation  .\チェック結果.csv -Encoding Default
    Write-Host "チェック結果を出力しました。"
}else{
    Write-Host "チェック問題なかったです。"
}
pause
