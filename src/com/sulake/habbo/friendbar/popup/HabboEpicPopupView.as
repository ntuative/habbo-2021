package com.sulake.habbo.friendbar.popup
{
    import com.sulake.habbo.friendbar.view.AbstractView;
    import com.sulake.habbo.friendbar.IHabboEpicPopupView;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.quest.EpicPopupMessageEvent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class HabboEpicPopupView extends AbstractView implements IHabboEpicPopupView 
    {

        private var _communicationManager:IHabboCommunicationManager;
        private var _activeFrame:IWindowContainer;

        public function HabboEpicPopupView(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            })]));
        }

        override public function dispose():void
        {
            if (_activeFrame != null)
            {
                _activeFrame.dispose();
                _activeFrame = null;
            };
            super.dispose();
        }

        override protected function initComponent():void
        {
            _communicationManager.addHabboConnectionMessageEvent(new EpicPopupMessageEvent(onEpicPopupMessageEvent));
        }

        private function onEpicPopupMessageEvent(_arg_1:EpicPopupMessageEvent):void
        {
            showPopup(_arg_1.getParser().imageUri);
        }

        public function showPopup(_arg_1:String):void
        {
            if (_activeFrame != null)
            {
                _activeFrame.dispose();
            };
            _activeFrame = (_windowManager.buildFromXML((assets.getAssetByName("epic_popup_frame_xml").content as XML)) as IWindowContainer);
            IStaticBitmapWrapperWindow(_activeFrame.findChildByName("content_static_bitmap")).assetUri = _arg_1;
            _activeFrame.procedure = windowProc;
            _activeFrame.center();
        }

        private function windowProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_activeFrame == null)) && (_arg_1.type == "WME_CLICK")))
            {
                switch (_arg_1.target.name)
                {
                    case "close_button":
                    case "header_button_close":
                        _activeFrame.dispose();
                        _activeFrame = null;
                        return;
                };
            };
        }


    }
}