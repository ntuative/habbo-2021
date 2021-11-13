package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.iterators.EmptyIterator;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class IlluminaChatBubbleWidget implements IIlluminaChatBubbleWidget
    {

        public static const TYPE:String = "illumina_chat_bubble";
        private static const _SafeStr_4430:String = "illumina_chat_bubble:flipped";
        private static const USER_NAME_KEY:String = "illumina_chat_bubble:user_name";
        private static const FIGURE_KEY:String = "illumina_chat_bubble:figure";
        private static const MESSAGE_KEY:String = "illumina_chat_bubble:message";
        private static const FLIPPED_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:flipped", false, "Boolean");
        private static const USER_NAME_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:user_name", "", "String");
        private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:figure", "", "String");
        private static const MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_chat_bubble:message", "", "String");

        private var _disposed:Boolean;
        private var _SafeStr_4407:IWidgetWindow;
        private var _windowManager:HabboWindowManagerComponent;
        private var _SafeStr_1165:IWindowContainer;
        private var _flipped:Boolean = FLIPPED_DEFAULT.value;
        private var _userName:ILabelWindow;
        private var _SafeStr_4431:IWindow;
        private var _avatarWidget:IAvatarImageWidget;
        private var _SafeStr_4432:IWindow;
        private var _SafeStr_835:ITextWindow;
        private var _postTime:IUpdatingTimeStampWidget;
        private var _offline:IRegionWindow;
        private var _arrowPoint:IStaticBitmapWrapperWindow;
        private var _SafeStr_958:Boolean;

        public function IlluminaChatBubbleWidget(_arg_1:IWidgetWindow, _arg_2:HabboWindowManagerComponent)
        {
            _SafeStr_4407 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1165 = (_windowManager.buildFromXML((_windowManager.assets.getAssetByName("illumina_chat_bubble_xml").content as XML)) as IWindowContainer);
            _userName = (_SafeStr_1165.findChildByName("user_name") as ILabelWindow);
            var _local_3:IWidgetWindow = (_SafeStr_1165.findChildByName("user_avatar") as IWidgetWindow);
            _SafeStr_4431 = _local_3.parent;
            _avatarWidget = (_local_3.widget as IAvatarImageWidget);
            _SafeStr_4432 = _SafeStr_1165.findChildByName("bubble_wrapper");
            _SafeStr_835 = (_SafeStr_1165.findChildByName("message") as ITextWindow);
            _postTime = (IWidgetWindow(_SafeStr_1165.findChildByName("post_time")).widget as IUpdatingTimeStampWidget);
            _offline = (_SafeStr_1165.findChildByName("offline_placeholder") as IRegionWindow);
            _offline.height = 0;
            _arrowPoint = (_SafeStr_1165.findChildByName("arrow_point") as IStaticBitmapWrapperWindow);
            _SafeStr_1165.findChildByName("message_region").setParamFlag(1, false);
            _SafeStr_1165.procedure = rootProcedure;
            userName = String(USER_NAME_DEFAULT.value);
            figure = String(FIGURE_DEFAULT.value);
            message = String(MESSAGE_DEFAULT.value);
            _SafeStr_4407.rootWindow = _SafeStr_1165;
            _SafeStr_4407.setParamFlag(147456);
            _SafeStr_1165.width = _SafeStr_4407.width;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_1165 != null)
                {
                    _SafeStr_1165.dispose();
                    _SafeStr_1165 = null;
                };
                if (_SafeStr_4407 != null)
                {
                    _SafeStr_4407.rootWindow = null;
                    _SafeStr_4407 = null;
                };
                _windowManager = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get iterator():IIterator
        {
            return (EmptyIterator.INSTANCE);
        }

        public function get properties():Array
        {
            var _local_1:Array = [];
            if (_disposed)
            {
                return (_local_1);
            };
            _local_1.push(FLIPPED_DEFAULT.withValue(flipped));
            _local_1.push(USER_NAME_DEFAULT.withValue(userName));
            _local_1.push(FIGURE_DEFAULT.withValue(figure));
            _local_1.push(MESSAGE_DEFAULT.withValue(message));
            return (_local_1);
        }

        public function set properties(_arg_1:Array):void
        {
            if (_disposed)
            {
                return;
            };
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "illumina_chat_bubble:flipped":
                        flipped = _local_2.value;
                        break;
                    case "illumina_chat_bubble:user_name":
                        userName = String(_local_2.value);
                        break;
                    case "illumina_chat_bubble:figure":
                        figure = String(_local_2.value);
                        break;
                    case "illumina_chat_bubble:message":
                        message = String(_local_2.value);
                };
            };
        }

        public function get flipped():Boolean
        {
            return (_flipped);
        }

        public function set flipped(_arg_1:Boolean):void
        {
            _flipped = _arg_1;
            refresh();
        }

        public function get userName():String
        {
            return (_userName.caption.slice(0, -1));
        }

        public function set userName(_arg_1:String):void
        {
            _userName.caption = (_arg_1 + ":");
        }

        public function get userId():int
        {
            return (_avatarWidget.userId);
        }

        public function set userId(_arg_1:int):void
        {
            _avatarWidget.userId = _arg_1;
        }

        public function get figure():String
        {
            return (_avatarWidget.figure);
        }

        public function set figure(_arg_1:String):void
        {
            _avatarWidget.figure = _arg_1;
        }

        public function get message():String
        {
            return (_SafeStr_835.caption);
        }

        public function set message(_arg_1:String):void
        {
            _SafeStr_835.caption = _arg_1;
        }

        public function get timeStamp():Number
        {
            return (_postTime.timeStamp);
        }

        public function set timeStamp(_arg_1:Number):void
        {
            _postTime.timeStamp = _arg_1;
        }

        public function set friendOnlineStatus(_arg_1:Boolean):void
        {
            _offline.height = ((_arg_1) ? 0 : 16);
        }

        public function refresh():void
        {
            if (_SafeStr_958)
            {
                return;
            };
            _SafeStr_958 = true;
            _SafeStr_1165.limits.minWidth = _SafeStr_1165.width;
            _SafeStr_1165.limits.maxWidth = _SafeStr_1165.width;
            _SafeStr_1165.height = _SafeStr_4432.bottom;
            _SafeStr_4432.width = (_SafeStr_1165.width - _SafeStr_4431.width);
            _SafeStr_835.width = _SafeStr_4432.width;
            _avatarWidget.direction = ((_flipped) ? 4 : 2);
            if (_flipped)
            {
                _SafeStr_4431.x = (_SafeStr_1165.width - _SafeStr_4431.width);
                _arrowPoint.zoomX = 1;
                _arrowPoint.x = _SafeStr_4431.x;
                _SafeStr_4432.x = 0;
            }
            else
            {
                _SafeStr_4431.x = 0;
                _arrowPoint.zoomX = -1;
                _arrowPoint.x = (_SafeStr_4431.right - _arrowPoint.width);
                _SafeStr_4432.x = _SafeStr_4431.right;
            };
            _SafeStr_1165.limits.setEmpty();
            _arrowPoint.invalidate();
            _SafeStr_958 = false;
        }

        private function rootProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WE_RESIZED":
                    refresh();
                    return;
                case "WE_CHILD_RESIZED":
                    refresh();
                    return;
                case "WME_CLICK":
                    if (((userId > 0) && (_arg_2.name == "user_name_region")))
                    {
                        _windowManager.communication.connection.send(new GetExtendedProfileMessageComposer(userId));
                    };
                    return;
            };
        }


    }
}