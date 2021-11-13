package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem.ExtraInfoPromoItem;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem.ExtraInfoBundlesInfoItem;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem.ExtraInfoDiscountValueItem;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem.ExtraInfoBonusBadgeItem;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem.ExtraInfoBonusAchievementItem;
    import com.sulake.core.window.IWindow;

    public class ExtraInfoViewManager implements IDisposable, IUpdateReceiver 
    {

        private static const SLIDE_ANIMATION_LENGTH:Number = 0.5;
        private static const MAX_ANIM_Y_OFFSET:int = 28;

        private var _SafeStr_1324:BundlePurchaseExtraInfoWidget;
        private var _catalog:HabboCatalog;
        private var _items:Map;
        private var _SafeStr_1533:int = 0;
        private var _disposed:Boolean = false;
        private var _SafeStr_1534:Number = 0;

        public function ExtraInfoViewManager(_arg_1:BundlePurchaseExtraInfoWidget, _arg_2:HabboCatalog)
        {
            _SafeStr_1324 = _arg_1;
            _catalog = _arg_2;
            _items = new Map();
            _catalog.registerUpdateReceiver(this, 10);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set disposed(_arg_1:Boolean):void
        {
            _disposed = _arg_1;
        }

        public function dispose():void
        {
            if (!disposed)
            {
                _catalog.removeUpdateReceiver(this);
                _SafeStr_1324 = null;
                _catalog = null;
                for each (var _local_1:ExtraInfoListItem in _items)
                {
                    _local_1.dispose();
                };
                _items = null;
                disposed = true;
            };
        }

        public function clear():void
        {
            while (_SafeStr_1324.window.numChildren > 0)
            {
                _SafeStr_1324.window.removeChildAt(0);
            };
            for each (var _local_1:ExtraInfoListItem in _items)
            {
                _local_1.dispose();
            };
            _items = new Map();
            render();
        }

        public function addItem(_arg_1:ExtraInfoItemData):int
        {
            var _local_2:ExtraInfoListItem;
            var _local_3:int = _SafeStr_1533++;
            switch (_arg_1.type)
            {
                case 0:
                    _local_2 = new ExtraInfoPromoItem(_SafeStr_1324, _local_3, _arg_1, _catalog);
                    break;
                case 1:
                    _local_2 = new ExtraInfoBundlesInfoItem(_SafeStr_1324, _local_3, _arg_1, _catalog);
                    break;
                case 2:
                    _local_2 = new ExtraInfoDiscountValueItem(_local_3, _arg_1, _catalog);
                    break;
                case 3:
                    _local_2 = new ExtraInfoBonusBadgeItem(_local_3, _arg_1, _catalog);
                    break;
                case 4:
                    _local_2 = new ExtraInfoBonusAchievementItem(_local_3, _arg_1);
                default:
            };
            _local_2.creationSeconds = _SafeStr_1534;
            _items.add(_local_3, _local_2);
            var _local_4:IWindow = _local_2.getRenderedWindow();
            _local_4.width = _SafeStr_1324.window.width;
            _SafeStr_1324.window.addChild(_local_4);
            sortWindows();
            render();
            return (_local_2.id);
        }

        public function removeItem(_arg_1:int):void
        {
            var _local_2:ExtraInfoListItem = getItem(_arg_1);
            if (_local_2)
            {
                _local_2.removalSeconds = _SafeStr_1534;
                if (_local_2.alignment == 2)
                {
                    reallyRemoveItem(_local_2.id);
                };
                render();
            };
        }

        public function getItem(_arg_1:int):ExtraInfoListItem
        {
            return (ExtraInfoListItem(_items.getValue(_arg_1)));
        }

        private function reallyRemoveItem(_arg_1:int):void
        {
            var _local_2:ExtraInfoListItem = getItem(_arg_1);
            _SafeStr_1324.window.removeChild(_local_2.getRenderedWindow());
            _items.remove(_arg_1);
        }

        private function calculateBounce(_arg_1:Number, _arg_2:Boolean=false):Number
        {
            if (_arg_2)
            {
                return (1 - Math.abs(Math.cos((((_SafeStr_1534 - _arg_1) / 0.5) * (3.14159265358979 / 2)))));
            };
            return (1 - Math.abs(Math.sin((((_SafeStr_1534 - _arg_1) / 0.5) * (3.14159265358979 / 2)))));
        }

        private function render():void
        {
            var _local_5:IWindow;
            var _local_4:Number;
            var _local_1:int;
            var _local_3:int = _SafeStr_1324.window.height;
            var _local_6:Array = _items.getValues();
            for each (var _local_2:ExtraInfoListItem in _local_6)
            {
                _local_5 = _local_2.getRenderedWindow();
                _local_4 = 0;
                if ((_SafeStr_1534 - 0.5) <= _local_2.creationSeconds)
                {
                    _local_4 = calculateBounce(_local_2.creationSeconds);
                };
                if (_local_2.isItemRemoved)
                {
                    _local_4 = calculateBounce(_local_2.removalSeconds, true);
                    if (_SafeStr_1534 > (_local_2.removalSeconds + 0.5))
                    {
                        reallyRemoveItem(_local_2.id);
                        return;
                    };
                };
                if (_local_2.alignment == 0)
                {
                    _local_5.y = _local_1;
                    _local_5.y = (_local_5.y - (_local_4 * Math.min(_local_5.height, 28)));
                    _local_1 = (_local_1 + _local_5.height);
                }
                else
                {
                    if (_local_2.alignment == 1)
                    {
                        _local_5.y = (_local_3 - _local_5.height);
                        _local_5.y = (_local_5.y + (_local_4 * Math.min(_local_5.height, 28)));
                        _local_3 = (_local_3 - _local_5.height);
                    }
                    else
                    {
                        if (_local_2.alignment == 2)
                        {
                            _local_5.y = 0;
                        };
                    };
                };
            };
        }

        private function sortWindows():void
        {
            var _local_2:int = (_SafeStr_1324.window.numChildren - 1);
            for each (var _local_1:ExtraInfoListItem in _items)
            {
                if (_local_1.alwaysOnTop)
                {
                    _SafeStr_1324.window.setChildIndex(_local_1.getRenderedWindow(), _local_2);
                };
            };
        }

        private function get isAnimationInProgress():Boolean
        {
            return (true);
        }

        public function update(_arg_1:uint):void
        {
            _SafeStr_1534 = (_SafeStr_1534 + (_arg_1 / 1000));
            if (isAnimationInProgress)
            {
                render();
            };
        }


    }
}

