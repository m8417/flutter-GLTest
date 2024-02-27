package com.example.myGLView.gltest;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Picture;
import android.graphics.Shader;
import android.graphics.LinearGradient;
import android.graphics.Shader.TileMode;
import android.graphics.Paint;
import android.graphics.RectF;
import android.opengl.GLSurfaceView;
import android.view.Surface;
import android.view.SurfaceView;
import android.view.SurfaceHolder;
import android.view.View;
import android.graphics.Rect;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.graphics.PixelFormat;
import io.flutter.plugin.platform.PlatformView;
import android.util.Log;
import java.util.Map;

import android.os.Looper;
import android.os.Handler;
import java.lang.Runnable;

class NativeView implements PlatformView {
    private final SurfaceView glSurfaceView;
    private static final String TAG = "NativeView";

    private final Context mContext;

    private Bitmap bitmap;
    private Rect mSrcRect = new Rect();
    private Rect mDstRect = new Rect();

    private void postEmpty(SurfaceHolder holder, int width, int height) {
        Surface surface = holder.getSurface();
        Canvas canvas = surface.lockHardwareCanvas();
        surface.unlockCanvasAndPost(canvas);
    }
    private void draw(SurfaceHolder holder, int width, int height) {
        Log.i(TAG, "drerrr");
        Shader shader = new LinearGradient(0, 0, width, height, Color.WHITE, Color.GREEN, TileMode.MIRROR);
        Paint paint = new Paint();
        paint.setShader(shader);
        Surface surface = holder.getSurface();
        Canvas canvas = surface.lockHardwareCanvas();
//        canvas.drawRect(new RectF(0, 0, width, height), paint);
        bitmap = BitmapFactory.decodeResource(mContext.getResources(), R.mipmap.bg);
        mSrcRect.set(0, 100, bitmap.getWidth(), bitmap.getHeight());
        mDstRect.set(10, 10, width - 20, height - 20);
        canvas.drawBitmap(bitmap, mSrcRect, mDstRect, new Paint());
        surface.unlockCanvasAndPost(canvas);
    }

    private void draw2(SurfaceHolder holder, int width, int height) {
        //postEmpty(holder, width, height);
        draw(holder,  width, height);
        //postEmpty(holder,  width, height);
        //glSurfaceView.invalidate();
    }

    private SurfaceHolder.Callback2 surfaceCallback = new SurfaceHolder.Callback2() {
        private int width;
        private int height;
        @Override
        public void surfaceCreated(SurfaceHolder holder) {
            holder.setFormat(PixelFormat.TRANSLUCENT);
            Log.i(TAG, "SurfaceCreated");
        }

        @Override
        public void surfaceRedrawNeeded(SurfaceHolder holder) {
            Rect r = holder.getSurfaceFrame();
            Log.i(TAG, "SurfaceRedrawNeeded r=" + r.toString());
            draw2(holder, width, height);
        }

        @Override
        public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
            if (this.width == width && this.height == height) {
                return;
            }
            this.width = width;
            this.height = height;
            Log.i(TAG, "SurfaceChanged w=" + width + " h=" + height);
            holder.setFixedSize(width, height);
        }

        @Override
        public void surfaceDestroyed(SurfaceHolder holder) {
            Log.i(TAG, "SurfaceDestroyed");
        }
    };

    NativeView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        mContext = context;
        glSurfaceView = new SurfaceView(context);
        glSurfaceView.getHolder().addCallback(surfaceCallback);
    }

    @NonNull
    @Override
    public View getView() {
        return glSurfaceView;
    }

    @Override
    public void dispose() {}
}