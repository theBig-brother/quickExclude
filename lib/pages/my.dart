import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 背景颜色
      padding: EdgeInsets.all(16.0), // 内边距
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像区域
          CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage(
              'https://example.com/avatar.jpg',
            ), // 头像图片
          ),
          SizedBox(height: 16.0), // 间隔
          // 用户名
          Text(
            '用户名',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0), // 间隔
          // 用户简介
          Text(
            '这里是用户简介，可以写一些简单的个人信息。',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          SizedBox(height: 32.0), // 间隔
          // 功能项列表
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('账户设置'),
                  onTap: () {
                    // 账户设置点击事件
                  },
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('通知设置'),
                  onTap: () {
                    // 通知设置点击事件
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('退出登录'),
                  onTap: () {
                    // 退出登录点击事件
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
