package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class RoomChatItem 
    {

        public static const CHAT_ITEM_STACKING_HEIGHT:Number = 18;
        private static const MESSAGE_TEXT_MARGIN_LEFT:int = 6;
        private static const MESSAGE_TEXT_MARGIN_RIGHT:int = 6;
        private static const RESPECT_ICON_MARGIN_RIGHT:int = 35;
        private static const _SafeStr_4251:int = 26;
        private static const NAME:String = "name";
        private static const MESSAGE:String = "message";
        private static const POINTER:String = "pointer";
        private static const BACKGROUND:String = "background";
        private static const TOOLTIP_DRAG_FOR_HISTORY:String = "${chat.history.drag.tooltip}";

        private var _SafeStr_1324:RoomChatWidget;
        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_819:IHabboLocalizationManager;
        private var _view:IRegionWindow;
        private var _SafeStr_1354:IAssetLibrary;
        private var _SafeStr_698:String;
        private var _SafeStr_4252:String;
        private var _aboveLevels:int = 0;
        private var _screenLevel:int = -1;
        private var _SafeStr_4253:int;
        private var _chatStyle:int;
        private var _SafeStr_1721:int;
        private var _senderName:String = new String();
        private var _message:String = new String();
        private var _SafeStr_4254:Array;
        private var _SafeStr_4255:Array;
        private var _timeStamp:int;
        private var _senderX:Number;
        private var _SafeStr_4256:BitmapData;
        private var _senderColor:uint;
        private var _SafeStr_1907:int;
        private var _SafeStr_3881:int;
        private var _SafeStr_4257:int;
        private var _SafeStr_4258:int;
        private var _width:Number = 0;
        private var _SafeStr_4259:Boolean = false;
        private var _topOffset:Number = 0;
        private var _originalBackgroundYOffset:Number = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _SafeStr_4260:Boolean = false;

        public function RoomChatItem(_arg_1:RoomChatWidget, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:String, _arg_5:IHabboLocalizationManager, _arg_6:String)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_2;
            _SafeStr_1354 = _arg_3;
            _SafeStr_698 = _arg_4;
            _SafeStr_819 = _arg_5;
            _SafeStr_4252 = _arg_6;
        }

        public function dispose():void
        {
            if (_view != null)
            {
                _view.dispose();
                _view = null;
                _SafeStr_1324 = null;
                _windowManager = null;
                _SafeStr_819 = null;
                _SafeStr_4256 = null;
            };
        }

        public function define(_arg_1:RoomWidgetChatUpdateEvent):void
        {
            _SafeStr_4253 = _arg_1.chatType;
            _chatStyle = _arg_1.styleId;
            _SafeStr_1721 = _arg_1.userId;
            _senderName = _arg_1.userName;
            _SafeStr_4258 = _arg_1.userCategory;
            _message = _arg_1.text;
            _SafeStr_4254 = _arg_1.links;
            _senderX = _arg_1.userX;
            _SafeStr_4256 = _arg_1.userImage;
            _senderColor = _arg_1.userColor;
            _SafeStr_1907 = _arg_1.roomId;
            _SafeStr_3881 = _arg_1.userType;
            _SafeStr_4257 = _arg_1.petType;
            renderView();
        }

        public function set message(_arg_1:String):void
        {
            _message = _arg_1;
        }

        public function set senderName(_arg_1:String):void
        {
            _senderName = _arg_1;
        }

        public function set senderImage(_arg_1:BitmapData):void
        {
            _SafeStr_4256 = _arg_1;
        }

        public function set senderColor(_arg_1:uint):void
        {
            _senderColor = _arg_1;
        }

        public function set chatType(_arg_1:int):void
        {
            _SafeStr_4253 = _arg_1;
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function get screenLevel():int
        {
            return (_screenLevel);
        }

        public function get timeStamp():int
        {
            return (_timeStamp);
        }

        public function get senderX():Number
        {
            return (_senderX);
        }

        public function set senderX(_arg_1:Number):void
        {
            _senderX = _arg_1;
        }

        public function get width():Number
        {
            return (_width);
        }

        public function get height():Number
        {
            return (18);
        }

        public function get message():String
        {
            return (_message);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get aboveLevels():int
        {
            return (_aboveLevels);
        }

        public function set aboveLevels(_arg_1:int):void
        {
            _aboveLevels = _arg_1;
        }

        public function set screenLevel(_arg_1:int):void
        {
            _screenLevel = _arg_1;
        }

        public function set timeStamp(_arg_1:int):void
        {
            _timeStamp = _arg_1;
        }

        public function set x(_arg_1:Number):void
        {
            _x = _arg_1;
            if (_view != null)
            {
                _view.x = _arg_1;
            };
        }

        public function set y(_arg_1:Number):void
        {
            _y = _arg_1;
            if (_view != null)
            {
                _view.y = ((_arg_1 - _topOffset) + _originalBackgroundYOffset);
            };
        }

        public function hidePointer():void
        {
            var _local_1:IWindow;
            if (_view)
            {
                _local_1 = _view.findChildByName("pointer");
                if (_local_1)
                {
                    _local_1.visible = false;
                };
            };
        }

        public function setPointerOffset(_arg_1:Number):void
        {
            if (((!(_view)) || (_view.disposed)))
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_view.findChildByName("pointer") as IBitmapWrapperWindow);
            var _local_2:IBitmapWrapperWindow = (_view.findChildByName("middle") as IBitmapWrapperWindow);
            if (((_local_2 == null) || (_local_3 == null)))
            {
                return;
            };
            _local_3.visible = true;
            _arg_1 = (_arg_1 + (_view.width / 2));
            _arg_1 = Math.min(_arg_1, (_local_2.rectangle.right - _local_3.width));
            _arg_1 = Math.max(_arg_1, _local_2.rectangle.left);
            _local_3.x = _arg_1;
        }

        public function checkOverlap(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):Boolean
        {
            var _local_6:Rectangle = new Rectangle(_x, _y, width, _arg_1);
            var _local_7:Rectangle = new Rectangle(_arg_2, _arg_3, _arg_4, _arg_5);
            return (_local_6.intersects(_local_7));
        }

        public function hideView():void
        {
            if (_view)
            {
                _view.dispose();
            };
            _view = null;
            _SafeStr_4259 = false;
        }

        private function get isNotify():Boolean
        {
            return (_chatStyle == 1);
        }

        public function renderView():void
        {
            var _local_15:IBitmapWrapperWindow;
            var _local_14:int;
            var _local_12:int;
            var _local_16:int;
            var _local_4:int;
            var _local_7:int;
            var _local_17:String;
            var _local_18:String;
            var _local_2:int;
            var _local_20:TextFormat;
            var _local_10:Array;
            if (_SafeStr_4259)
            {
                return;
            };
            _SafeStr_4259 = true;
            if (_view)
            {
                return;
            };
            _view = RoomChatWidget.chatBubbleFactory.getBubbleWindow(_chatStyle, _SafeStr_4253);
            if (!_view)
            {
                return;
            };
            _view.toolTipIsDynamic = true;
            var _local_9:IBitmapWrapperWindow = (_view.findChildByName("background") as IBitmapWrapperWindow);
            var _local_13:ILabelWindow = (_view.findChildByName("name") as ILabelWindow);
            var _local_5:ITextWindow = (_view.findChildByName("message") as ITextWindow);
            var _local_3:IBitmapWrapperWindow = (_view.findChildByName("pointer") as IBitmapWrapperWindow);
            var _local_1:Number = _view.height;
            var _local_19:BitmapData = RoomChatWidget.chatBubbleFactory.getPointerBitmapData(_chatStyle);
            _originalBackgroundYOffset = _local_9.y;
            var _local_8:int = ((_local_5.x <= 26) ? 0 : (_local_5.x - 26));
            if (_SafeStr_4256 != null)
            {
                _topOffset = Math.max(0, ((_SafeStr_4256.height - _local_9.height) / 2));
                _local_1 = Math.max(_local_1, _SafeStr_4256.height);
                _local_1 = Math.max(_local_1, _local_9.height);
            };
            _width = 0;
            _view.x = _x;
            _view.y = _y;
            _view.width = 0;
            _view.height = _local_1;
            enableDragTooltip();
            addEventListeners(_view);
            if (((_SafeStr_4256) && (!(isNotify))))
            {
                _local_15 = (_view.findChildByName("user_image") as IBitmapWrapperWindow);
                if (_local_15)
                {
                    _local_15.width = _SafeStr_4256.width;
                    _local_15.height = _SafeStr_4256.height;
                    _local_15.bitmap = _SafeStr_4256;
                    _local_15.disposesBitmap = false;
                    _local_14 = int((_local_15.x - (_SafeStr_4256.width / 2)));
                    _local_12 = int(Math.max(0, ((_local_9.height - _SafeStr_4256.height) / 2)));
                    if (_SafeStr_3881 == 2)
                    {
                        if (_SafeStr_4257 == 15)
                        {
                            if (_SafeStr_4256.height > _local_9.height)
                            {
                                _local_12 = int(((_SafeStr_4256.height - _local_9.height) / 2));
                            };
                        };
                    };
                    _local_15.x = _local_14;
                    _local_15.y = (_local_15.y + _local_12);
                    _width = (_width + (_local_15.x + _SafeStr_4256.width));
                };
            };
            if (_local_13 != null)
            {
                if (!isNotify)
                {
                    _local_13.text = (_senderName + ": ");
                    _local_13.y = (_local_13.y + _topOffset);
                    _local_13.width = (_local_13.textWidth + 6);
                }
                else
                {
                    _local_13.text = "";
                    _local_13.width = 0;
                };
                _width = (_width + _local_13.width);
            };
            if (_SafeStr_4253 == 3)
            {
                _local_5.text = _SafeStr_819.registerParameter("widgets.chatbubble.respect", "username", _senderName);
                _width = 35;
            }
            else
            {
                if (_SafeStr_4253 == 4)
                {
                    _local_5.text = _SafeStr_819.registerParameter("widget.chatbubble.petrespect", "petname", _senderName);
                    _width = 35;
                }
                else
                {
                    if (_SafeStr_4253 == 6)
                    {
                        _local_5.text = _SafeStr_819.registerParameter("widget.chatbubble.pettreat", "petname", _senderName);
                        _width = 35;
                    }
                    else
                    {
                        if (_SafeStr_4253 == 7)
                        {
                            _local_5.text = message;
                            _width = 35;
                        }
                        else
                        {
                            if (_SafeStr_4253 == 8)
                            {
                                _local_5.text = message;
                                _width = 35;
                            }
                            else
                            {
                                if (_SafeStr_4253 == 9)
                                {
                                    _local_5.text = message;
                                    _width = 35;
                                }
                                else
                                {
                                    if (_SafeStr_4253 == 5)
                                    {
                                        _local_5.text = message;
                                        _width = 35;
                                    }
                                    else
                                    {
                                        if (_SafeStr_4254 == null)
                                        {
                                            _local_5.text = message;
                                        }
                                        else
                                        {
                                            _SafeStr_4255 = [];
                                            _local_7 = -1;
                                            _local_4 = 0;
                                            while (_local_4 < _SafeStr_4254.length)
                                            {
                                                _local_17 = _SafeStr_4254[_local_4][1];
                                                _local_18 = (("{" + _local_4) + "}");
                                                _local_2 = _message.indexOf(_local_18);
                                                _local_7 = (_local_2 + _local_17.length);
                                                _SafeStr_4255.push([_local_2, _local_7]);
                                                _message = _message.replace(_local_18, _local_17);
                                                _local_4++;
                                            };
                                            _local_5.text = message;
                                            _local_5.immediateClickMode = true;
                                            _local_5.setParamFlag(16, false);
                                            _local_5.setParamFlag(0x40000000, true);
                                            _local_20 = _local_5.getTextFormat();
                                            switch (_chatStyle)
                                            {
                                                case 2:
                                                    _local_20.color = 0xDDDDDD;
                                                    break;
                                                default:
                                                    _local_20.color = 2710438;
                                            };
                                            _local_20.underline = true;
                                            _local_4 = 0;
                                            while (_local_4 < _SafeStr_4255.length)
                                            {
                                                _local_10 = _SafeStr_4255[_local_4];
                                                try
                                                {
                                                    _local_5.setTextFormat(_local_20, _local_10[0], _local_10[1]);
                                                }
                                                catch(e:RangeError)
                                                {
                                                    Logger.log("Chat message links were malformed. Could not set TextFormat");
                                                };
                                                _local_4++;
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (_local_5.visible)
            {
                _local_5.x = (_width + _local_8);
                if (_local_13 != null)
                {
                    _local_5.x = (_local_13.x + _local_13.width);
                    if (_local_13.width > 6)
                    {
                        _local_5.x = (_local_5.x - (6 - 1));
                    };
                };
                _local_5.y = (_local_5.y + _topOffset);
                _local_16 = _local_5.textWidth;
                _local_5.width = (_local_16 + 6);
                _width = (_width + _local_5.width);
            };
            if (((!(_local_3 == null)) && (_local_3.visible)))
            {
                _local_3.bitmap = _local_19;
                _local_3.disposesBitmap = false;
                _local_3.x = (_width / 2);
                _local_3.y = (_local_3.y + _topOffset);
            };
            var _local_6:int = _local_5.width;
            if (_local_13)
            {
                _local_6 = (_local_6 + _local_13.width);
            };
            var _local_11:BitmapData = RoomChatWidget.chatBubbleFactory.buildBubbleImage(_chatStyle, _SafeStr_4253, _local_6, _local_9.height, _senderColor);
            _view.width = _local_11.width;
            _view.y = (_view.y - _topOffset);
            _view.y = (_view.y + _originalBackgroundYOffset);
            _width = _view.width;
            _local_9.bitmap = _local_11;
            _local_9.y = _topOffset;
        }

        public function enableDragTooltip():void
        {
            _SafeStr_4260 = true;
            refreshTooltip();
        }

        public function disableDragTooltip():void
        {
            _SafeStr_4260 = false;
            refreshTooltip();
        }

        private function refreshTooltip():void
        {
            if (_view == null)
            {
                return;
            };
            _view.toolTipCaption = "";
            if (_SafeStr_1324.isGameSession)
            {
                return;
            };
            if (_SafeStr_4260)
            {
                _view.toolTipCaption = "${chat.history.drag.tooltip}";
            };
            _view.toolTipDelay = 500;
        }

        private function addEventListeners(_arg_1:IWindowContainer):void
        {
            _arg_1.setParamFlag(1, true);
            _arg_1.addEventListener("WME_CLICK", onBubbleMouseClick);
            _arg_1.addEventListener("WME_DOWN", onBubbleMouseDown);
            _arg_1.addEventListener("WME_OVER", onBubbleMouseOver);
            _arg_1.addEventListener("WME_OUT", onBubbleMouseOut);
            _arg_1.addEventListener("WME_UP", onBubbleMouseUp);
        }

        private function testMessageLinkMouseClick(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:int;
            var _local_4:ITextWindow = (_view.getChildByName("message") as ITextWindow);
            var _local_5:int = _local_4.getCharIndexAtPoint((_arg_1 - _local_4.x), (_arg_2 - _local_4.y));
            if (_local_5 > -1)
            {
                _local_3 = 0;
                while (_local_3 < _SafeStr_4255.length)
                {
                    if (((_local_5 >= _SafeStr_4255[_local_3][0]) && (_local_5 <= _SafeStr_4255[_local_3][1])))
                    {
                        if (_SafeStr_4254[_local_3][2] == 0)
                        {
                            HabboWebTools.openExternalLinkWarning(_SafeStr_4254[_local_3][0]);
                        }
                        else
                        {
                            if (_SafeStr_4254[_local_3][2] == 1)
                            {
                                HabboWebTools.openWebPage((_SafeStr_4252 + _SafeStr_4254[_local_3][0]), "habboMain");
                            }
                            else
                            {
                                HabboWebTools.openWebPage((_SafeStr_4252 + _SafeStr_4254[_local_3][0]));
                            };
                        };
                        return (true);
                    };
                    _local_3++;
                };
            };
            return (false);
        }

        private function onBubbleMouseClick(_arg_1:WindowMouseEvent):void
        {
            if (((_SafeStr_4254) && (_SafeStr_4254.length > 0)))
            {
                if (testMessageLinkMouseClick(_arg_1.localX, _arg_1.localY))
                {
                    return;
                };
            };
            _SafeStr_1324.onItemMouseClick(_SafeStr_1721, _senderName, _SafeStr_4258, _SafeStr_1907, _arg_1);
        }

        private function onBubbleMouseDown(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.onItemMouseDown(_SafeStr_1721, _SafeStr_4258, _SafeStr_1907, _arg_1);
        }

        private function onBubbleMouseOver(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.onItemMouseOver(_SafeStr_1721, _SafeStr_4258, _SafeStr_1907, _arg_1);
        }

        private function onBubbleMouseOut(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.onItemMouseOut(_SafeStr_1721, _SafeStr_4258, _SafeStr_1907, _arg_1);
        }

        private function onBubbleMouseUp(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.mouseUp();
        }

        public function get chatStyle():int
        {
            return (_chatStyle);
        }

        public function get originalBackgroundYOffset():Number
        {
            return (_originalBackgroundYOffset);
        }


    }
}

