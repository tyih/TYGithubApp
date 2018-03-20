## GitHub App (GitPeep)开发

项目使用了ReactiveCocoa框架，实现了MVVM架构，分离视图(View)和模型(Model)。

#### MVVM四大优点：
- 低耦合
View可以独立于Model变化和修改，一个ViewModel可以绑定到不同的”View”上，当View变化的时候Model可以不变，当Model变化的时候View也可以不变。

- 可重用性
可以把一些视图逻辑放在一个ViewModel里面，更多view可以重用视图逻辑。

- 独立开发
开发人员可以专注于业务逻辑和数据的开发（ViewModel），设计人员可以专注于页面设计。

- 可测试
界面本来是比较难于测试的，而现在测试可以针对ViewModel来写。

## 效果：
Users | Repositories | Explore | Profile
----- | ------------ | ------- | -------
![enter image description here](https://github.com/tyih/GitPeep/blob/master/Images/IMG_1269.PNG)| ![enter image description here](https://github.com/tyih/GitPeep/blob/master/Images/IMG_1270.PNG)| ![enter image description here](https://github.com/tyih/GitPeep/blob/master/Images/IMG_1271.PNG)| ![enter image description here](https://github.com/tyih/GitPeep/blob/master/Images/IMG_1272.PNG)

### 使用
请使用终端`cd`到`Podfile`所在的文件夹中

```
  1. pod repo update : 更新本地仓库 
  2. pod install : 下载安装
```
