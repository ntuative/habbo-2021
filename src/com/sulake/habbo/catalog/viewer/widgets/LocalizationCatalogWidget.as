package com.sulake.habbo.catalog.viewer.widgets
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IHTMLTextWindow;
    import com.sulake.habbo.catalog.navigation.ICatalogNode;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowLinkEvent;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.text.StyleSheet;
    import com.sulake.core.window.components.ITextWindow;

    public class LocalizationCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_1576:Dictionary;
        private var _catalog:HabboCatalog;

        public function LocalizationCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _SafeStr_1576 = new Dictionary();
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            super.dispose();
            _catalog = null;
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            initLocalizables();
            initStaticImages();
            initLinks();
            events.addEventListener("SELECT_PRODUCT", onProductSelected);
            return (true);
        }

        private function onProductSelected(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
        }

        private function initLinks():void
        {
            var _local_2:IWindow;
            if (page.hasLinks)
            {
                for each (var _local_1:String in page.links)
                {
                    _local_2 = _window.findChildByName(_local_1);
                    if (_local_2 != null)
                    {
                        _local_2.setParamFlag(1);
                        _local_2.mouseThreshold = 0;
                        _local_2.addEventListener("WME_CLICK", onClickLink);
                    };
                };
            };
        }

        private function onClickLink(_arg_1:WindowMouseEvent):void
        {
            var _local_4:IHabboLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
            var _local_2:ICoreConfiguration = (page.viewer.catalog as HabboCatalog);
            var _local_6:String = IWindow(_arg_1.target).name;
            var _local_5:String = "";
            switch (page.layoutCode)
            {
                case "frontpage3":
                    switch (_local_6)
                    {
                        case "ctlg_txt3":
                            if (IWindow(_arg_1.target).caption != "")
                            {
                                _local_5 = page.localization.getTextElementContent(6);
                                page.viewer.catalog.openCatalogPage(_local_5);
                            };
                            break;
                        case "ctlg_txt7":
                            if (IWindow(_arg_1.target).caption != "")
                            {
                                _local_5 = page.localization.getTextElementContent(10);
                                if (_local_5.indexOf("http") >= 0)
                                {
                                    openExternalLink(_local_5);
                                }
                                else
                                {
                                    if (_local_5 == "credits")
                                    {
                                        HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                                    }
                                    else
                                    {
                                        page.viewer.catalog.openCatalogPage(_local_5);
                                    };
                                };
                            };
                    };
                    return;
                case "info_pixels":
                    switch (_local_6)
                    {
                        case "ctlg_text_5":
                            _catalog.questEngine.showAchievements();
                            break;
                        case "ctlg_text_7":
                            _local_5 = page.localization.getTextElementContent(7);
                            page.viewer.catalog.openCatalogPage(_local_5);
                    };
                    return;
                case "info_credits":
                    switch (_local_6)
                    {
                        case "ctlg_text_5":
                            HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                            break;
                        case "ctlg_text_7":
                            _local_5 = page.localization.getTextElementContent(7);
                            page.viewer.catalog.openCatalogPage(_local_5);
                    };
                    return;
                case "collectibles":
                    switch (_local_6)
                    {
                        case "ctlg_collectibles_link":
                            _local_5 = _local_2.getProperty("link.format.collectibles");
                            openExternalLink(_local_5);
                    };
                    return;
                case "club1":
                    switch (_local_6)
                    {
                        case "ctlg_text_5":
                            page.viewer.catalog.openCatalogPage("hc_membership");
                    };
                    return;
                case "club_buy":
                    switch (_local_6)
                    {
                        case "club_link":
                            _local_5 = _local_2.getProperty("link.format.club");
                            openExternalLink(_local_5);
                    };
                    return;
                case "mad_money":
                    switch (_local_6)
                    {
                        case "ctlg_madmoney_button":
                            _local_5 = _local_2.getProperty("link.format.madmoney");
                            openExternalLink(_local_5);
                    };
                    return;
                case "monkey":
                    switch (_local_6)
                    {
                        case "ctlg_teaserimg_1_region":
                        case "ctlg_special_img_region":
                            _local_5 = _local_4.getLocalization("link.format.monkey", "http://store.apple.com/");
                            openExternalLink(_local_5);
                    };
                    return;
                case "niko":
                    switch (_local_6)
                    {
                        case "ctlg_teaserimg_1_region":
                        case "ctlg_special_img_region":
                            _local_5 = _local_4.getLocalization("link.format.niko", "http://itunes.apple.com/us/app/niko/id481670205?mt=8");
                            openExternalLink(_local_5);
                    };
                    return;
                default:
                    Logger.log(("[Localization Catalog Widget] Unhandled link clicked" + [page.layoutCode, _local_6]));
                    return;
            };
        }

        private function openExternalLink(_arg_1:String):void
        {
            if (_arg_1 != "")
            {
                page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, onExternalLink);
                HabboWebTools.navigateToURL(_arg_1, "habboMain");
            };
        }

        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        private function initStaticImages():void
        {
            var _local_4:String;
            var _local_2:String;
            var _local_1:Array = [];
            _window.groupChildrenWithTag("STATIC_IMAGE", _local_1, 10);
            for each (var _local_3:IWindow in _local_1)
            {
                if ((_local_3 is IBitmapWrapperWindow))
                {
                    _local_4 = _local_3.name;
                    _local_2 = _local_3.name;
                    _SafeStr_1576[_local_2] = _local_4;
                    if (page.viewer.catalog.assets.hasAsset(_local_2))
                    {
                        setElementImage(_local_4, _local_2);
                    }
                    else
                    {
                        retrieveCatalogImage(_local_2);
                    };
                };
            };
        }

        protected function initLocalizables():void
        {
            var _local_9:String;
            var _local_6:String;
            var _local_8:IWindow;
            var _local_5:String = null;
            var _local_4:int;
            _SafeStr_1576 = new Dictionary();
            _catalog.mainContainer.findChildByName("catalog.header.description").caption = "";
            _local_4 = 0;
            while (_local_4 < page.localization.textCount)
            {
                _local_9 = page.localization.getTextElementName(_local_4, page.layoutCode);
                _local_6 = page.localization.getTextElementContent(_local_4);
                if (_local_9 == "catalog.header.description")
                {
                    _local_8 = _catalog.mainContainer.findChildByName(_local_9);
                }
                else
                {
                    if (_window != null)
                    {
                        _local_8 = _window.findChildByName(_local_9);
                    };
                };
                if (_local_8 != null)
                {
                    _local_6 = _local_6.replace(/\r\n/g, "\n");
                    _local_8.caption = _local_6;
                    if ((_local_8 is IHTMLTextWindow))
                    {
                        _local_8.addEventListener("WE_LINK", onClickHtmlLink);
                        setLinkStyle((_local_8 as IHTMLTextWindow));
                    };
                }
                else
                {
                    Logger.log(((("[Localization Catalog Widget] Could not place text in layout:  element: " + _local_9) + ", content: ") + _local_6));
                };
                _local_4++;
            };
            _local_4 = 0;
            while (_local_4 < page.localization.imageCount)
            {
                _local_9 = page.localization.getImageElementName(_local_4, page.layoutCode);
                _local_6 = page.localization.getImageElementContent(_local_4);
                if (_local_9 != "")
                {
                    if (_local_6 != "")
                    {
                        _local_5 = _local_6;
                        _SafeStr_1576[_local_5] = _local_9;
                        if (page.viewer.catalog.assets.hasAsset(_local_5))
                        {
                            setElementImage(_local_9, _local_5);
                        }
                        else
                        {
                            retrieveCatalogImage(_local_5);
                        };
                    };
                };
                _local_4++;
            };
            var _local_1:ICatalogNode = _catalog.currentCatalogNavigator.getNodeById(page.pageId);
            var _local_7:IWindow = _catalog.mainContainer.findChildByName("catalog.header.title");
            var _local_3:IStaticBitmapWrapperWindow = (_catalog.mainContainer.findChildByName("catalog.header.icon") as IStaticBitmapWrapperWindow);
            if (_local_7 != null)
            {
                _local_7.caption = ((_local_1 != null) ? _local_1.localization : ((page.mode == 1) ? "${catalog.search.header}" : "${catalog.header}"));
            };
            if (((!(_local_3 == null)) && (!(_local_1 == null))))
            {
                _local_3.assetUri = ((page.mode == 1) ? "common_small_pen" : ((_catalog.catalogType == "BUILDERS_CLUB") ? (_catalog.imageGalleryHost + "icon_193.png") : ((_catalog.imageGalleryHost + _local_1.iconName) + ".png")));
            };
        }

        private function onClickHtmlLink(_arg_1:WindowEvent):void
        {
            var _local_2:WindowLinkEvent = (_arg_1 as WindowLinkEvent);
            if (_local_2 != null)
            {
                Logger.log(("=============== HTML LINK: " + _local_2.link));
            }
            else
            {
                Logger.log(("=============== BAD HTML LINK: " + _arg_1.target));
            };
        }

        private function setElementImage(_arg_1:String, _arg_2:String):void
        {
            var _local_9:IWindow;
            var _local_7:BitmapDataAsset;
            var _local_4:BitmapData;
            var _local_3:int;
            var _local_5:int;
            var _local_8:String;
            var _local_6:String;
            Logger.log(("[Localization Catalog Widget] Set Element Image: " + [_arg_1, _arg_2]));
            if (_window == null)
            {
                Logger.log(("[Localization Catalog Widget] Window is null! " + [_arg_1, _arg_2]));
                return;
            };
            if (_window.disposed)
            {
                Logger.log(("[Localization Catalog Widget] Window is disposed! " + [_arg_1, _arg_2, _window.name]));
                return;
            };
            if (_arg_1 == "catalog.header.image")
            {
                _local_9 = _catalog.mainContainer.findChildByName(_arg_1);
            }
            else
            {
                _local_9 = _window.findChildByName(_arg_1);
            };
            if ((_local_9 is IBitmapWrapperWindow))
            {
                _local_7 = (page.viewer.catalog.assets.getAssetByName(_arg_2) as BitmapDataAsset);
                if (_local_7 == null)
                {
                    Logger.log(("[Localization Catalog Widget] Asset does not exist (Bitmap window): " + [_arg_1, _arg_2]));
                    return;
                };
                _local_4 = (_local_7.content as BitmapData);
                if ((_local_9 as IBitmapWrapperWindow).bitmap == null)
                {
                    (_local_9 as IBitmapWrapperWindow).bitmap = new BitmapData(_local_9.width, _local_9.height, true, 0xFFFFFF);
                };
                (_local_9 as IBitmapWrapperWindow).bitmap.fillRect((_local_9 as IBitmapWrapperWindow).bitmap.rect, 0xFFFFFF);
                _local_3 = int(((_local_9.width - _local_4.width) / 2));
                _local_5 = int(((_local_9.height - _local_4.height) / 2));
                (_local_9 as IBitmapWrapperWindow).bitmap.copyPixels(_local_4, _local_4.rect, new Point(_local_3, _local_5), null, null, true);
            }
            else
            {
                if ((_local_9 is IStaticBitmapWrapperWindow))
                {
                    _local_8 = _catalog.getProperty("image.library.catalogue.url");
                    _local_6 = ((_local_8 + _arg_2) + ".gif");
                    Logger.log(("[Localization Catalog Widget] Static Image: " + _local_6));
                    (_local_9 as IStaticBitmapWrapperWindow).assetUri = _local_6;
                }
                else
                {
                    Logger.log(("[Localization Catalog Widget] Could not find element: " + _arg_1));
                };
            };
        }

        private function retrieveCatalogImage(_arg_1:String):void
        {
            var _local_5:String = null;
            var _local_9:IWindow;
            var _local_6:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.catalogue.url");
            var _local_2:String = ((page.viewer.catalog as HabboCatalog).getProperty("image.library.url") + "Top_Story_Images/");
            var _local_8:String = _SafeStr_1576[_arg_1];
            if (_local_8 == "catalog.header.image")
            {
                _local_9 = _catalog.mainContainer.findChildByName(_local_8);
            }
            else
            {
                _local_9 = _window.findChildByName(_local_8);
            };
            if (((_local_9) && (_local_9.tags.indexOf("TOP_STORY") > -1)))
            {
                _local_5 = _local_2;
            }
            else
            {
                _local_5 = _local_6;
            };
            var _local_7:String = ((_local_5 + _arg_1) + ".gif");
            Logger.log(("[Localization Catalog Widget]  : " + _local_7));
            var _local_3:URLRequest = new URLRequest(_local_7);
            var _local_4:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(_arg_1, _local_3, "image/gif");
            _local_4.addEventListener("AssetLoaderEventComplete", onCatalogImageReady);
        }

        private function onCatalogImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:String;
            var _local_4:String;
            var _local_3:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_3 != null)
            {
                _local_2 = _local_3.assetName;
                _local_4 = _SafeStr_1576[_local_2];
                setElementImage(_local_4, _local_2);
            };
        }

        private function setLinkStyle(_arg_1:ITextWindow):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_6:StyleSheet = new StyleSheet();
            var _local_2:Object = {};
            _local_2.color = "#336a95";
            var _local_3:Object = {};
            _local_3.textDecoration = "underline";
            _local_3.color = "#333333";
            var _local_5:Object = {};
            _local_5.color = "#41b7d9";
            var _local_4:Object = {};
            _local_4.textDecoration = "underline";
            _local_6.setStyle("a:link", _local_3);
            _local_6.setStyle("a:hover", _local_2);
            _local_6.setStyle("a:active", _local_5);
            _local_6.setStyle(".visited", _local_4);
            _arg_1.styleSheet = _local_6;
        }


    }
}

