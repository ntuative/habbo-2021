package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;

    public class CatalogWidget implements ICatalogWidget 
    {

        protected var _window:IWindowContainer;
        protected var _SafeStr_913:IEventDispatcher;
        private var _page:ICatalogPage;
        private var _disposed:Boolean;
        protected var _isEmbedded:Boolean = false;

        public function CatalogWidget(_arg_1:IWindowContainer)
        {
            _window = _arg_1;
            _isEmbedded = (_arg_1.tags.indexOf("EMBEDDED") > -1);
        }

        public function set page(_arg_1:ICatalogPage):void
        {
            _page = _arg_1;
        }

        public function set events(_arg_1:IEventDispatcher):void
        {
            _SafeStr_913 = _arg_1;
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function get events():IEventDispatcher
        {
            return (_SafeStr_913);
        }

        public function get page():ICatalogPage
        {
            return (_page);
        }

        public function dispose():void
        {
            _SafeStr_913 = null;
            _page = null;
            _window = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function init():Boolean
        {
            return (true);
        }

        public function closed():void
        {
        }

        protected function getAssetXML(_arg_1:String):XML
        {
            if (((((!(page)) || (!(page.viewer))) || (!(page.viewer.catalog))) || (!(page.viewer.catalog.assets))))
            {
                return (null);
            };
            var _local_2:XmlAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2.content as XML);
        }

        protected function attachWidgetView(_arg_1:String):void
        {
            if (_isEmbedded)
            {
                return;
            };
            var _local_2:XML = getAssetXML(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            window.removeChildAt(0);
            if (((((!(window)) || (!(page))) || (!(page.viewer))) || (!(page.viewer.catalog))))
            {
                return;
            };
            window.addChild(page.viewer.catalog.windowManager.buildFromXML(_local_2));
        }

        protected function getAssetBitmapData(_arg_1:String):BitmapData
        {
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2.content as BitmapData);
        }


    }
}

