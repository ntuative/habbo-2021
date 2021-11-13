package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.CustomizeAvatarWithFurniMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class PurchasableClothingConfirmationView implements IDisposable 
    {

        private static const PRODUCT_PAGE_UKNOWN:int = -1;
        private static const PRODUCT_PAGE_CLOTHING:int = 0;
        private static const _SafeStr_3113:String = "header_button_close";
        private static const _SafeStr_3118:String = "save_button";
        private static const _SafeStr_3937:String = "cancel_text";
        private static const _SafeStr_3119:String = "ok_button";
        private static const _SafeStr_4078:String = "avatar_preview";

        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_1324:FurnitureContextMenuWidget;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_4077:int = -1;
        private var _SafeStr_537:IFurnitureData;
        private var _newFigureString:String;

        public function PurchasableClothingConfirmationView(_arg_1:FurnitureContextMenuWidget)
        {
            _SafeStr_1324 = _arg_1;
            _windowManager = _arg_1.windowManager;
            _assets = _SafeStr_1324.assets;
        }

        public function dispose():void
        {
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function open(_arg_1:int):void
        {
            var _local_7:Array;
            var _local_5:int = _SafeStr_1324.handler.roomSession.roomId;
            var _local_6:IRoomObject = _SafeStr_1324.handler.roomEngine.getRoomObject(_local_5, _arg_1, 10);
            if (_local_6 != null)
            {
                _SafeStr_537 = _SafeStr_1324.handler.getFurniData(_local_6);
                _SafeStr_4077 = _local_6.getId();
            }
            else
            {
                return;
            };
            var _local_3:int = -1;
            var _local_2:Vector.<int> = new Vector.<int>(0);
            switch (_SafeStr_537.category)
            {
                case 23:
                    _local_3 = 0;
                    _local_7 = _SafeStr_537.customParams.split(",");
                    for each (var _local_4:String in _local_7)
                    {
                        if (_SafeStr_1324.handler.container.avatarRenderManager.isValidFigureSetForGender(parseInt(_local_4), _SafeStr_1324.handler.container.sessionDataManager.gender))
                        {
                            _local_2.push(parseInt(_local_4));
                        };
                    };
                    break;
                default:
                    Logger.log(("[PurchasableClothingConfirmationView.open()] Unsupported furniture category: " + _SafeStr_537.category));
            };
            _newFigureString = _SafeStr_1324.handler.container.avatarRenderManager.getFigureStringWithFigureIds(_SafeStr_1324.handler.container.sessionDataManager.figure, _SafeStr_1324.handler.container.sessionDataManager.gender, _local_2);
            if (_SafeStr_1324.handler.container.inventory.hasBoundFigureSetFurniture(_SafeStr_537.className))
            {
                _SafeStr_1324.handler.container.connection.send(new UpdateFigureDataMessageComposer(_newFigureString, _SafeStr_1324.handler.container.sessionDataManager.gender));
            }
            else
            {
                setWindowContent(_local_3);
                _window.visible = true;
            };
        }

        private function setWindowContent(_arg_1:int):void
        {
            var _local_3:String;
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.title.bind_clothing", "name", _SafeStr_537.localizedName);
            if (!_window)
            {
                _local_3 = "use_product_widget_frame_plant_seed_xml";
                _window = (_windowManager.buildFromXML((_assets.getAssetByName(_local_3).content as XML)) as IWindowContainer);
                addClickListener("header_button_close");
                _window.center();
            };
            _window.caption = "${useproduct.widget.title.bind_clothing}";
            _SafeStr_1324.localizations.registerParameter("useproduct.widget.text.bind_clothing", "productName", _SafeStr_537.localizedName);
            var _local_2:IFrameWindow = (_window as IFrameWindow);
            _local_2.content.removeChildAt(0);
            var _local_4:IWindowContainer = createWindow(_arg_1);
            _local_2.content.addChild(_local_4);
            switch (_arg_1)
            {
                case 0:
                    addClickListener("save_button");
                    addClickListener("cancel_text");
                    break;
                default:
                    throw (new Error(("Invalid type for use product confirmation content apply: " + _arg_1)));
            };
            refreshAvatar();
            _window.invalidate();
        }

        private function createWindow(_arg_1:int):IWindowContainer
        {
            var _local_2:IAsset;
            var _local_3:IWindowContainer;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = _assets.getAssetByName("use_product_controller_purchasable_clothing_xml");
                    break;
                default:
                    throw (new Error(("Invalid type for view content creation: " + _arg_1)));
            };
            return (_windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
        }

        private function refreshAvatar():void
        {
            var _local_1:IWidgetWindow = IWidgetWindow(_window.findChildByName("avatar_preview"));
            var _local_2:IAvatarImageWidget = IAvatarImageWidget(_local_1.widget);
            _local_2.figure = _newFigureString;
        }

        public function close():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }

        private function addClickListener(_arg_1:String):void
        {
            _window.findChildByName(_arg_1).addEventListener("WME_CLICK", onMouseClick);
        }

        private function onMouseClick(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name)
            {
                case "header_button_close":
                case "cancel_text":
                case "ok_button":
                    close();
                    return;
                case "save_button":
                    _SafeStr_1324.handler.container.connection.send(new CustomizeAvatarWithFurniMessageComposer(_SafeStr_4077));
                    _SafeStr_1324.handler.container.connection.send(new UpdateFigureDataMessageComposer(_newFigureString, _SafeStr_1324.handler.container.sessionDataManager.gender));
                    close();
                    return;
            };
        }


    }
}

