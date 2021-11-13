package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import flash.events.Event;
    import com.sulake.habbo.session.furniture.IFurnitureData;

    public class CatalogViewer implements ICatalogViewer 
    {

        private var _catalog:HabboCatalog;
        private var _container:IWindowContainer;
        private var _currentPage:ICatalogPage;
        private var _forceRefresh:Boolean;
        private var _previousPageId:int;

        public function CatalogViewer(_arg_1:HabboCatalog, _arg_2:IWindowContainer)
        {
            _catalog = _arg_1;
            _container = _arg_2;
        }

        public function get roomEngine():IRoomEngine
        {
            return (_catalog.roomEngine);
        }

        public function dispose():void
        {
            if (_currentPage)
            {
                _currentPage.dispose();
                _currentPage = null;
            };
            _catalog = null;
            _container = null;
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function showCatalogPage(_arg_1:int, _arg_2:String, _arg_3:IPageLocalization, _arg_4:Vector.<IPurchasableOffer>, _arg_5:int, _arg_6:Boolean):void
        {
            Logger.log(("[Catalog Viewer] Show Catalog Page: " + [_arg_1, _arg_2, _arg_4.length, _arg_5]));
            if (_currentPage != null)
            {
                if (((!(_forceRefresh)) && (_currentPage.pageId == _arg_1)))
                {
                    if (_arg_5 > -1)
                    {
                        _currentPage.selectOffer(_arg_5);
                    };
                    return;
                };
                disposeCurrentPage();
            };
            var _local_7:ICatalogPage = new CatalogPage(this, _arg_1, _arg_2, _arg_3, _arg_4, _catalog, _arg_6);
            _currentPage = _local_7;
            _previousPageId = ((_arg_1 > -12345678) ? _arg_1 : _previousPageId);
            if (_local_7.window != null)
            {
                _container.addChild(_local_7.window);
                _local_7.window.height = _container.height;
                _container.width = _local_7.window.width;
                _container.x = ((_container.parent.width - _container.width) - 8);
                if (_container.x < 130)
                {
                    _catalog.setLeftPaneVisibility(false);
                }
                else
                {
                    _catalog.setLeftPaneVisibility(true);
                };
            }
            else
            {
                Logger.log(("[CatalogViewer] No window for page: " + _arg_2));
            };
            _container.visible = true;
            _forceRefresh = false;
            _local_7.selectOffer(_arg_5);
        }

        public function disposeCurrentPage():void
        {
            if (_currentPage != null)
            {
                _container.removeChild(_currentPage.window);
                _currentPage.dispose();
                _container.invalidate();
            };
        }

        public function catalogWindowClosed():void
        {
            if (_currentPage != null)
            {
                _currentPage.closed();
            };
        }

        public function dispatchWidgetEvent(_arg_1:Event):Boolean
        {
            return (_currentPage.dispatchWidgetEvent(_arg_1));
        }

        public function getCurrentLayoutCode():String
        {
            if (_currentPage == null)
            {
                return ("");
            };
            return (_currentPage.layoutCode);
        }

        public function get currentPage():ICatalogPage
        {
            return (_currentPage);
        }

        public function showSearchResults(_arg_1:Vector.<IFurnitureData>):void
        {
            var _local_3:IPurchasableOffer;
            if (_currentPage != null)
            {
                _container.removeChild(_currentPage.window);
                _currentPage.dispose();
            };
            var _local_2:Vector.<IPurchasableOffer> = new Vector.<IPurchasableOffer>(0);
            for each (var _local_5:IFurnitureData in _arg_1)
            {
                _local_3 = new FurnitureOffer(_local_5, _catalog);
                _local_2.push(_local_3);
            };
            var _local_4:ICatalogPage = new CatalogPage(this, -1, "default_3x3", new PageLocalization(["catalog_header_roombuilder", "credits_v3_teaser"], ["${catalog.search.results}"]), _local_2, _catalog, false, 1);
            _currentPage = _local_4;
            if (_local_4.window != null)
            {
                _container.addChild(_local_4.window);
                _local_4.window.width = _container.width;
                _local_4.window.height = _container.height;
            }
            else
            {
                Logger.log("[CatalogViewer] No window for page: <SEARCH>");
            };
            _container.visible = true;
        }

        public function get viewerTags():Array
        {
            return ((_container) ? _container.tags : []);
        }

        public function setForceRefresh():void
        {
            _forceRefresh = true;
        }

        public function get previousPageId():int
        {
            return (_previousPageId);
        }


    }
}

