package com.example.myGLView.gltest;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        flutterEngine
                .getPlatformViewsController()
                .getRegistry()
                .registerViewFactory("SurfaceView", new NativeViewFactory());
        flutterEngine
                .getPlatformViewsController()
                .getRegistry()
                .registerViewFactory("SurfaceViewB", new NativeViewFactoryB());
    }
}
