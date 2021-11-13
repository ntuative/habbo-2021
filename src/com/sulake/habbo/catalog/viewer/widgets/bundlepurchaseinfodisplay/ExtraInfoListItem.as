package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
    import com.sulake.core.window.IWindowContainer;

    public class ExtraInfoListItem implements IDisposable 
    {

        public static const ALIGN_TOP:int = 0;
        public static const ALIGN_BOTTOM:int = 1;
        public static const ALIGN_OVERLAY:int = 2;

        private var _id:int;
        private var _data:ExtraInfoItemData;
        private var _alignment:int;
        private var _alwaysOnTop:Boolean;
        private var _disposed:Boolean = false;
        private var _creationSeconds:Number;
        private var _removalSeconds:Number;
        private var _isItemRemoved:Boolean = false;

        public function ExtraInfoListItem(_arg_1:BundlePurchaseExtraInfoWidget, _arg_2:int, _arg_3:ExtraInfoItemData, _arg_4:int=0, _arg_5:Boolean=false)
        {
            _id = _arg_2;
            _data = _arg_3;
            _alignment = _arg_4;
            _alwaysOnTop = _arg_5;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            _data = null;
            _disposed = true;
        }

        public function get id():int
        {
            return (_id);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function get data():ExtraInfoItemData
        {
            return (_data);
        }

        public function set data(_arg_1:ExtraInfoItemData):void
        {
            _data = _arg_1;
        }

        public function get alignment():int
        {
            return (_alignment);
        }

        public function get alwaysOnTop():Boolean
        {
            return (_alwaysOnTop);
        }

        public function get creationSeconds():Number
        {
            return (_creationSeconds);
        }

        public function set creationSeconds(_arg_1:Number):void
        {
            _creationSeconds = _arg_1;
        }

        public function get isItemRemoved():Boolean
        {
            return (_isItemRemoved);
        }

        public function get removalSeconds():Number
        {
            return (_removalSeconds);
        }

        public function set removalSeconds(_arg_1:Number):void
        {
            _removalSeconds = _arg_1;
            _isItemRemoved = true;
        }

        public function getRenderedWindow():IWindowContainer
        {
            return (null);
        }


    }
}