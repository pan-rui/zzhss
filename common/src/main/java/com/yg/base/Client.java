package com.yg.base;

import com.yg.core.Constants;
import com.yg.core.SerializeUtil;
import com.yg.service.ServiceType;

import java.io.ByteArrayOutputStream;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 * Created by panrui on 2015/9/13.
 */
public class Client {
    private static final ExecutorService executorService = Executors.newCachedThreadPool();

    public static Future<BaseResult> getService(ServiceType serviceType) {
        return executorService.submit(new GetServer(serviceType));
    }

   public static class GetServer implements Callable<BaseResult> {
        private ServiceType serviceType;

        public GetServer(ServiceType serviceType) {
            this.serviceType = serviceType;
        }

        @Override
        public BaseResult call() throws Exception {
            SocketChannel sc = SocketChannel.open();
            sc.configureBlocking(false);
            sc.connect(new InetSocketAddress(Constants.serverIp, Constants.serverPort));
            Selector selector = Selector.open();
            sc.register(selector, SelectionKey.OP_CONNECT);
            BaseResult obj = null;
            while (selector.select() > 0) {
                Iterator<SelectionKey> iter = selector.selectedKeys().iterator();
                while (iter.hasNext()) {
                    SelectionKey sk = iter.next();
                    iter.remove();
                    if (sk.isConnectable()) {
                        if (sc.isConnectionPending())
                            sc.finishConnect();
//                        sc.write(ByteBuffer.wrap(clazz.getSimpleName().getBytes("UTF-8")));
                        sc.write(ByteBuffer.wrap(SerializeUtil.serialize(serviceType)));
                        sc.register(selector, SelectionKey.OP_READ);
                    } else if (sk.isReadable()) {
                        ByteBuffer buffer = ByteBuffer.allocate(2048);
                        ByteArrayOutputStream byteArr = new ByteArrayOutputStream();
                        while (sc.read(buffer) > 0) {
                            buffer.flip();
                            byteArr.write(buffer.array(),buffer.position(),buffer.limit());
                            buffer.clear();
                        }
                        byte[] data=byteArr.toByteArray();
                        byteArr.flush();
                            obj = (BaseResult) SerializeUtil.unserialize(data);
                        sk.cancel();
                        sc.close();
                        selector.close();
                    return obj;
                    }
                }
//                    selector.close();
            }
            return obj;
        }
    }
}
