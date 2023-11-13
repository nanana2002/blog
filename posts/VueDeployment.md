### 在github pages的部署

1. ** 首先在本地写好之后，进行编译，git上传，最后配置一下仓库 **

```bash
$ npm run build

```

2. ** 注释掉.gitignore文件中的dist文件 **

```bash
$ git add .
$ git commit -m "test 2"
$ git push origin master
$ git subtree push --prefix dist origin gh-pages

```

3. ** 打开github仓库的setting配置，选择Pages配置项，Source项选择Deploy from a branch，Branch项选择gh_pages分支下的/(root)文件夹。 **

### 在Cloudflare Workers的部署


1. **安装 Wrangler CLI**

    Wrangler 是 Cloudflare Workers 的命令行接口，安装：

    ```bash
    npm install -g @cloudflare/wrangler
    ```

2. **配置 Wrangler**

    在项目根目录下，运行以下命令来生成一个新的 Wrangler 配置文件：

    ```bash
    wrangler generate my-project
    ```

    这会在项目目录下创建一个新的 `my-project` 文件夹，其中包含一个 `wrangler.toml` 配置文件。在这个文件中输入 Cloudflare 账户 ID 和 Workers 的名字。它应该看起来像这样：

    ```toml
    name = "my-project" 
    type = "webpack" 
    account_id = "your-account-id"
    ```

3. **构建项目**

    在 Vue 项目中运行以下命令来构建它：

    ```bash
    npm run build
    ```

    这会生成一个 `dist` 文件夹，里面包含了构建好的项目。

4. **配置 Wrangler 来部署项目**

    需要配置 Wrangler 来把 `dist` 文件夹部署到 Cloudflare Workers。在 `wrangler.toml` 配置文件中，添加以下行：

    ```toml
    [site]
    bucket = "./dist"
    entry-point = "workers-site"
    ```

5. **部署项目**

    运行以下命令来部署项目：

    ```bash
    wrangler publish
    ```
