# Million Heros

一款去中心化益智竞赛系统，项目采用truffle + ganache合约框架，前端框架采用Vue + Vuex + Antd

## 文档

1. [选题背景](./docs/选题背景.md)
2. [使用说明](./docs/使用说明.md)
3. [测试文档](./docs/测试.md)

## 开发注意事项：

### 智能合约开发：

- `/contracts`中编写sol文件，然后使用`truffle migrate --reset`进行合约编译和部署;
- `/test`中编写测试文件，使用`truffle test`进行单元测试; 

### 前端开发

- 将`truffle migrate`生成的`\build\contracts`目录下的合约json文件复制到`\src\front-end\src\contracts`目录下对应的文件中。注意文件格式的不同。
- 前端开发后使用`npm run build`，生成部署文件于目录`\src\front-end\dist`，将`\src\front-end\dist`目录下所有内容复制到`\src\front-end`目录下，然后在根目录使用`npm run dev`即可启用`lite-server`

*记得在`\`根目录和`\src\front-end\`目录下分别执行一下`npm install` 安装依赖*

