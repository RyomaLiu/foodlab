## 命令：
```
xcrun llvm-cov report -use-color=true -instr-profile ./Build/Intermediates/CodeCoverage/Coverage.profdata ./Build/Intermediates/CodeCoverage/Products/Debug-iphonesimulator/foodlab.app/foodlab
```

## 结果：
```
Filename                                  Regions    Missed Regions     Cover   Functions  Missed Functions  Executed  Instantiations   Missed Insts.  Executed       Lines      Missed Lines     Cover
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AppDelegate.swift                               6                 4    33.33%           6                 4    33.33%               6               4    33.33%          32                14    56.25%
Common/FLConstant.swift                         1                 0   100.00%           1                 0   100.00%               1               0   100.00%           3                 0   100.00%
Common/LMCPopoverMenuView.swift                24                20    16.67%           9                 6    33.33%               9               6    33.33%          99                69    30.30%
Common/UIImage+Category.swift                   1                 0   100.00%           1                 0   100.00%               1               0   100.00%          14                 0   100.00%
FLMainViewController.swift                     28                27     3.57%          12                11     8.33%              12              11     8.33%         184               123    33.15%
FLQRCodeScanViewController.swift               16                16     0.00%           3                 3     0.00%               3               3     0.00%          84                84     0.00%
FLQRScanFromAlbumViewController.swift          15                15     0.00%           4                 4     0.00%               4               4     0.00%          56                56     0.00%
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```
