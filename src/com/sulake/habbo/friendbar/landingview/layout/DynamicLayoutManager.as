package com.sulake.habbo.friendbar.landingview.layout
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Rectangle;

    public class DynamicLayoutManager implements IDisposable 
    {

        public static const PLACEHOLDER_NAME:String = "placeholder_dynamic_widget_slots";
        public static const CONTENT_AREA_START_X:int = 230;
        private static const NUMBER_OF_SLOTS:int = 5;
        private static const RESIZE_TOLERANCE_SCROLLBAR_VISIBILITY:int = 6;
        private static const ABSOLUTE_MINIMUM_HEIGHT:int = 360;

        private var _layout:WidgetContainerLayout;
        private var _SafeStr_2304:IItemListWindow;
        private var _SafeStr_2303:IItemListWindow;
        private var _SafeStr_2298:IItemListWindow;
        private var _SafeStr_2305:IWindowContainer;
        private var _SafeStr_2300:IItemListWindow;
        private var _SafeStr_2301:IWindowContainer;
        private var _SafeStr_1356:Vector.<IWindowContainer> = new Vector.<IWindowContainer>(5);
        private var _SafeStr_2299:IItemListWindow;
        private var _SafeStr_2302:IItemListWindow;
        private var _SafeStr_2306:IWindowContainer;
        private var _SafeStr_2307:IWindow;
        private var _fromTopScrollbar:IScrollbarWindow;
        private var _window:IWindowContainer;
        private var _SafeStr_2308:Boolean = false;
        private var _SafeStr_2309:CommonWidgetSettings;
        private var _SafeStr_2310:int = 10;
        private var _SafeStr_2311:int = 50;
        private var _SafeStr_2312:int = 10;
        private var _SafeStr_2313:int = 80;
        private var _SafeStr_2314:int = 10;
        private var _SafeStr_2315:int = 60;
        private var _SafeStr_2316:int = -1;
        private var _topItemListInitialWidth:int = -1;
        private var _SafeStr_527:Boolean = false;
        private var _SafeStr_2317:IWindow = null;

        public function DynamicLayoutManager(_arg_1:WidgetContainerLayout, _arg_2:CommonWidgetSettings)
        {
            var _local_5:int;
            super();
            _layout = _arg_1;
            _SafeStr_2309 = _arg_2;
            _window = IWindowContainer(_layout.landingView.getXmlWindow("dynamic_widget_grid"));
            var _local_6:IWindow = _layout.window.findChildByName("placeholder_dynamic_widget_slots");
            var _local_3:IWindowContainer = IWindowContainer(_local_6.parent);
            _local_3.addChildAt(_window, _local_3.getChildIndex(_local_6));
            _local_3.removeChild(_local_6);
            _SafeStr_2304 = IItemListWindow(_window.findChildByName("widgetlist_fromtop"));
            _SafeStr_2305 = IWindowContainer(_window.findChildByName("center_slots_container"));
            _SafeStr_2303 = IItemListWindow(_window.findChildByName("widget_slots_center_scrollable"));
            _SafeStr_2298 = IItemListWindow(_window.findChildByName("widget_slots_center_left"));
            _SafeStr_2300 = IItemListWindow(_window.findChildByName("widget_slots_center_right"));
            _SafeStr_2301 = IWindowContainer(_window.findChildByName("widget_slots_right"));
            _SafeStr_2299 = IItemListWindow(_window.findChildByName("widget_slot_4_root"));
            _SafeStr_2302 = IItemListWindow(_window.findChildByName("widget_slot_5_root"));
            _SafeStr_2307 = _layout.landingView.getXmlWindow("dynamic_widget_grid_separator");
            _local_5 = 0;
            while (_local_5 < 6)
            {
                _SafeStr_1356[_local_5] = IWindowContainer(_window.findChildByName(("widget_slot_" + (_local_5 + 1))));
                if (_SafeStr_1356[_local_5] != null)
                {
                    _SafeStr_1356[_local_5].addEventListener("WE_RESIZED", contractCenterContainer);
                };
                _local_5++;
            };
            _fromTopScrollbar = IScrollbarWindow(_window.findChildByName("center_container_scrollbar"));
            _SafeStr_2306 = IWindowContainer(_window.findChildByName("scroll_extra_space_container"));
            var _local_7:int = _layout.landingView.dynamicLayoutLeftPaneWidth;
            var _local_4:int = _layout.landingView.dynamicLayoutRightPaneWidth;
            _SafeStr_2298.width = _local_7;
            _SafeStr_2298.limits.maxWidth = _local_7;
            _SafeStr_2299.width = _local_7;
            _SafeStr_2300.width = _local_4;
            _SafeStr_2301.width = _local_4;
            _SafeStr_2301.limits.maxWidth = _local_4;
            _SafeStr_2302.width = _local_4;
            _SafeStr_2303.arrangeListItems();
        }

        public function dispose():void
        {
            var _local_1:int;
            if (!disposed)
            {
                _local_1 = 0;
                while (_local_1 < 6)
                {
                    if (_SafeStr_1356[_local_1])
                    {
                        _SafeStr_1356[_local_1].dispose();
                    };
                    _SafeStr_1356[_local_1] = null;
                    _local_1++;
                };
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
                _layout = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_layout == null);
        }

        public function getDynamicSlotContainer(_arg_1:int):IWindowContainer
        {
            return (_SafeStr_1356[_arg_1]);
        }

        public function enableSeparator(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IItemListWindow;
            var _local_4:ITextWindow;
            switch (_arg_1)
            {
                case 4:
                    _local_3 = _SafeStr_2299;
                    break;
                case 5:
                    _local_3 = _SafeStr_2302;
                    break;
                default:
                    _local_3 = null;
            };
            if (_local_3)
            {
                if (_local_3.numListItems < 2)
                {
                    _local_3.addListItemAt(_SafeStr_2307.clone(), 0);
                };
                _local_4 = ITextWindow(IItemListWindow(_local_3.getListItemAt(0)).getListItemByName("separator_title"));
                _local_4.caption = (("${" + _arg_2) + "}");
                if (_SafeStr_2309 != null)
                {
                    if (_SafeStr_2309.isTextColorSet)
                    {
                        _local_4.textColor = _SafeStr_2309.textColor;
                    };
                    if (_SafeStr_2309.isEtchingColorSet)
                    {
                        _local_4.etchingColor = _SafeStr_2309.etchingColor;
                    };
                    if (_SafeStr_2309.isEtchingPositionSet)
                    {
                        _local_4.etchingPosition = _SafeStr_2309.etchingPosition;
                    };
                };
            };
        }

        private function isSlotOccupied(_arg_1:int):Boolean
        {
            return (_SafeStr_1356[_arg_1].numChildren > 0);
        }

        public function resizeTo(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_2304.height = Math.min(_arg_2, topItemListInitialHeight);
            _SafeStr_2304.height = Math.max(360, _SafeStr_2304.height);
            _SafeStr_2304.width = Math.min(_arg_1, topItemListInitialWidth);
            applyVerticalSize();
        }

        public function set scrollbarRightEdgeRelativeToScreen(_arg_1:int):void
        {
            var _local_2:int = _layout.window.width;
            _arg_1 = (Math.min(_arg_1, _local_2) - _window.x);
            _fromTopScrollbar.x = (_arg_1 - _fromTopScrollbar.width);
        }

        public function get topItemListInitialHeight():int
        {
            if (_SafeStr_2316 == -1)
            {
                _SafeStr_2316 = _SafeStr_2304.height;
            };
            return (_SafeStr_2316);
        }

        public function get topItemListInitialWidth():int
        {
            if (_topItemListInitialWidth == -1)
            {
                _topItemListInitialWidth = _SafeStr_2304.width;
            };
            return (_topItemListInitialWidth);
        }

        private function applyVerticalSize():void
        {
            var _local_1:int;
            clearEmptySlotsForSpace();
            alignTopWidgetRow();
            alignBottomWidgetRow();
            resetToMaximumSpacing();
            setVerticalSpacing((topItemListContentHeight - _SafeStr_2304.height));
            contractCenterContainer();
            adjustScrollbarVisibility();
            setHorizontalSpacing();
            if (!_SafeStr_527)
            {
                _local_1 = 0;
                while (_local_1 < 6)
                {
                    if (_SafeStr_1356[_local_1] != null)
                    {
                        _SafeStr_1356[_local_1].addEventListener("WE_RESIZED", updateLayout);
                    };
                    _local_1++;
                };
            };
            _SafeStr_527 = true;
            _SafeStr_2317 = null;
        }

        private function updateLayout(_arg_1:WindowEvent=null):void
        {
            if (_SafeStr_2317 == null)
            {
                _SafeStr_2317 = _arg_1.window;
                applyVerticalSize();
            };
        }

        private function clearEmptySlotsForSpace():void
        {
            var _local_1:int;
            if (!isSlotOccupied(0))
            {
                _SafeStr_1356[0].height = 0;
            };
            _local_1 = 1;
            while (_local_1 <= 4)
            {
                if (!isSlotOccupied(_local_1))
                {
                    _SafeStr_1356[_local_1].height = 1;
                };
                _local_1++;
            };
        }

        private function alignBottomWidgetRow():void
        {
            var _local_1:int;
            if (((isSlotOccupied(3)) || (isSlotOccupied(4))))
            {
                _local_1 = Math.max(_SafeStr_1356[3].height, _SafeStr_1356[4].height);
                _SafeStr_1356[3].height = _local_1;
                _SafeStr_1356[4].height = _local_1;
                if (isSlotOccupied(3))
                {
                    _SafeStr_1356[3].getChildAt(0).y = 0;
                    _SafeStr_1356[3].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
                };
                if (isSlotOccupied(4))
                {
                    _SafeStr_1356[4].getChildAt(0).y = 0;
                    _SafeStr_1356[4].width = _layout.landingView.dynamicLayoutRightPaneWidth;
                };
            };
        }

        private function alignTopWidgetRow():int
        {
            var _local_1:int;
            if (((isSlotOccupied(1)) || (isSlotOccupied(2))))
            {
                if (!_SafeStr_2308)
                {
                    _local_1 = Math.max(_SafeStr_1356[1].height, _SafeStr_1356[2].height);
                    _SafeStr_1356[1].height = _local_1;
                    _SafeStr_1356[2].height = _local_1;
                };
                if (isSlotOccupied(1))
                {
                    _SafeStr_1356[1].getChildAt(0).y = 0;
                    _SafeStr_1356[1].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
                };
                if (isSlotOccupied(2))
                {
                    _SafeStr_1356[2].getChildAt(0).y = 0;
                    _SafeStr_1356[2].width = _layout.landingView.dynamicLayoutRightPaneWidth;
                };
            };
            return (_local_1);
        }

        private function setHorizontalSpacing():void
        {
            var _local_1:int = (_topItemListInitialWidth - _SafeStr_2304.width);
            if (_local_1 > (_SafeStr_2315 - _SafeStr_2314))
            {
                _SafeStr_2303.spacing = _SafeStr_2314;
            }
            else
            {
                _SafeStr_2303.spacing = Math.min(_SafeStr_2315, (_SafeStr_2315 - _local_1));
            };
        }

        private function setVerticalSpacing(_arg_1:int):void
        {
            var _local_2:int = (_SafeStr_2311 - _SafeStr_2310);
            var _local_3:int = (_SafeStr_2313 - _SafeStr_2312);
            _arg_1 = (_arg_1 + (_SafeStr_2310 + _SafeStr_2312));
            if (_arg_1 <= 0)
            {
                _SafeStr_2304.spacing = _SafeStr_2312;
                _SafeStr_2298.spacing = _SafeStr_2311;
                _SafeStr_2300.spacing = _SafeStr_2311;
            }
            else
            {
                if (_arg_1 < _local_2)
                {
                    _SafeStr_2304.spacing = _SafeStr_2312;
                    _SafeStr_2298.spacing = (_SafeStr_2311 - _arg_1);
                    _SafeStr_2300.spacing = (_SafeStr_2311 - _arg_1);
                }
                else
                {
                    if (_arg_1 < (_local_2 + _local_3))
                    {
                        _SafeStr_2304.spacing = _SafeStr_2312;
                        _SafeStr_2298.spacing = _SafeStr_2310;
                        _SafeStr_2300.spacing = _SafeStr_2310;
                    }
                    else
                    {
                        _SafeStr_2304.spacing = _SafeStr_2312;
                        _SafeStr_2298.spacing = _SafeStr_2310;
                        _SafeStr_2300.spacing = _SafeStr_2310;
                    };
                };
            };
        }

        private function adjustScrollbarVisibility():void
        {
            _SafeStr_2304.invalidate();
            if (_SafeStr_2304.height < (topItemListContentHeight - 6))
            {
                _fromTopScrollbar.y = _SafeStr_2304.y;
                _fromTopScrollbar.height = _SafeStr_2304.height;
                _fromTopScrollbar.visible = true;
                _fromTopScrollbar.scrollV = 0;
                _SafeStr_2306.y = topItemListContentHeight;
                _SafeStr_2306.height = 25;
                _layout.landingView.toolbarExtensionExtraMargin = true;
            }
            else
            {
                _SafeStr_2306.y = 0;
                _SafeStr_2306.height = 1;
                _layout.landingView.toolbarExtensionExtraMargin = false;
            };
        }

        private function resetToMaximumSpacing():void
        {
            _SafeStr_2303.spacing = _SafeStr_2315;
            _SafeStr_2298.spacing = _SafeStr_2311;
            _SafeStr_2300.spacing = _SafeStr_2311;
            _SafeStr_2304.spacing = _SafeStr_2313;
            _fromTopScrollbar.visible = false;
            _SafeStr_2298.invalidate();
            _SafeStr_2300.invalidate();
            _SafeStr_2303.invalidate();
            _SafeStr_2304.invalidate();
            _SafeStr_2305.invalidate();
        }

        private function get topItemListContentHeight():int
        {
            var _local_3:int;
            var _local_2:int;
            var _local_1:int;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2304.numListItems)
            {
                _local_2 = _SafeStr_2304.getListItemAt(_local_3).height;
                _local_1 = (_local_1 + _local_2);
                if (_local_3 > 0)
                {
                    _local_1 = (_local_1 + _SafeStr_2304.spacing);
                };
                _local_3++;
            };
            return (_local_1);
        }

        private function contractCenterContainer(_arg_1:WindowEvent=null):void
        {
            if (((!(_arg_1 == null)) && (!(_SafeStr_527))))
            {
                return;
            };
            _SafeStr_2298.invalidate();
            _SafeStr_2300.invalidate();
            _SafeStr_2303.height = Math.max(_SafeStr_2298.height, _SafeStr_2300.height);
            _SafeStr_2305.height = Math.max(_SafeStr_2298.height, _SafeStr_2300.height);
        }

        public function set ignoreBottomRightSlot(_arg_1:Boolean):void
        {
            _SafeStr_2308 = _arg_1;
        }

        private function logFinalPositions():void
        {
            var _local_2:int;
            Logger.log("***** Final positions *****");
            var _local_1:Rectangle = new Rectangle();
            _window.getGlobalRectangle(_local_1);
            Logger.log(("Window rect\t\t\t\t\t\t: " + _local_1));
            _SafeStr_2304.getGlobalRectangle(_local_1);
            Logger.log(("All items list rect\t\t\t\t: " + _local_1));
            _SafeStr_2305.getGlobalRectangle(_local_1);
            Logger.log(("Center container itemlist rect\t: " + _local_1));
            _SafeStr_2303.getGlobalRectangle(_local_1);
            Logger.log(("Center itemlist rect\t\t\t: " + _local_1));
            _SafeStr_2298.getGlobalRectangle(_local_1);
            Logger.log(("Left pane itemlist rect\t\t\t: " + _local_1));
            _SafeStr_2300.getGlobalRectangle(_local_1);
            Logger.log(("Right pane itemlist rect\t\t: " + _local_1));
            _SafeStr_2301.getGlobalRectangle(_local_1);
            Logger.log(("Right pane container rect\t\t: " + _local_1));
            _local_2 = 0;
            while (_local_2 < 5)
            {
                _SafeStr_1356[_local_2].getGlobalRectangle(_local_1);
                Logger.log(((("Slot " + _local_2) + " rect\t\t\t    : ") + _local_1));
                _local_2++;
            };
        }


    }
}

