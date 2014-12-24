--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Monad          (forM,forM_,)
import           Data.List              (sortBy,isInfixOf)
import           Data.Monoid            ((<>),mconcat, mappend)
import           Data.Ord               (comparing)
import           Hakyll
import           System.Locale          (defaultTimeLocale)
import           System.FilePath.Posix  (takeBaseName,takeDirectory
                                         ,(</>),splitFileName)


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "js/*" $ do
        route idRoute
        compile copyFileCompiler

    match "css/fonts/*" $ do
        route idRoute
        compile copyFileCompiler

    match "blog/*.md" $ do
        route $ niceRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/blog/blog-post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls
            >>= removeIndexHtml

    match "code/*.md" $ do
        route $ niceRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/code/code-post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls
            >>= removeIndexHtml

    create ["blog.html"] $ do
        route $ niceRoute
        compile $ do
            posts <- recentFirst =<< loadAll "blog/*"
            let blogCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Blog"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/blog/blog.html" blogCtx
                >>= loadAndApplyTemplate "templates/default.html" blogCtx
                >>= relativizeUrls
                >>= removeIndexHtml

    create ["code.html"] $ do
        route $ niceRoute
        compile $ do
            posts <- loadAll "code/*"
            let codeCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Code"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/code/code.html" codeCtx
                >>= loadAndApplyTemplate "templates/default.html" codeCtx
                >>= relativizeUrls
                >>= removeIndexHtml 

    --match "about.md" $ do 
    --    route $ niceRoute
    --    compile $ pandocCompiler
    --        >>= loadAndApplyTemplate "templates/default.html" defaultContext
    --        >>= relativizeUrls
    --        >>= removeIndexHtml

    match "cv.md" $ do
        route $ niceRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls
            >>= removeIndexHtml

    match "index.md" $ do
        route $ setExtension "html"
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            pandocCompiler
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls
                >>= removeIndexHtml

    match "templates/*" $ compile templateCompiler

    match "templates/blog/*" $ compile templateCompiler

    match "templates/code/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext


-- Route to simplify URL. I.e. of form http://aah.io/post/title-of-post/
niceRoute :: Routes
niceRoute = customRoute creatIndexRoute
    where
        creatIndexRoute ident =
            takeDirectory p </> takeBaseName p </> "index.html"
                where p = toFilePath ident

-- Remove all foo/bar/index.html links, replace with foo/bar/
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item


removeIndexStr :: String -> String
removeIndexStr url = case splitFileName url of
    (dir, "index.html") | isLocal dir -> dir
                        | otherwise   -> url
    _                                 -> url
    where isLocal uri = not (isInfixOf "://" uri)
