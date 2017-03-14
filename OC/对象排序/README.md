> 前言

由于在设计中刚好需要实现一个仿通讯录的排序,自己有靠自己做了一套逻辑,但是发现还是不够灵活,查找苹果的时候找到一个API,所以这里和大家分享一下,文章最后放上本次实践的demo,希望大家喜欢


> 正文

![文档的介绍,可以看出主要用在table数据源的排序!](http://upload-images.jianshu.io/upload_images/1730495-cee27b52cd882729.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

本次要介绍的工鞥主要是 UILocalizedIndexedCollation
主要是要解决的问题是:
`一个包含多个model的数组,根据model中特定字段,进行排序,主要是根据字段对应首字母进行相关的排序!`


这是排序前的数据
![](http://upload-images.jianshu.io/upload_images/1730495-469ee7f7c8c60e9b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


可以查看使用我封装的方法,主要就是保证对象和属性的有效性!

![图示简单的使用方法](http://upload-images.jianshu.io/upload_images/1730495-4cce7cb9331ebc74.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)




```
这里简单贴出源码的设计逻辑,如果还不懂可以下我的demo哈!
//    1、获取单例的collation
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //标题数组
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    //设置sections数组初始化：元素包含userObjs数据的空数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
//    2、分类 - 将用户数据进行分类，存储到对应的sesion数组中
    for (MTDUserBaseModel *p in self.friendListRequest.friendMutableArray) {
        NSInteger sectionNumber = [collation sectionForObject:p collationStringSelector:@selector(userNickname)];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:p];
    }
    
//    3、排序 - 对每个已经分类的数组中的数据进行排序
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(userNickname)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }



```

来个装换后的数据动态图,希望大家喜欢:

![转换后的动态图](http://upload-images.jianshu.io/upload_images/1730495-c543345b64fdd13b.gif?imageMogr2/auto-orient/strip)


> 重点来啦~ [githubDemo链接](https://github.com/OneHundredSir/APPFunction/tree/master/OC/%E5%AF%B9%E8%B1%A1%E6%8E%92%E5%BA%8F)

