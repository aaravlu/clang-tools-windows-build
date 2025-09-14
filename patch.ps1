param (
    [string]$RootPath = "llvm-project/llvm"  # LLVM 根目录
)

# 获取所有 CMake 文件
$files = Get-ChildItem -Path $RootPath -Recurse -Include "CMakeLists.txt", "*.cmake"

foreach ($file in $files) {
    try {
        (Get-Content $file.FullName) |
            ForEach-Object { $_ -replace "10\.0\.26100", "10.0.19041" } |
            Set-Content $file.FullName
        Write-Host "Patched $($file.FullName)"
    }
    catch {
        Write-Warning "Failed to patch $($file.FullName): $_"
    }
}

Write-Host "Patch complete. All occurrences of 10.0.26100 replaced with 10.0.19041."
