package com.example.myGLView.gltest;

import android.content.Context;
import android.graphics.Color;
import android.opengl.GLSurfaceView;
import android.view.SurfaceView;
import android.view.View;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;

class NativeView implements PlatformView {
    private final SurfaceView glSurfaceView;

    NativeView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        glSurfaceView = new SurfaceView(context);
        glSurfaceView.setBackground(context.getResources().getDrawable(R.mipmap.bg));
    }

    @NonNull
    @Override
    public View getView() {
        return glSurfaceView;
    }

    @Override
    public void dispose() {}
}