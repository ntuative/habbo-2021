package com.sulake.habbo.ui.widget.chatinput.styleselector
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.ui.widget.chatinput.RoomChatInputView;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import flash.display.Shape;
    import com.sulake.habbo.session.ISessionDataManager;
    import flash.display.BitmapData;
    import com.sulake.habbo.freeflowchat.style.IChatStyle;
    import flash.display.Sprite;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class ChatStyleSelector implements IDisposable 
    {

        private static const GRID_SPACING:int = 1;
        private static const MAX_GRID_COLUMNS:int = 3;

        private static var _selected:ChatStyleGridEntry = null;
        private static var _styleRequiresUpdate:Boolean = false;

        private var _chatInputView:RoomChatInputView;
        private var _container:IWindowContainer;
        private var _SafeStr_3968:ChatStyleGridView;
        private var _SafeStr_2515:Vector.<ChatStyleGridEntry> = new Vector.<ChatStyleGridEntry>();
        private var _SafeStr_3969:IWindow;
        private var _SafeStr_3970:Shape;

        public function ChatStyleSelector(_arg_1:RoomChatInputView, _arg_2:IWindowContainer, _arg_3:ISessionDataManager)
        {
            _chatInputView = _arg_1;
            _SafeStr_3968 = new ChatStyleGridView(this, _chatInputView.sessionDataManager);
            _SafeStr_3969 = _arg_1.widget.windowManager.buildFromXML((_arg_1.widget.assets.getAssetByName("chatinput_chatstyle_template_xml").content as XML));
            _container = _arg_2;
            _container.procedure = windowProc;
            _chatInputView.chatStyleMenuContainer.addChild(_SafeStr_3968.window);
            _SafeStr_3968.window.x = 0;
            _SafeStr_3968.window.y = 0;
        }

        public function dispose():void
        {
            while (_SafeStr_2515.length > 1)
            {
                _SafeStr_2515.pop();
            };
            _SafeStr_2515 = null;
            _SafeStr_3968.dispose();
            _SafeStr_3968 = null;
            if (((_SafeStr_3970) && (_SafeStr_3970.parent)))
            {
                _SafeStr_3970.parent.removeChild(_SafeStr_3970);
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_3968 == null);
        }

        public function get chatInputView():RoomChatInputView
        {
            return (_chatInputView);
        }

        public function addItem(_arg_1:int, _arg_2:BitmapData):void
        {
            _SafeStr_2515.push(new ChatStyleGridEntry(_arg_1, _arg_2));
            var _local_3:IWindowContainer = getGridItemWindowWrapper(_arg_2);
            _SafeStr_3968.grid.addGridItem(_local_3);
            _local_3.findChildByName("background_color").visible = false;
        }

        public function get selectedStyleId():int
        {
            if (((_styleRequiresUpdate) && (selected)))
            {
                _styleRequiresUpdate = false;
                return (selected.id);
            };
            return (-1);
        }

        public function get selectedStyleBitmap():BitmapData
        {
            if (selected)
            {
                return (selected.bitmap);
            };
            return (null);
        }

        public function initSelection():void
        {
            selected = selected;
            _styleRequiresUpdate = false;
        }

        public function set gridColumns(_arg_1:int):void
        {
            _arg_1 = Math.min(_arg_1, 3);
            var _local_2:int = (((_arg_1 - 1) * (_SafeStr_3969.width + 1)) + _SafeStr_3969.width);
            if (_arg_1 > 1)
            {
                _SafeStr_3968.grid.width = _local_2;
            }
            else
            {
                _SafeStr_3968.grid.width = (_SafeStr_3969.width + 16);
            };
        }

        private function set selected(_arg_1:ChatStyleGridEntry):void
        {
            _selected = _arg_1;
            _styleRequiresUpdate = true;
            var _local_4:IChatStyle = _chatInputView.widget.roomUi.chatStyleLibrary.getStyle(_arg_1.id);
            if (_chatInputView.window.findChildByName("chat_bg_preview") == null)
            {
                return;
            };
            var _local_2:Sprite = _local_4.getNewBackgroundSprite(0xFFFFFF);
            var _local_3:IDisplayObjectWrapper = IDisplayObjectWrapper(_chatInputView.window.findChildByName("chat_bg_preview"));
            _local_2.width = (_local_3.width + _local_4.overlap.width);
            _local_2.height = ((_local_3.height + _local_4.overlap.y) + _local_4.overlap.height);
            _local_2.y = (_local_2.y - _local_4.overlap.y);
            if (!_SafeStr_3970)
            {
                _SafeStr_3970 = new Shape();
            }
            else
            {
                _SafeStr_3970.graphics.clear();
            };
            _SafeStr_3970.graphics.beginFill(0xFF0000);
            _SafeStr_3970.graphics.drawRect(0, 0, (_local_2.width - 28), _local_2.height);
            _local_3.setDisplayObject(_local_2);
            if (_local_2.parent)
            {
                _local_2.parent.addChild(_SafeStr_3970);
                _SafeStr_3970.x = (_local_2.x + 28);
                _SafeStr_3970.y = _local_2.y;
                _local_2.mask = _SafeStr_3970;
            };
            _chatInputView.setInputFieldColor((_local_4.textFormat.color as uint));
        }

        private function get selected():ChatStyleGridEntry
        {
            if (_selected == null)
            {
                _selected = _SafeStr_2515[(_SafeStr_2515.length - 1)];
            };
            return (_selected);
        }

        private function getGridItemWindowWrapper(_arg_1:BitmapData):IWindowContainer
        {
            var _local_2:IWindowContainer = IWindowContainer(_SafeStr_3969.clone());
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_2.findChildByName("bubble_preview"));
            _local_3.bitmap = _arg_1;
            _local_3.center();
            _local_2.procedure = gridItemWindowProc;
            return (_local_2);
        }

        public function alignMenuToSelector():void
        {
            if (_SafeStr_3968.window.visible)
            {
                _SafeStr_3968.alignToSelector(_container);
            };
        }

        private function windowProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_3968.window.visible = (!(_SafeStr_3968.window.visible));
                alignMenuToSelector();
            };
        }

        private function gridItemWindowProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _SafeStr_3968.grid.getGridItemIndex(_arg_2);
                showBackgroundOnlyForItem(_arg_2);
                selected = _SafeStr_2515[_local_3];
                _SafeStr_3968.window.visible = false;
            };
            if (_arg_1.type == "WME_OVER")
            {
                IWindowContainer(_arg_2).findChildByName("background_color").color = 4291875024;
            };
            if (_arg_1.type == "WME_OUT")
            {
                IWindowContainer(_arg_2).findChildByName("background_color").color = 0xFFFFFFFF;
            };
        }

        private function showBackgroundOnlyForItem(_arg_1:IWindow):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3968.grid.numGridItems)
            {
                IWindowContainer(_SafeStr_3968.grid.getGridItemAt(_local_2)).findChildByName("background_color").visible = false;
                _local_2++;
            };
            IWindowContainer(_arg_1).findChildByName("background_color").visible = true;
        }


    }
}

