### Vue Deployment on GitHub Pages and Cloudflare Workers

### Deployment on GitHub Pages

1. **First, compile locally after development and upload to git, then configure the repository**

    ```bash
    $ npm run build
    ```

2. **Comment out the dist file in .gitignore**

    ```bash
    $ git add .
    $ git commit -m "test 2"
    $ git push origin master
    $ git subtree push --prefix dist origin gh-pages
    ```

3. **Open the repository settings in GitHub, select Pages configuration, choose 'Deploy from a branch' in Source, and select the gh_pages branch with /(root) folder in Branch.**

### Deployment on Cloudflare Workers

1. **Install Wrangler CLI**

    Wrangler is the command-line interface for Cloudflare Workers. Install it using:

    ```bash
    npm install -g @cloudflare/wrangler
    ```

2. **Configure Wrangler**

    In your project's root directory, run the following command to generate a new Wrangler configuration file:

    ```bash
    wrangler generate my-project
    ```

    This will create a new `my-project` folder in your project directory containing a `wrangler.toml` configuration file. Enter your Cloudflare account ID and Workers name in this file. It should look like this:

    ```toml
    name = "my-project" 
    type = "webpack" 
    account_id = "your-account-id"
    ```

3. **Build the Project**

    Run the following command in your Vue project to build it:

    ```bash
    npm run build
    ```

    This will generate a `dist` folder containing the built project.

4. **Configure Wrangler for Deployment**

    Configure Wrangler to deploy the `dist` folder to Cloudflare Workers. Add the following lines to your `wrangler.toml` configuration file:

    ```toml
    [site]
    bucket = "./dist"
    entry-point = "workers-site"
    ```

5. **Deploy the Project**

    Run the following command to deploy your project:

    ```bash
    wrangler publish
    ```

---

### Vue在GitHub Pages和Cloudflare Workers的部署

### 在github pages的部署

1. **首先在本地写好之后，进行编译，git上传，最后配置一下仓库**

    ```bash
    $ npm run build
    ```

2. **注释掉.gitignore文件中的dist文件**

    ```bash
    $ git add .
    $ git commit -m "test 2"
    $ git push origin master
    $ git subtree push --prefix dist origin gh-pages
    ```

3. **打开github仓库的setting配置，选择Pages配置项，Source项选择Deploy from a branch，Branch项选择gh_pages分支下的/(root)文件夹。**

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
