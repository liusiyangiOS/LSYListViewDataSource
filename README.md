# LSYListViewDataSource

[![License MIT](https://img.shields.io/cocoapods/l/LSYListViewDataSource)](https://www.apache.org/licenses/LICENSE-2.0.html)
![Pod version](https://img.shields.io/cocoapods/v/LSYListViewDataSource)
![Pod platform](https://img.shields.io/cocoapods/p/LSYListViewDataSource)


LSYListViewDataSource是基于 [MJRefresh][MJRefresh] 封装的iOS列表视图加载刷新的库。

## 实现的功能

* 一个方法完成99%的功能
* 自动管理PageSize，PageIndex逻辑
* Total逻辑判断，没有更多数据时提供显示NoMoreData提示文案和移除footer两种选择
* 对tableView和collectionView的dataSource进行了封装
* 加载完第一屏数据后根据是否还有更多数据来决定是否添加footer
* 可设置只添加header/footer,默认全部添加

## 效果展示

| 默认的header和footer | 自定义的header和footer |
| :----------------: | :-------------------: |
|<img width="320" height="692" src="./Example/DefaultHeaderFooter.gif"/>|<img width="320" height="692" src="./Example/CustomHeaderFooter.gif"/>|

## 安装

你可以在 Podfile 中加入下面一行代码来使用 LSYListViewDataSource

    pod 'LSYListViewDataSource' ~> 1.0

## 安装要求

| LSYListViewDataSource 版本 | 最低 iOS Target |        注意       |
| :-----------------------: | :------------: | :--------------: |
|            1.x            |     iOS 9      | 要求 Xcode 11 以上 |

## 相关文章

* [基于MJRefresh的列表加载刷新逻辑的封装](https://www.jianshu.com/p/57db3ac8556d)
* [作者博客](https://www.jianshu.com/u/e1fee33c72bc)

## 协议

LSYListViewDataSource 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

<!-- external links -->
[MJRefresh]:https://github.com/CoderMJLee/MJRefresh
