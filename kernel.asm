
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 10 d0 10 80       	mov    $0x8010d010,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 50 2e 10 80       	mov    $0x80102e50,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 d0 10 80       	mov    $0x8010d054,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 80 76 10 80       	push   $0x80107680
80100051:	68 20 d0 10 80       	push   $0x8010d020
80100056:	e8 95 47 00 00       	call   801047f0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 6c 17 11 80 1c 	movl   $0x8011171c,0x8011176c
80100062:	17 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 70 17 11 80 1c 	movl   $0x8011171c,0x80111770
8010006c:	17 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 1c 17 11 80       	mov    $0x8011171c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c 17 11 80 	movl   $0x8011171c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 76 10 80       	push   $0x80107687
80100097:	50                   	push   %eax
80100098:	e8 23 46 00 00       	call   801046c0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 17 11 80       	mov    0x80111770,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 70 17 11 80    	mov    %ebx,0x80111770

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 1c 17 11 80       	cmp    $0x8011171c,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 20 d0 10 80       	push   $0x8010d020
801000e4:	e8 67 48 00 00       	call   80104950 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 17 11 80    	mov    0x80111770,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c 17 11 80    	cmp    $0x8011171c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 17 11 80    	cmp    $0x8011171c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 17 11 80    	mov    0x8011176c,%ebx
80100126:	81 fb 1c 17 11 80    	cmp    $0x8011171c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 17 11 80    	cmp    $0x8011171c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 d0 10 80       	push   $0x8010d020
80100162:	e8 99 48 00 00       	call   80104a00 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 45 00 00       	call   80104700 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 5d 1f 00 00       	call   801020e0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 76 10 80       	push   $0x8010768e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 ed 45 00 00       	call   801047a0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 17 1f 00 00       	jmp    801020e0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 76 10 80       	push   $0x8010769f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 ac 45 00 00       	call   801047a0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 45 00 00       	call   80104760 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 20 d0 10 80 	movl   $0x8010d020,(%esp)
8010020b:	e8 40 47 00 00       	call   80104950 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 70 17 11 80       	mov    0x80111770,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 1c 17 11 80 	movl   $0x8011171c,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 70 17 11 80       	mov    0x80111770,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 70 17 11 80    	mov    %ebx,0x80111770
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 20 d0 10 80 	movl   $0x8010d020,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 9f 47 00 00       	jmp    80104a00 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 76 10 80       	push   $0x801076a6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 bb 14 00 00       	call   80101740 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 a0 b5 10 80 	movl   $0x8010b5a0,(%esp)
8010028c:	e8 bf 46 00 00       	call   80104950 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 00 1a 11 80       	mov    0x80111a00,%eax
801002a6:	3b 05 04 1a 11 80    	cmp    0x80111a04,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 a0 b5 10 80       	push   $0x8010b5a0
801002b8:	68 00 1a 11 80       	push   $0x80111a00
801002bd:	e8 5e 3d 00 00       	call   80104020 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 00 1a 11 80       	mov    0x80111a00,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 04 1a 11 80    	cmp    0x80111a04,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 09 35 00 00       	call   801037e0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 a0 b5 10 80       	push   $0x8010b5a0
801002e6:	e8 15 47 00 00       	call   80104a00 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 6d 13 00 00       	call   80101660 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 00 1a 11 80    	mov    %edx,0x80111a00
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 80 19 11 80 	movsbl -0x7feee680(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 a0 b5 10 80       	push   $0x8010b5a0
80100346:	e8 b5 46 00 00       	call   80104a00 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 0d 13 00 00       	call   80101660 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 00 1a 11 80       	mov    %eax,0x80111a00
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 d4 b5 10 80 00 	movl   $0x0,0x8010b5d4
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 52 23 00 00       	call   801026e0 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 ad 76 10 80       	push   $0x801076ad
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 ab 80 10 80 	movl   $0x801080ab,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 53 44 00 00       	call   80104810 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 c1 76 10 80       	push   $0x801076c1
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 d8 b5 10 80 01 	movl   $0x1,0x8010b5d8
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 d8 b5 10 80    	mov    0x8010b5d8,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 21 5e 00 00       	call   80106240 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 68 5d 00 00       	call   80106240 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 5c 5d 00 00       	call   80106240 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 50 5d 00 00       	call   80106240 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 e7 45 00 00       	call   80104b00 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 22 45 00 00       	call   80104a50 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 c5 76 10 80       	push   $0x801076c5
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 f0 76 10 80 	movzbl -0x7fef8910(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 2c 11 00 00       	call   80101740 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 a0 b5 10 80 	movl   $0x8010b5a0,(%esp)
8010061b:	e8 30 43 00 00       	call   80104950 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 a0 b5 10 80       	push   $0x8010b5a0
80100647:	e8 b4 43 00 00       	call   80104a00 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 0b 10 00 00       	call   80101660 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 d4 b5 10 80       	mov    0x8010b5d4,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 a0 b5 10 80       	push   $0x8010b5a0
8010070d:	e8 ee 42 00 00       	call   80104a00 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 d8 76 10 80       	mov    $0x801076d8,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 a0 b5 10 80       	push   $0x8010b5a0
801007c8:	e8 83 41 00 00       	call   80104950 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 df 76 10 80       	push   $0x801076df
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 a0 b5 10 80       	push   $0x8010b5a0
80100803:	e8 48 41 00 00       	call   80104950 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 08 1a 11 80       	mov    0x80111a08,%eax
80100836:	3b 05 04 1a 11 80    	cmp    0x80111a04,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 08 1a 11 80       	mov    %eax,0x80111a08
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 a0 b5 10 80       	push   $0x8010b5a0
80100868:	e8 93 41 00 00       	call   80104a00 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 08 1a 11 80       	mov    0x80111a08,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 00 1a 11 80    	sub    0x80111a00,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 08 1a 11 80    	mov    %edx,0x80111a08
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 80 19 11 80    	mov    %cl,-0x7feee680(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 00 1a 11 80       	mov    0x80111a00,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 08 1a 11 80    	cmp    %eax,0x80111a08
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 04 1a 11 80       	mov    %eax,0x80111a04
          wakeup(&input.r);
801008f1:	68 00 1a 11 80       	push   $0x80111a00
801008f6:	e8 45 3a 00 00       	call   80104340 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 08 1a 11 80       	mov    0x80111a08,%eax
8010090d:	39 05 04 1a 11 80    	cmp    %eax,0x80111a04
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 08 1a 11 80       	mov    %eax,0x80111a08
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 08 1a 11 80       	mov    0x80111a08,%eax
80100934:	3b 05 04 1a 11 80    	cmp    0x80111a04,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 80 19 11 80 0a 	cmpb   $0xa,-0x7feee680(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 b4 3a 00 00       	jmp    80104430 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 80 19 11 80 0a 	movb   $0xa,-0x7feee680(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 08 1a 11 80       	mov    0x80111a08,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 e8 76 10 80       	push   $0x801076e8
801009ab:	68 a0 b5 10 80       	push   $0x8010b5a0
801009b0:	e8 3b 3e 00 00       	call   801047f0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bb:	c7 05 cc 23 11 80 00 	movl   $0x80100600,0x801123cc
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 c8 23 11 80 70 	movl   $0x80100270,0x801123c8
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 d4 b5 10 80 01 	movl   $0x1,0x8010b5d4
801009d6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d9:	e8 b2 18 00 00       	call   80102290 <ioapicenable>
}
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 df 2d 00 00       	call   801037e0 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 34 21 00 00       	call   80102b40 <begin_op>

  if((ip = namei(path)) == 0){
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 99 14 00 00       	call   80101eb0 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 33 0c 00 00       	call   80101660 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 02 0f 00 00       	call   80101940 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 a1 0e 00 00       	call   801018f0 <iunlockput>
    end_op();
80100a4f:	e8 5c 21 00 00       	call   80102bb0 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a74:	e8 57 69 00 00       	call   801073d0 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a8a:	00 
80100a8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a98:	00 00 00 
80100a9b:	0f 84 c5 00 00 00    	je     80100b66 <exec+0x176>
80100aa1:	31 ff                	xor    %edi,%edi
80100aa3:	eb 18                	jmp    80100abd <exec+0xcd>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
80100aa8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aaf:	83 c7 01             	add    $0x1,%edi
80100ab2:	83 c6 20             	add    $0x20,%esi
80100ab5:	39 f8                	cmp    %edi,%eax
80100ab7:	0f 8e a9 00 00 00    	jle    80100b66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 73 0e 00 00       	call   80101940 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 17 67 00 00       	call   80107220 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 21 66 00 00       	call   80107160 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 f2 67 00 00       	call   80107350 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 81 0d 00 00       	call   801018f0 <iunlockput>
  end_op();
80100b6f:	e8 3c 20 00 00       	call   80102bb0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 86 66 00 00       	call   80107220 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 9f 67 00 00       	call   80107350 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bbe:	e8 ed 1f 00 00       	call   80102bb0 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 01 77 10 80       	push   $0x80107701
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 7a 68 00 00       	call   80107470 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c02:	8b 00                	mov    (%eax),%eax
80100c04:	85 c0                	test   %eax,%eax
80100c06:	74 79                	je     80100c81 <exec+0x291>
80100c08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c14:	eb 13                	jmp    80100c29 <exec+0x239>
80100c16:	8d 76 00             	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 5e 40 00 00       	call   80104c90 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 4b 40 00 00       	call   80104c90 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 8a 69 00 00       	call   801075e0 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
  ustack[1] = argc;
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	e8 20 69 00 00       	call   801075e0 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cde:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 4b 3f 00 00       	call   80104c50 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 9f 62 00 00       	call   80106fd0 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 17 66 00 00       	call   80107350 <freevm>
  return 0;
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	31 c0                	xor    %eax,%eax
80100d3e:	e9 19 fd ff ff       	jmp    80100a5c <exec+0x6c>
80100d43:	66 90                	xchg   %ax,%ax
80100d45:	66 90                	xchg   %ax,%ax
80100d47:	66 90                	xchg   %ax,%ax
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	68 0d 77 10 80       	push   $0x8010770d
80100d5b:	68 20 1a 11 80       	push   $0x80111a20
80100d60:	e8 8b 3a 00 00       	call   801047f0 <initlock>
}
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb 54 1a 11 80       	mov    $0x80111a54,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d7c:	68 20 1a 11 80       	push   $0x80111a20
80100d81:	e8 ca 3b 00 00       	call   80104950 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 10                	jmp    80100d9b <filealloc+0x2b>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb b4 23 11 80    	cmp    $0x801123b4,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100da5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dac:	68 20 1a 11 80       	push   $0x80111a20
80100db1:	e8 4a 3c 00 00       	call   80104a00 <release>
      return f;
80100db6:	89 d8                	mov    %ebx,%eax
80100db8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dbe:	c9                   	leave  
80100dbf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dc0:	83 ec 0c             	sub    $0xc,%esp
80100dc3:	68 20 1a 11 80       	push   $0x80111a20
80100dc8:	e8 33 3c 00 00       	call   80104a00 <release>
  return 0;
80100dcd:	83 c4 10             	add    $0x10,%esp
80100dd0:	31 c0                	xor    %eax,%eax
}
80100dd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dd5:	c9                   	leave  
80100dd6:	c3                   	ret    
80100dd7:	89 f6                	mov    %esi,%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	68 20 1a 11 80       	push   $0x80111a20
80100def:	e8 5c 3b 00 00       	call   80104950 <acquire>
  if(f->ref < 1)
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dfe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e01:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e07:	68 20 1a 11 80       	push   $0x80111a20
80100e0c:	e8 ef 3b 00 00       	call   80104a00 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 14 77 10 80       	push   $0x80107714
80100e20:	e8 4b f5 ff ff       	call   80100370 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 28             	sub    $0x28,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	68 20 1a 11 80       	push   $0x80111a20
80100e41:	e8 0a 3b 00 00       	call   80104950 <acquire>
  if(f->ref < 1)
80100e46:	8b 47 04             	mov    0x4(%edi),%eax
80100e49:	83 c4 10             	add    $0x10,%esp
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	0f 8e 9b 00 00 00    	jle    80100eef <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e54:	83 e8 01             	sub    $0x1,%eax
80100e57:	85 c0                	test   %eax,%eax
80100e59:	89 47 04             	mov    %eax,0x4(%edi)
80100e5c:	74 1a                	je     80100e78 <fileclose+0x48>
    release(&ftable.lock);
80100e5e:	c7 45 08 20 1a 11 80 	movl   $0x80111a20,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e68:	5b                   	pop    %ebx
80100e69:	5e                   	pop    %esi
80100e6a:	5f                   	pop    %edi
80100e6b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e6c:	e9 8f 3b 00 00       	jmp    80104a00 <release>
80100e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e78:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e7c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e7e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e81:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e84:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e8d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e90:	68 20 1a 11 80       	push   $0x80111a20
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e95:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e98:	e8 63 3b 00 00       	call   80104a00 <release>

  if(ff.type == FD_PIPE)
80100e9d:	83 c4 10             	add    $0x10,%esp
80100ea0:	83 fb 01             	cmp    $0x1,%ebx
80100ea3:	74 13                	je     80100eb8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ea5:	83 fb 02             	cmp    $0x2,%ebx
80100ea8:	74 26                	je     80100ed0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ead:	5b                   	pop    %ebx
80100eae:	5e                   	pop    %esi
80100eaf:	5f                   	pop    %edi
80100eb0:	5d                   	pop    %ebp
80100eb1:	c3                   	ret    
80100eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100eb8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ebc:	83 ec 08             	sub    $0x8,%esp
80100ebf:	53                   	push   %ebx
80100ec0:	56                   	push   %esi
80100ec1:	e8 1a 24 00 00       	call   801032e0 <pipeclose>
80100ec6:	83 c4 10             	add    $0x10,%esp
80100ec9:	eb df                	jmp    80100eaa <fileclose+0x7a>
80100ecb:	90                   	nop
80100ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ed0:	e8 6b 1c 00 00       	call   80102b40 <begin_op>
    iput(ff.ip);
80100ed5:	83 ec 0c             	sub    $0xc,%esp
80100ed8:	ff 75 e0             	pushl  -0x20(%ebp)
80100edb:	e8 b0 08 00 00       	call   80101790 <iput>
    end_op();
80100ee0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ee3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee6:	5b                   	pop    %ebx
80100ee7:	5e                   	pop    %esi
80100ee8:	5f                   	pop    %edi
80100ee9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eea:	e9 c1 1c 00 00       	jmp    80102bb0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	68 1c 77 10 80       	push   $0x8010771c
80100ef7:	e8 74 f4 ff ff       	call   80100370 <panic>
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f00 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	53                   	push   %ebx
80100f04:	83 ec 04             	sub    $0x4,%esp
80100f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f0d:	75 31                	jne    80100f40 <filestat+0x40>
    ilock(f->ip);
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	ff 73 10             	pushl  0x10(%ebx)
80100f15:	e8 46 07 00 00       	call   80101660 <ilock>
    stati(f->ip, st);
80100f1a:	58                   	pop    %eax
80100f1b:	5a                   	pop    %edx
80100f1c:	ff 75 0c             	pushl  0xc(%ebp)
80100f1f:	ff 73 10             	pushl  0x10(%ebx)
80100f22:	e8 e9 09 00 00       	call   80101910 <stati>
    iunlock(f->ip);
80100f27:	59                   	pop    %ecx
80100f28:	ff 73 10             	pushl  0x10(%ebx)
80100f2b:	e8 10 08 00 00       	call   80101740 <iunlock>
    return 0;
80100f30:	83 c4 10             	add    $0x10,%esp
80100f33:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	57                   	push   %edi
80100f54:	56                   	push   %esi
80100f55:	53                   	push   %ebx
80100f56:	83 ec 0c             	sub    $0xc,%esp
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f62:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f66:	74 60                	je     80100fc8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f68:	8b 03                	mov    (%ebx),%eax
80100f6a:	83 f8 01             	cmp    $0x1,%eax
80100f6d:	74 41                	je     80100fb0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f6f:	83 f8 02             	cmp    $0x2,%eax
80100f72:	75 5b                	jne    80100fcf <fileread+0x7f>
    ilock(f->ip);
80100f74:	83 ec 0c             	sub    $0xc,%esp
80100f77:	ff 73 10             	pushl  0x10(%ebx)
80100f7a:	e8 e1 06 00 00       	call   80101660 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f7f:	57                   	push   %edi
80100f80:	ff 73 14             	pushl  0x14(%ebx)
80100f83:	56                   	push   %esi
80100f84:	ff 73 10             	pushl  0x10(%ebx)
80100f87:	e8 b4 09 00 00       	call   80101940 <readi>
80100f8c:	83 c4 20             	add    $0x20,%esp
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	89 c6                	mov    %eax,%esi
80100f93:	7e 03                	jle    80100f98 <fileread+0x48>
      f->off += r;
80100f95:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f98:	83 ec 0c             	sub    $0xc,%esp
80100f9b:	ff 73 10             	pushl  0x10(%ebx)
80100f9e:	e8 9d 07 00 00       	call   80101740 <iunlock>
    return r;
80100fa3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fa6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fab:	5b                   	pop    %ebx
80100fac:	5e                   	pop    %esi
80100fad:	5f                   	pop    %edi
80100fae:	5d                   	pop    %ebp
80100faf:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fb0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fb3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	5b                   	pop    %ebx
80100fba:	5e                   	pop    %esi
80100fbb:	5f                   	pop    %edi
80100fbc:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fbd:	e9 be 24 00 00       	jmp    80103480 <piperead>
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fcd:	eb d9                	jmp    80100fa8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	68 26 77 10 80       	push   $0x80107726
80100fd7:	e8 94 f3 ff ff       	call   80100370 <panic>
80100fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 1c             	sub    $0x1c,%esp
80100fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fec:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fef:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100ffc:	0f 84 aa 00 00 00    	je     801010ac <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 06                	mov    (%esi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d8 00 00 00    	jne    801010ee <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 ff                	xor    %edi,%edi
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 34                	jg     80101053 <filewrite+0x73>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101028:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010102b:	83 ec 0c             	sub    $0xc,%esp
8010102e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101031:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101034:	e8 07 07 00 00       	call   80101740 <iunlock>
      end_op();
80101039:	e8 72 1b 00 00       	call   80102bb0 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101044:	39 d8                	cmp    %ebx,%eax
80101046:	0f 85 95 00 00 00    	jne    801010e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010104c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010104e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101051:	7e 6d                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101053:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101056:	b8 00 06 00 00       	mov    $0x600,%eax
8010105b:	29 fb                	sub    %edi,%ebx
8010105d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101063:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101066:	e8 d5 1a 00 00       	call   80102b40 <begin_op>
      ilock(f->ip);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	ff 76 10             	pushl  0x10(%esi)
80101071:	e8 ea 05 00 00       	call   80101660 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101076:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101079:	53                   	push   %ebx
8010107a:	ff 76 14             	pushl  0x14(%esi)
8010107d:	01 f8                	add    %edi,%eax
8010107f:	50                   	push   %eax
80101080:	ff 76 10             	pushl  0x10(%esi)
80101083:	e8 b8 09 00 00       	call   80101a40 <writei>
80101088:	83 c4 20             	add    $0x20,%esp
8010108b:	85 c0                	test   %eax,%eax
8010108d:	7f 99                	jg     80101028 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 76 10             	pushl  0x10(%esi)
80101095:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101098:	e8 a3 06 00 00       	call   80101740 <iunlock>
      end_op();
8010109d:	e8 0e 1b 00 00       	call   80102bb0 <end_op>

      if(r < 0)
801010a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a5:	83 c4 10             	add    $0x10,%esp
801010a8:	85 c0                	test   %eax,%eax
801010aa:	74 98                	je     80101044 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010b4:	5b                   	pop    %ebx
801010b5:	5e                   	pop    %esi
801010b6:	5f                   	pop    %edi
801010b7:	5d                   	pop    %ebp
801010b8:	c3                   	ret    
801010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010c0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010c3:	75 e7                	jne    801010ac <filewrite+0xcc>
  }
  panic("filewrite");
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	89 f8                	mov    %edi,%eax
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010cf:	8b 46 0c             	mov    0xc(%esi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010dc:	e9 9f 22 00 00       	jmp    80103380 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010e1:	83 ec 0c             	sub    $0xc,%esp
801010e4:	68 2f 77 10 80       	push   $0x8010772f
801010e9:	e8 82 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ee:	83 ec 0c             	sub    $0xc,%esp
801010f1:	68 35 77 10 80       	push   $0x80107735
801010f6:	e8 75 f2 ff ff       	call   80100370 <panic>
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	56                   	push   %esi
80101104:	53                   	push   %ebx
80101105:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101107:	c1 ea 0c             	shr    $0xc,%edx
8010110a:	03 15 38 24 11 80    	add    0x80112438,%edx
80101110:	83 ec 08             	sub    $0x8,%esp
80101113:	52                   	push   %edx
80101114:	50                   	push   %eax
80101115:	e8 b6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010111a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010111c:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101122:	ba 01 00 00 00       	mov    $0x1,%edx
80101127:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112a:	c1 fb 03             	sar    $0x3,%ebx
8010112d:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101130:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101132:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101137:	85 d1                	test   %edx,%ecx
80101139:	74 27                	je     80101162 <bfree+0x62>
8010113b:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010113d:	f7 d2                	not    %edx
8010113f:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101141:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101144:	21 d0                	and    %edx,%eax
80101146:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010114a:	56                   	push   %esi
8010114b:	e8 d0 1b 00 00       	call   80102d20 <log_write>
  brelse(bp);
80101150:	89 34 24             	mov    %esi,(%esp)
80101153:	e8 88 f0 ff ff       	call   801001e0 <brelse>
}
80101158:	83 c4 10             	add    $0x10,%esp
8010115b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010115e:	5b                   	pop    %ebx
8010115f:	5e                   	pop    %esi
80101160:	5d                   	pop    %ebp
80101161:	c3                   	ret    

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101162:	83 ec 0c             	sub    $0xc,%esp
80101165:	68 3f 77 10 80       	push   $0x8010773f
8010116a:	e8 01 f2 ff ff       	call   80100370 <panic>
8010116f:	90                   	nop

80101170 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	57                   	push   %edi
80101174:	56                   	push   %esi
80101175:	53                   	push   %ebx
80101176:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101179:	8b 0d 20 24 11 80    	mov    0x80112420,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010117f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101182:	85 c9                	test   %ecx,%ecx
80101184:	0f 84 85 00 00 00    	je     8010120f <balloc+0x9f>
8010118a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101191:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101194:	83 ec 08             	sub    $0x8,%esp
80101197:	89 f0                	mov    %esi,%eax
80101199:	c1 f8 0c             	sar    $0xc,%eax
8010119c:	03 05 38 24 11 80    	add    0x80112438,%eax
801011a2:	50                   	push   %eax
801011a3:	ff 75 d8             	pushl  -0x28(%ebp)
801011a6:	e8 25 ef ff ff       	call   801000d0 <bread>
801011ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801011ae:	a1 20 24 11 80       	mov    0x80112420,%eax
801011b3:	83 c4 10             	add    $0x10,%esp
801011b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011b9:	31 c0                	xor    %eax,%eax
801011bb:	eb 2d                	jmp    801011ea <balloc+0x7a>
801011bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011c0:	89 c1                	mov    %eax,%ecx
801011c2:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011c7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801011ca:	83 e1 07             	and    $0x7,%ecx
801011cd:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011cf:	89 c1                	mov    %eax,%ecx
801011d1:	c1 f9 03             	sar    $0x3,%ecx
801011d4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801011d9:	85 d7                	test   %edx,%edi
801011db:	74 43                	je     80101220 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011dd:	83 c0 01             	add    $0x1,%eax
801011e0:	83 c6 01             	add    $0x1,%esi
801011e3:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011e8:	74 05                	je     801011ef <balloc+0x7f>
801011ea:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801011ed:	72 d1                	jb     801011c0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	ff 75 e4             	pushl  -0x1c(%ebp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011fa:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101201:	83 c4 10             	add    $0x10,%esp
80101204:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101207:	39 05 20 24 11 80    	cmp    %eax,0x80112420
8010120d:	77 82                	ja     80101191 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010120f:	83 ec 0c             	sub    $0xc,%esp
80101212:	68 52 77 10 80       	push   $0x80107752
80101217:	e8 54 f1 ff ff       	call   80100370 <panic>
8010121c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101220:	09 fa                	or     %edi,%edx
80101222:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101225:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101228:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010122c:	57                   	push   %edi
8010122d:	e8 ee 1a 00 00       	call   80102d20 <log_write>
        brelse(bp);
80101232:	89 3c 24             	mov    %edi,(%esp)
80101235:	e8 a6 ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010123a:	58                   	pop    %eax
8010123b:	5a                   	pop    %edx
8010123c:	56                   	push   %esi
8010123d:	ff 75 d8             	pushl  -0x28(%ebp)
80101240:	e8 8b ee ff ff       	call   801000d0 <bread>
80101245:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101247:	8d 40 5c             	lea    0x5c(%eax),%eax
8010124a:	83 c4 0c             	add    $0xc,%esp
8010124d:	68 00 02 00 00       	push   $0x200
80101252:	6a 00                	push   $0x0
80101254:	50                   	push   %eax
80101255:	e8 f6 37 00 00       	call   80104a50 <memset>
  log_write(bp);
8010125a:	89 1c 24             	mov    %ebx,(%esp)
8010125d:	e8 be 1a 00 00       	call   80102d20 <log_write>
  brelse(bp);
80101262:	89 1c 24             	mov    %ebx,(%esp)
80101265:	e8 76 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010126a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010126d:	89 f0                	mov    %esi,%eax
8010126f:	5b                   	pop    %ebx
80101270:	5e                   	pop    %esi
80101271:	5f                   	pop    %edi
80101272:	5d                   	pop    %ebp
80101273:	c3                   	ret    
80101274:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010127a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101280 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101288:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010128a:	bb 74 24 11 80       	mov    $0x80112474,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010128f:	83 ec 28             	sub    $0x28,%esp
80101292:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101295:	68 40 24 11 80       	push   $0x80112440
8010129a:	e8 b1 36 00 00       	call   80104950 <acquire>
8010129f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012a5:	eb 1b                	jmp    801012c2 <iget+0x42>
801012a7:	89 f6                	mov    %esi,%esi
801012a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012b0:	85 f6                	test   %esi,%esi
801012b2:	74 44                	je     801012f8 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012ba:	81 fb 94 40 11 80    	cmp    $0x80114094,%ebx
801012c0:	74 4e                	je     80101310 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012c2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012c5:	85 c9                	test   %ecx,%ecx
801012c7:	7e e7                	jle    801012b0 <iget+0x30>
801012c9:	39 3b                	cmp    %edi,(%ebx)
801012cb:	75 e3                	jne    801012b0 <iget+0x30>
801012cd:	39 53 04             	cmp    %edx,0x4(%ebx)
801012d0:	75 de                	jne    801012b0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
801012d2:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012d5:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
801012d8:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
801012da:	68 40 24 11 80       	push   $0x80112440

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012df:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012e2:	e8 19 37 00 00       	call   80104a00 <release>
      return ip;
801012e7:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801012ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ed:	89 f0                	mov    %esi,%eax
801012ef:	5b                   	pop    %ebx
801012f0:	5e                   	pop    %esi
801012f1:	5f                   	pop    %edi
801012f2:	5d                   	pop    %ebp
801012f3:	c3                   	ret    
801012f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012f8:	85 c9                	test   %ecx,%ecx
801012fa:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012fd:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101303:	81 fb 94 40 11 80    	cmp    $0x80114094,%ebx
80101309:	75 b7                	jne    801012c2 <iget+0x42>
8010130b:	90                   	nop
8010130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101310:	85 f6                	test   %esi,%esi
80101312:	74 2d                	je     80101341 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101314:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101317:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101319:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010131c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101323:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010132a:	68 40 24 11 80       	push   $0x80112440
8010132f:	e8 cc 36 00 00       	call   80104a00 <release>

  return ip;
80101334:	83 c4 10             	add    $0x10,%esp
}
80101337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133a:	89 f0                	mov    %esi,%eax
8010133c:	5b                   	pop    %ebx
8010133d:	5e                   	pop    %esi
8010133e:	5f                   	pop    %edi
8010133f:	5d                   	pop    %ebp
80101340:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101341:	83 ec 0c             	sub    $0xc,%esp
80101344:	68 68 77 10 80       	push   $0x80107768
80101349:	e8 22 f0 ff ff       	call   80100370 <panic>
8010134e:	66 90                	xchg   %ax,%ax

80101350 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	89 c6                	mov    %eax,%esi
80101358:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010135b:	83 fa 0b             	cmp    $0xb,%edx
8010135e:	77 18                	ja     80101378 <bmap+0x28>
80101360:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101363:	8b 43 5c             	mov    0x5c(%ebx),%eax
80101366:	85 c0                	test   %eax,%eax
80101368:	74 76                	je     801013e0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136d:	5b                   	pop    %ebx
8010136e:	5e                   	pop    %esi
8010136f:	5f                   	pop    %edi
80101370:	5d                   	pop    %ebp
80101371:	c3                   	ret    
80101372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101378:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010137b:	83 fb 7f             	cmp    $0x7f,%ebx
8010137e:	0f 87 83 00 00 00    	ja     80101407 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101384:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010138a:	85 c0                	test   %eax,%eax
8010138c:	74 6a                	je     801013f8 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010138e:	83 ec 08             	sub    $0x8,%esp
80101391:	50                   	push   %eax
80101392:	ff 36                	pushl  (%esi)
80101394:	e8 37 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101399:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010139d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801013a0:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801013a2:	8b 1a                	mov    (%edx),%ebx
801013a4:	85 db                	test   %ebx,%ebx
801013a6:	75 1d                	jne    801013c5 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
801013a8:	8b 06                	mov    (%esi),%eax
801013aa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013ad:	e8 be fd ff ff       	call   80101170 <balloc>
801013b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013b5:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
801013b8:	89 c3                	mov    %eax,%ebx
801013ba:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013bc:	57                   	push   %edi
801013bd:	e8 5e 19 00 00       	call   80102d20 <log_write>
801013c2:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
801013c5:	83 ec 0c             	sub    $0xc,%esp
801013c8:	57                   	push   %edi
801013c9:	e8 12 ee ff ff       	call   801001e0 <brelse>
801013ce:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801013d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013d4:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801013d6:	5b                   	pop    %ebx
801013d7:	5e                   	pop    %esi
801013d8:	5f                   	pop    %edi
801013d9:	5d                   	pop    %ebp
801013da:	c3                   	ret    
801013db:	90                   	nop
801013dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801013e0:	8b 06                	mov    (%esi),%eax
801013e2:	e8 89 fd ff ff       	call   80101170 <balloc>
801013e7:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ed:	5b                   	pop    %ebx
801013ee:	5e                   	pop    %esi
801013ef:	5f                   	pop    %edi
801013f0:	5d                   	pop    %ebp
801013f1:	c3                   	ret    
801013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013f8:	8b 06                	mov    (%esi),%eax
801013fa:	e8 71 fd ff ff       	call   80101170 <balloc>
801013ff:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101405:	eb 87                	jmp    8010138e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101407:	83 ec 0c             	sub    $0xc,%esp
8010140a:	68 78 77 10 80       	push   $0x80107778
8010140f:	e8 5c ef ff ff       	call   80100370 <panic>
80101414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010141a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101420 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101428:	83 ec 08             	sub    $0x8,%esp
8010142b:	6a 01                	push   $0x1
8010142d:	ff 75 08             	pushl  0x8(%ebp)
80101430:	e8 9b ec ff ff       	call   801000d0 <bread>
80101435:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101437:	8d 40 5c             	lea    0x5c(%eax),%eax
8010143a:	83 c4 0c             	add    $0xc,%esp
8010143d:	6a 1c                	push   $0x1c
8010143f:	50                   	push   %eax
80101440:	56                   	push   %esi
80101441:	e8 ba 36 00 00       	call   80104b00 <memmove>
  brelse(bp);
80101446:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101449:	83 c4 10             	add    $0x10,%esp
}
8010144c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010144f:	5b                   	pop    %ebx
80101450:	5e                   	pop    %esi
80101451:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101452:	e9 89 ed ff ff       	jmp    801001e0 <brelse>
80101457:	89 f6                	mov    %esi,%esi
80101459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101460 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	53                   	push   %ebx
80101464:	bb 80 24 11 80       	mov    $0x80112480,%ebx
80101469:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010146c:	68 8b 77 10 80       	push   $0x8010778b
80101471:	68 40 24 11 80       	push   $0x80112440
80101476:	e8 75 33 00 00       	call   801047f0 <initlock>
8010147b:	83 c4 10             	add    $0x10,%esp
8010147e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101480:	83 ec 08             	sub    $0x8,%esp
80101483:	68 92 77 10 80       	push   $0x80107792
80101488:	53                   	push   %ebx
80101489:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010148f:	e8 2c 32 00 00       	call   801046c0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101494:	83 c4 10             	add    $0x10,%esp
80101497:	81 fb a0 40 11 80    	cmp    $0x801140a0,%ebx
8010149d:	75 e1                	jne    80101480 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010149f:	83 ec 08             	sub    $0x8,%esp
801014a2:	68 20 24 11 80       	push   $0x80112420
801014a7:	ff 75 08             	pushl  0x8(%ebp)
801014aa:	e8 71 ff ff ff       	call   80101420 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014af:	ff 35 38 24 11 80    	pushl  0x80112438
801014b5:	ff 35 34 24 11 80    	pushl  0x80112434
801014bb:	ff 35 30 24 11 80    	pushl  0x80112430
801014c1:	ff 35 2c 24 11 80    	pushl  0x8011242c
801014c7:	ff 35 28 24 11 80    	pushl  0x80112428
801014cd:	ff 35 24 24 11 80    	pushl  0x80112424
801014d3:	ff 35 20 24 11 80    	pushl  0x80112420
801014d9:	68 f8 77 10 80       	push   $0x801077f8
801014de:	e8 7d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014e3:	83 c4 30             	add    $0x30,%esp
801014e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014e9:	c9                   	leave  
801014ea:	c3                   	ret    
801014eb:	90                   	nop
801014ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014f0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	53                   	push   %ebx
801014f6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014f9:	83 3d 28 24 11 80 01 	cmpl   $0x1,0x80112428
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101500:	8b 45 0c             	mov    0xc(%ebp),%eax
80101503:	8b 75 08             	mov    0x8(%ebp),%esi
80101506:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	0f 86 91 00 00 00    	jbe    801015a0 <ialloc+0xb0>
8010150f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101514:	eb 21                	jmp    80101537 <ialloc+0x47>
80101516:	8d 76 00             	lea    0x0(%esi),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101520:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101523:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101526:	57                   	push   %edi
80101527:	e8 b4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 c4 10             	add    $0x10,%esp
8010152f:	39 1d 28 24 11 80    	cmp    %ebx,0x80112428
80101535:	76 69                	jbe    801015a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101537:	89 d8                	mov    %ebx,%eax
80101539:	83 ec 08             	sub    $0x8,%esp
8010153c:	c1 e8 03             	shr    $0x3,%eax
8010153f:	03 05 34 24 11 80    	add    0x80112434,%eax
80101545:	50                   	push   %eax
80101546:	56                   	push   %esi
80101547:	e8 84 eb ff ff       	call   801000d0 <bread>
8010154c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010154e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101550:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101553:	83 e0 07             	and    $0x7,%eax
80101556:	c1 e0 06             	shl    $0x6,%eax
80101559:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010155d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101561:	75 bd                	jne    80101520 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101563:	83 ec 04             	sub    $0x4,%esp
80101566:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101569:	6a 40                	push   $0x40
8010156b:	6a 00                	push   $0x0
8010156d:	51                   	push   %ecx
8010156e:	e8 dd 34 00 00       	call   80104a50 <memset>
      dip->type = type;
80101573:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101577:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010157a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010157d:	89 3c 24             	mov    %edi,(%esp)
80101580:	e8 9b 17 00 00       	call   80102d20 <log_write>
      brelse(bp);
80101585:	89 3c 24             	mov    %edi,(%esp)
80101588:	e8 53 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010158d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101590:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101593:	89 da                	mov    %ebx,%edx
80101595:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101597:	5b                   	pop    %ebx
80101598:	5e                   	pop    %esi
80101599:	5f                   	pop    %edi
8010159a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010159b:	e9 e0 fc ff ff       	jmp    80101280 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015a0:	83 ec 0c             	sub    $0xc,%esp
801015a3:	68 98 77 10 80       	push   $0x80107798
801015a8:	e8 c3 ed ff ff       	call   80100370 <panic>
801015ad:	8d 76 00             	lea    0x0(%esi),%esi

801015b0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	56                   	push   %esi
801015b4:	53                   	push   %ebx
801015b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015b8:	83 ec 08             	sub    $0x8,%esp
801015bb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015be:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c1:	c1 e8 03             	shr    $0x3,%eax
801015c4:	03 05 34 24 11 80    	add    0x80112434,%eax
801015ca:	50                   	push   %eax
801015cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ce:	e8 fd ea ff ff       	call   801000d0 <bread>
801015d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015dc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015df:	83 e0 07             	and    $0x7,%eax
801015e2:	c1 e0 06             	shl    $0x6,%eax
801015e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015f0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801015f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801015f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801015fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801015ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101603:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101607:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010160a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160d:	6a 34                	push   $0x34
8010160f:	53                   	push   %ebx
80101610:	50                   	push   %eax
80101611:	e8 ea 34 00 00       	call   80104b00 <memmove>
  log_write(bp);
80101616:	89 34 24             	mov    %esi,(%esp)
80101619:	e8 02 17 00 00       	call   80102d20 <log_write>
  brelse(bp);
8010161e:	89 75 08             	mov    %esi,0x8(%ebp)
80101621:	83 c4 10             	add    $0x10,%esp
}
80101624:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101627:	5b                   	pop    %ebx
80101628:	5e                   	pop    %esi
80101629:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010162a:	e9 b1 eb ff ff       	jmp    801001e0 <brelse>
8010162f:	90                   	nop

80101630 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	83 ec 10             	sub    $0x10,%esp
80101637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010163a:	68 40 24 11 80       	push   $0x80112440
8010163f:	e8 0c 33 00 00       	call   80104950 <acquire>
  ip->ref++;
80101644:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101648:	c7 04 24 40 24 11 80 	movl   $0x80112440,(%esp)
8010164f:	e8 ac 33 00 00       	call   80104a00 <release>
  return ip;
}
80101654:	89 d8                	mov    %ebx,%eax
80101656:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101659:	c9                   	leave  
8010165a:	c3                   	ret    
8010165b:	90                   	nop
8010165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101660 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	56                   	push   %esi
80101664:	53                   	push   %ebx
80101665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101668:	85 db                	test   %ebx,%ebx
8010166a:	0f 84 b7 00 00 00    	je     80101727 <ilock+0xc7>
80101670:	8b 53 08             	mov    0x8(%ebx),%edx
80101673:	85 d2                	test   %edx,%edx
80101675:	0f 8e ac 00 00 00    	jle    80101727 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010167b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010167e:	83 ec 0c             	sub    $0xc,%esp
80101681:	50                   	push   %eax
80101682:	e8 79 30 00 00       	call   80104700 <acquiresleep>

  if(ip->valid == 0){
80101687:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010168a:	83 c4 10             	add    $0x10,%esp
8010168d:	85 c0                	test   %eax,%eax
8010168f:	74 0f                	je     801016a0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101691:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101694:	5b                   	pop    %ebx
80101695:	5e                   	pop    %esi
80101696:	5d                   	pop    %ebp
80101697:	c3                   	ret    
80101698:	90                   	nop
80101699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a0:	8b 43 04             	mov    0x4(%ebx),%eax
801016a3:	83 ec 08             	sub    $0x8,%esp
801016a6:	c1 e8 03             	shr    $0x3,%eax
801016a9:	03 05 34 24 11 80    	add    0x80112434,%eax
801016af:	50                   	push   %eax
801016b0:	ff 33                	pushl  (%ebx)
801016b2:	e8 19 ea ff ff       	call   801000d0 <bread>
801016b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016b9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016bc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016bf:	83 e0 07             	and    $0x7,%eax
801016c2:	c1 e0 06             	shl    $0x6,%eax
801016c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016c9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016f1:	6a 34                	push   $0x34
801016f3:	50                   	push   %eax
801016f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801016f7:	50                   	push   %eax
801016f8:	e8 03 34 00 00       	call   80104b00 <memmove>
    brelse(bp);
801016fd:	89 34 24             	mov    %esi,(%esp)
80101700:	e8 db ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101705:	83 c4 10             	add    $0x10,%esp
80101708:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
8010170d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101714:	0f 85 77 ff ff ff    	jne    80101691 <ilock+0x31>
      panic("ilock: no type");
8010171a:	83 ec 0c             	sub    $0xc,%esp
8010171d:	68 b0 77 10 80       	push   $0x801077b0
80101722:	e8 49 ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101727:	83 ec 0c             	sub    $0xc,%esp
8010172a:	68 aa 77 10 80       	push   $0x801077aa
8010172f:	e8 3c ec ff ff       	call   80100370 <panic>
80101734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010173a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101740 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101748:	85 db                	test   %ebx,%ebx
8010174a:	74 28                	je     80101774 <iunlock+0x34>
8010174c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010174f:	83 ec 0c             	sub    $0xc,%esp
80101752:	56                   	push   %esi
80101753:	e8 48 30 00 00       	call   801047a0 <holdingsleep>
80101758:	83 c4 10             	add    $0x10,%esp
8010175b:	85 c0                	test   %eax,%eax
8010175d:	74 15                	je     80101774 <iunlock+0x34>
8010175f:	8b 43 08             	mov    0x8(%ebx),%eax
80101762:	85 c0                	test   %eax,%eax
80101764:	7e 0e                	jle    80101774 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101766:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101769:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010176c:	5b                   	pop    %ebx
8010176d:	5e                   	pop    %esi
8010176e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010176f:	e9 ec 2f 00 00       	jmp    80104760 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101774:	83 ec 0c             	sub    $0xc,%esp
80101777:	68 bf 77 10 80       	push   $0x801077bf
8010177c:	e8 ef eb ff ff       	call   80100370 <panic>
80101781:	eb 0d                	jmp    80101790 <iput>
80101783:	90                   	nop
80101784:	90                   	nop
80101785:	90                   	nop
80101786:	90                   	nop
80101787:	90                   	nop
80101788:	90                   	nop
80101789:	90                   	nop
8010178a:	90                   	nop
8010178b:	90                   	nop
8010178c:	90                   	nop
8010178d:	90                   	nop
8010178e:	90                   	nop
8010178f:	90                   	nop

80101790 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 28             	sub    $0x28,%esp
80101799:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010179c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010179f:	57                   	push   %edi
801017a0:	e8 5b 2f 00 00       	call   80104700 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017a5:	8b 56 4c             	mov    0x4c(%esi),%edx
801017a8:	83 c4 10             	add    $0x10,%esp
801017ab:	85 d2                	test   %edx,%edx
801017ad:	74 07                	je     801017b6 <iput+0x26>
801017af:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017b4:	74 32                	je     801017e8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801017b6:	83 ec 0c             	sub    $0xc,%esp
801017b9:	57                   	push   %edi
801017ba:	e8 a1 2f 00 00       	call   80104760 <releasesleep>

  acquire(&icache.lock);
801017bf:	c7 04 24 40 24 11 80 	movl   $0x80112440,(%esp)
801017c6:	e8 85 31 00 00       	call   80104950 <acquire>
  ip->ref--;
801017cb:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801017cf:	83 c4 10             	add    $0x10,%esp
801017d2:	c7 45 08 40 24 11 80 	movl   $0x80112440,0x8(%ebp)
}
801017d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017dc:	5b                   	pop    %ebx
801017dd:	5e                   	pop    %esi
801017de:	5f                   	pop    %edi
801017df:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801017e0:	e9 1b 32 00 00       	jmp    80104a00 <release>
801017e5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801017e8:	83 ec 0c             	sub    $0xc,%esp
801017eb:	68 40 24 11 80       	push   $0x80112440
801017f0:	e8 5b 31 00 00       	call   80104950 <acquire>
    int r = ip->ref;
801017f5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801017f8:	c7 04 24 40 24 11 80 	movl   $0x80112440,(%esp)
801017ff:	e8 fc 31 00 00       	call   80104a00 <release>
    if(r == 1){
80101804:	83 c4 10             	add    $0x10,%esp
80101807:	83 fb 01             	cmp    $0x1,%ebx
8010180a:	75 aa                	jne    801017b6 <iput+0x26>
8010180c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101812:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101815:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101818:	89 cf                	mov    %ecx,%edi
8010181a:	eb 0b                	jmp    80101827 <iput+0x97>
8010181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101820:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101823:	39 fb                	cmp    %edi,%ebx
80101825:	74 19                	je     80101840 <iput+0xb0>
    if(ip->addrs[i]){
80101827:	8b 13                	mov    (%ebx),%edx
80101829:	85 d2                	test   %edx,%edx
8010182b:	74 f3                	je     80101820 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010182d:	8b 06                	mov    (%esi),%eax
8010182f:	e8 cc f8 ff ff       	call   80101100 <bfree>
      ip->addrs[i] = 0;
80101834:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010183a:	eb e4                	jmp    80101820 <iput+0x90>
8010183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101840:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101846:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101849:	85 c0                	test   %eax,%eax
8010184b:	75 33                	jne    80101880 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010184d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101850:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101857:	56                   	push   %esi
80101858:	e8 53 fd ff ff       	call   801015b0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010185d:	31 c0                	xor    %eax,%eax
8010185f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101863:	89 34 24             	mov    %esi,(%esp)
80101866:	e8 45 fd ff ff       	call   801015b0 <iupdate>
      ip->valid = 0;
8010186b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101872:	83 c4 10             	add    $0x10,%esp
80101875:	e9 3c ff ff ff       	jmp    801017b6 <iput+0x26>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101880:	83 ec 08             	sub    $0x8,%esp
80101883:	50                   	push   %eax
80101884:	ff 36                	pushl  (%esi)
80101886:	e8 45 e8 ff ff       	call   801000d0 <bread>
8010188b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101891:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101894:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101897:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010189a:	83 c4 10             	add    $0x10,%esp
8010189d:	89 cf                	mov    %ecx,%edi
8010189f:	eb 0e                	jmp    801018af <iput+0x11f>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018ab:	39 fb                	cmp    %edi,%ebx
801018ad:	74 0f                	je     801018be <iput+0x12e>
      if(a[j])
801018af:	8b 13                	mov    (%ebx),%edx
801018b1:	85 d2                	test   %edx,%edx
801018b3:	74 f3                	je     801018a8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018b5:	8b 06                	mov    (%esi),%eax
801018b7:	e8 44 f8 ff ff       	call   80101100 <bfree>
801018bc:	eb ea                	jmp    801018a8 <iput+0x118>
    }
    brelse(bp);
801018be:	83 ec 0c             	sub    $0xc,%esp
801018c1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018c7:	e8 14 e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018cc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018d2:	8b 06                	mov    (%esi),%eax
801018d4:	e8 27 f8 ff ff       	call   80101100 <bfree>
    ip->addrs[NDIRECT] = 0;
801018d9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018e0:	00 00 00 
801018e3:	83 c4 10             	add    $0x10,%esp
801018e6:	e9 62 ff ff ff       	jmp    8010184d <iput+0xbd>
801018eb:	90                   	nop
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018f0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	53                   	push   %ebx
801018f4:	83 ec 10             	sub    $0x10,%esp
801018f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018fa:	53                   	push   %ebx
801018fb:	e8 40 fe ff ff       	call   80101740 <iunlock>
  iput(ip);
80101900:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101903:	83 c4 10             	add    $0x10,%esp
}
80101906:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101909:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010190a:	e9 81 fe ff ff       	jmp    80101790 <iput>
8010190f:	90                   	nop

80101910 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	8b 55 08             	mov    0x8(%ebp),%edx
80101916:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101919:	8b 0a                	mov    (%edx),%ecx
8010191b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010191e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101921:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101924:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101928:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010192b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010192f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101933:	8b 52 58             	mov    0x58(%edx),%edx
80101936:	89 50 10             	mov    %edx,0x10(%eax)
}
80101939:	5d                   	pop    %ebp
8010193a:	c3                   	ret    
8010193b:	90                   	nop
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101940 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	57                   	push   %edi
80101944:	56                   	push   %esi
80101945:	53                   	push   %ebx
80101946:	83 ec 1c             	sub    $0x1c,%esp
80101949:	8b 45 08             	mov    0x8(%ebp),%eax
8010194c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010194f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101952:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101957:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010195a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010195d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101960:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101963:	0f 84 a7 00 00 00    	je     80101a10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101969:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010196c:	8b 40 58             	mov    0x58(%eax),%eax
8010196f:	39 f0                	cmp    %esi,%eax
80101971:	0f 82 c1 00 00 00    	jb     80101a38 <readi+0xf8>
80101977:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010197a:	89 fa                	mov    %edi,%edx
8010197c:	01 f2                	add    %esi,%edx
8010197e:	0f 82 b4 00 00 00    	jb     80101a38 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101984:	89 c1                	mov    %eax,%ecx
80101986:	29 f1                	sub    %esi,%ecx
80101988:	39 d0                	cmp    %edx,%eax
8010198a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010198d:	31 ff                	xor    %edi,%edi
8010198f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101991:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101994:	74 6d                	je     80101a03 <readi+0xc3>
80101996:	8d 76 00             	lea    0x0(%esi),%esi
80101999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019a0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019a3:	89 f2                	mov    %esi,%edx
801019a5:	c1 ea 09             	shr    $0x9,%edx
801019a8:	89 d8                	mov    %ebx,%eax
801019aa:	e8 a1 f9 ff ff       	call   80101350 <bmap>
801019af:	83 ec 08             	sub    $0x8,%esp
801019b2:	50                   	push   %eax
801019b3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
801019b5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ba:	e8 11 e7 ff ff       	call   801000d0 <bread>
801019bf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019c4:	89 f1                	mov    %esi,%ecx
801019c6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019cc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
801019cf:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019d2:	29 cb                	sub    %ecx,%ebx
801019d4:	29 f8                	sub    %edi,%eax
801019d6:	39 c3                	cmp    %eax,%ebx
801019d8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019db:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019df:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019e0:	01 df                	add    %ebx,%edi
801019e2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801019e4:	50                   	push   %eax
801019e5:	ff 75 e0             	pushl  -0x20(%ebp)
801019e8:	e8 13 31 00 00       	call   80104b00 <memmove>
    brelse(bp);
801019ed:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019f0:	89 14 24             	mov    %edx,(%esp)
801019f3:	e8 e8 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f8:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019fb:	83 c4 10             	add    $0x10,%esp
801019fe:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a01:	77 9d                	ja     801019a0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a09:	5b                   	pop    %ebx
80101a0a:	5e                   	pop    %esi
80101a0b:	5f                   	pop    %edi
80101a0c:	5d                   	pop    %ebp
80101a0d:	c3                   	ret    
80101a0e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a14:	66 83 f8 09          	cmp    $0x9,%ax
80101a18:	77 1e                	ja     80101a38 <readi+0xf8>
80101a1a:	8b 04 c5 c0 23 11 80 	mov    -0x7feedc40(,%eax,8),%eax
80101a21:	85 c0                	test   %eax,%eax
80101a23:	74 13                	je     80101a38 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a25:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a2b:	5b                   	pop    %ebx
80101a2c:	5e                   	pop    %esi
80101a2d:	5f                   	pop    %edi
80101a2e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a2f:	ff e0                	jmp    *%eax
80101a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a3d:	eb c7                	jmp    80101a06 <readi+0xc6>
80101a3f:	90                   	nop

80101a40 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 1c             	sub    $0x1c,%esp
80101a49:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a4f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a52:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a57:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a5a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a5d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a60:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a63:	0f 84 b7 00 00 00    	je     80101b20 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a6c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a6f:	0f 82 eb 00 00 00    	jb     80101b60 <writei+0x120>
80101a75:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a78:	89 f8                	mov    %edi,%eax
80101a7a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a7c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a81:	0f 87 d9 00 00 00    	ja     80101b60 <writei+0x120>
80101a87:	39 c6                	cmp    %eax,%esi
80101a89:	0f 87 d1 00 00 00    	ja     80101b60 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a8f:	85 ff                	test   %edi,%edi
80101a91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a98:	74 78                	je     80101b12 <writei+0xd2>
80101a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aa0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101aa3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aaa:	c1 ea 09             	shr    $0x9,%edx
80101aad:	89 f8                	mov    %edi,%eax
80101aaf:	e8 9c f8 ff ff       	call   80101350 <bmap>
80101ab4:	83 ec 08             	sub    $0x8,%esp
80101ab7:	50                   	push   %eax
80101ab8:	ff 37                	pushl  (%edi)
80101aba:	e8 11 e6 ff ff       	call   801000d0 <bread>
80101abf:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ac4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ac7:	89 f1                	mov    %esi,%ecx
80101ac9:	83 c4 0c             	add    $0xc,%esp
80101acc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ad2:	29 cb                	sub    %ecx,%ebx
80101ad4:	39 c3                	cmp    %eax,%ebx
80101ad6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ad9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101add:	53                   	push   %ebx
80101ade:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ae1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101ae3:	50                   	push   %eax
80101ae4:	e8 17 30 00 00       	call   80104b00 <memmove>
    log_write(bp);
80101ae9:	89 3c 24             	mov    %edi,(%esp)
80101aec:	e8 2f 12 00 00       	call   80102d20 <log_write>
    brelse(bp);
80101af1:	89 3c 24             	mov    %edi,(%esp)
80101af4:	e8 e7 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101afc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101aff:	83 c4 10             	add    $0x10,%esp
80101b02:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b05:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b08:	77 96                	ja     80101aa0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b0a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b0d:	3b 70 58             	cmp    0x58(%eax),%esi
80101b10:	77 36                	ja     80101b48 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b18:	5b                   	pop    %ebx
80101b19:	5e                   	pop    %esi
80101b1a:	5f                   	pop    %edi
80101b1b:	5d                   	pop    %ebp
80101b1c:	c3                   	ret    
80101b1d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b20:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b24:	66 83 f8 09          	cmp    $0x9,%ax
80101b28:	77 36                	ja     80101b60 <writei+0x120>
80101b2a:	8b 04 c5 c4 23 11 80 	mov    -0x7feedc3c(,%eax,8),%eax
80101b31:	85 c0                	test   %eax,%eax
80101b33:	74 2b                	je     80101b60 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b35:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3b:	5b                   	pop    %ebx
80101b3c:	5e                   	pop    %esi
80101b3d:	5f                   	pop    %edi
80101b3e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b3f:	ff e0                	jmp    *%eax
80101b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b48:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b4b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b4e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b51:	50                   	push   %eax
80101b52:	e8 59 fa ff ff       	call   801015b0 <iupdate>
80101b57:	83 c4 10             	add    $0x10,%esp
80101b5a:	eb b6                	jmp    80101b12 <writei+0xd2>
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b65:	eb ae                	jmp    80101b15 <writei+0xd5>
80101b67:	89 f6                	mov    %esi,%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b70 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b76:	6a 0e                	push   $0xe
80101b78:	ff 75 0c             	pushl  0xc(%ebp)
80101b7b:	ff 75 08             	pushl  0x8(%ebp)
80101b7e:	e8 fd 2f 00 00       	call   80104b80 <strncmp>
}
80101b83:	c9                   	leave  
80101b84:	c3                   	ret    
80101b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b9c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ba1:	0f 85 80 00 00 00    	jne    80101c27 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ba7:	8b 53 58             	mov    0x58(%ebx),%edx
80101baa:	31 ff                	xor    %edi,%edi
80101bac:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101baf:	85 d2                	test   %edx,%edx
80101bb1:	75 0d                	jne    80101bc0 <dirlookup+0x30>
80101bb3:	eb 5b                	jmp    80101c10 <dirlookup+0x80>
80101bb5:	8d 76 00             	lea    0x0(%esi),%esi
80101bb8:	83 c7 10             	add    $0x10,%edi
80101bbb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bbe:	76 50                	jbe    80101c10 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bc0:	6a 10                	push   $0x10
80101bc2:	57                   	push   %edi
80101bc3:	56                   	push   %esi
80101bc4:	53                   	push   %ebx
80101bc5:	e8 76 fd ff ff       	call   80101940 <readi>
80101bca:	83 c4 10             	add    $0x10,%esp
80101bcd:	83 f8 10             	cmp    $0x10,%eax
80101bd0:	75 48                	jne    80101c1a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101bd2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bd7:	74 df                	je     80101bb8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101bd9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bdc:	83 ec 04             	sub    $0x4,%esp
80101bdf:	6a 0e                	push   $0xe
80101be1:	50                   	push   %eax
80101be2:	ff 75 0c             	pushl  0xc(%ebp)
80101be5:	e8 96 2f 00 00       	call   80104b80 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bea:	83 c4 10             	add    $0x10,%esp
80101bed:	85 c0                	test   %eax,%eax
80101bef:	75 c7                	jne    80101bb8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101bf1:	8b 45 10             	mov    0x10(%ebp),%eax
80101bf4:	85 c0                	test   %eax,%eax
80101bf6:	74 05                	je     80101bfd <dirlookup+0x6d>
        *poff = off;
80101bf8:	8b 45 10             	mov    0x10(%ebp),%eax
80101bfb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101bfd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c01:	8b 03                	mov    (%ebx),%eax
80101c03:	e8 78 f6 ff ff       	call   80101280 <iget>
    }
  }

  return 0;
}
80101c08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c0b:	5b                   	pop    %ebx
80101c0c:	5e                   	pop    %esi
80101c0d:	5f                   	pop    %edi
80101c0e:	5d                   	pop    %ebp
80101c0f:	c3                   	ret    
80101c10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c13:	31 c0                	xor    %eax,%eax
}
80101c15:	5b                   	pop    %ebx
80101c16:	5e                   	pop    %esi
80101c17:	5f                   	pop    %edi
80101c18:	5d                   	pop    %ebp
80101c19:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c1a:	83 ec 0c             	sub    $0xc,%esp
80101c1d:	68 d9 77 10 80       	push   $0x801077d9
80101c22:	e8 49 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c27:	83 ec 0c             	sub    $0xc,%esp
80101c2a:	68 c7 77 10 80       	push   $0x801077c7
80101c2f:	e8 3c e7 ff ff       	call   80100370 <panic>
80101c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c40 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	57                   	push   %edi
80101c44:	56                   	push   %esi
80101c45:	53                   	push   %ebx
80101c46:	89 cf                	mov    %ecx,%edi
80101c48:	89 c3                	mov    %eax,%ebx
80101c4a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c4d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c50:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c53:	0f 84 53 01 00 00    	je     80101dac <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c59:	e8 82 1b 00 00       	call   801037e0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c5e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c61:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c64:	68 40 24 11 80       	push   $0x80112440
80101c69:	e8 e2 2c 00 00       	call   80104950 <acquire>
  ip->ref++;
80101c6e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c72:	c7 04 24 40 24 11 80 	movl   $0x80112440,(%esp)
80101c79:	e8 82 2d 00 00       	call   80104a00 <release>
80101c7e:	83 c4 10             	add    $0x10,%esp
80101c81:	eb 08                	jmp    80101c8b <namex+0x4b>
80101c83:	90                   	nop
80101c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c88:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c8b:	0f b6 03             	movzbl (%ebx),%eax
80101c8e:	3c 2f                	cmp    $0x2f,%al
80101c90:	74 f6                	je     80101c88 <namex+0x48>
    path++;
  if(*path == 0)
80101c92:	84 c0                	test   %al,%al
80101c94:	0f 84 e3 00 00 00    	je     80101d7d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c9a:	0f b6 03             	movzbl (%ebx),%eax
80101c9d:	89 da                	mov    %ebx,%edx
80101c9f:	84 c0                	test   %al,%al
80101ca1:	0f 84 ac 00 00 00    	je     80101d53 <namex+0x113>
80101ca7:	3c 2f                	cmp    $0x2f,%al
80101ca9:	75 09                	jne    80101cb4 <namex+0x74>
80101cab:	e9 a3 00 00 00       	jmp    80101d53 <namex+0x113>
80101cb0:	84 c0                	test   %al,%al
80101cb2:	74 0a                	je     80101cbe <namex+0x7e>
    path++;
80101cb4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cb7:	0f b6 02             	movzbl (%edx),%eax
80101cba:	3c 2f                	cmp    $0x2f,%al
80101cbc:	75 f2                	jne    80101cb0 <namex+0x70>
80101cbe:	89 d1                	mov    %edx,%ecx
80101cc0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101cc2:	83 f9 0d             	cmp    $0xd,%ecx
80101cc5:	0f 8e 8d 00 00 00    	jle    80101d58 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101ccb:	83 ec 04             	sub    $0x4,%esp
80101cce:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cd1:	6a 0e                	push   $0xe
80101cd3:	53                   	push   %ebx
80101cd4:	57                   	push   %edi
80101cd5:	e8 26 2e 00 00       	call   80104b00 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cda:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101cdd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101ce0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ce2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101ce5:	75 11                	jne    80101cf8 <namex+0xb8>
80101ce7:	89 f6                	mov    %esi,%esi
80101ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cf0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cf3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101cf6:	74 f8                	je     80101cf0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101cf8:	83 ec 0c             	sub    $0xc,%esp
80101cfb:	56                   	push   %esi
80101cfc:	e8 5f f9 ff ff       	call   80101660 <ilock>
    if(ip->type != T_DIR){
80101d01:	83 c4 10             	add    $0x10,%esp
80101d04:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d09:	0f 85 7f 00 00 00    	jne    80101d8e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d12:	85 d2                	test   %edx,%edx
80101d14:	74 09                	je     80101d1f <namex+0xdf>
80101d16:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d19:	0f 84 a3 00 00 00    	je     80101dc2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d1f:	83 ec 04             	sub    $0x4,%esp
80101d22:	6a 00                	push   $0x0
80101d24:	57                   	push   %edi
80101d25:	56                   	push   %esi
80101d26:	e8 65 fe ff ff       	call   80101b90 <dirlookup>
80101d2b:	83 c4 10             	add    $0x10,%esp
80101d2e:	85 c0                	test   %eax,%eax
80101d30:	74 5c                	je     80101d8e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d32:	83 ec 0c             	sub    $0xc,%esp
80101d35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d38:	56                   	push   %esi
80101d39:	e8 02 fa ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d3e:	89 34 24             	mov    %esi,(%esp)
80101d41:	e8 4a fa ff ff       	call   80101790 <iput>
80101d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d49:	83 c4 10             	add    $0x10,%esp
80101d4c:	89 c6                	mov    %eax,%esi
80101d4e:	e9 38 ff ff ff       	jmp    80101c8b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d53:	31 c9                	xor    %ecx,%ecx
80101d55:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d58:	83 ec 04             	sub    $0x4,%esp
80101d5b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d5e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d61:	51                   	push   %ecx
80101d62:	53                   	push   %ebx
80101d63:	57                   	push   %edi
80101d64:	e8 97 2d 00 00       	call   80104b00 <memmove>
    name[len] = 0;
80101d69:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d6f:	83 c4 10             	add    $0x10,%esp
80101d72:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d76:	89 d3                	mov    %edx,%ebx
80101d78:	e9 65 ff ff ff       	jmp    80101ce2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d80:	85 c0                	test   %eax,%eax
80101d82:	75 54                	jne    80101dd8 <namex+0x198>
80101d84:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101d86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d89:	5b                   	pop    %ebx
80101d8a:	5e                   	pop    %esi
80101d8b:	5f                   	pop    %edi
80101d8c:	5d                   	pop    %ebp
80101d8d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d8e:	83 ec 0c             	sub    $0xc,%esp
80101d91:	56                   	push   %esi
80101d92:	e8 a9 f9 ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d97:	89 34 24             	mov    %esi,(%esp)
80101d9a:	e8 f1 f9 ff ff       	call   80101790 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d9f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101da2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101da5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101da7:	5b                   	pop    %ebx
80101da8:	5e                   	pop    %esi
80101da9:	5f                   	pop    %edi
80101daa:	5d                   	pop    %ebp
80101dab:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101dac:	ba 01 00 00 00       	mov    $0x1,%edx
80101db1:	b8 01 00 00 00       	mov    $0x1,%eax
80101db6:	e8 c5 f4 ff ff       	call   80101280 <iget>
80101dbb:	89 c6                	mov    %eax,%esi
80101dbd:	e9 c9 fe ff ff       	jmp    80101c8b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101dc2:	83 ec 0c             	sub    $0xc,%esp
80101dc5:	56                   	push   %esi
80101dc6:	e8 75 f9 ff ff       	call   80101740 <iunlock>
      return ip;
80101dcb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dce:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101dd1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dd3:	5b                   	pop    %ebx
80101dd4:	5e                   	pop    %esi
80101dd5:	5f                   	pop    %edi
80101dd6:	5d                   	pop    %ebp
80101dd7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101dd8:	83 ec 0c             	sub    $0xc,%esp
80101ddb:	56                   	push   %esi
80101ddc:	e8 af f9 ff ff       	call   80101790 <iput>
    return 0;
80101de1:	83 c4 10             	add    $0x10,%esp
80101de4:	31 c0                	xor    %eax,%eax
80101de6:	eb 9e                	jmp    80101d86 <namex+0x146>
80101de8:	90                   	nop
80101de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101df0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	83 ec 20             	sub    $0x20,%esp
80101df9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101dfc:	6a 00                	push   $0x0
80101dfe:	ff 75 0c             	pushl  0xc(%ebp)
80101e01:	53                   	push   %ebx
80101e02:	e8 89 fd ff ff       	call   80101b90 <dirlookup>
80101e07:	83 c4 10             	add    $0x10,%esp
80101e0a:	85 c0                	test   %eax,%eax
80101e0c:	75 67                	jne    80101e75 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e0e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e11:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e14:	85 ff                	test   %edi,%edi
80101e16:	74 29                	je     80101e41 <dirlink+0x51>
80101e18:	31 ff                	xor    %edi,%edi
80101e1a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e1d:	eb 09                	jmp    80101e28 <dirlink+0x38>
80101e1f:	90                   	nop
80101e20:	83 c7 10             	add    $0x10,%edi
80101e23:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e26:	76 19                	jbe    80101e41 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e28:	6a 10                	push   $0x10
80101e2a:	57                   	push   %edi
80101e2b:	56                   	push   %esi
80101e2c:	53                   	push   %ebx
80101e2d:	e8 0e fb ff ff       	call   80101940 <readi>
80101e32:	83 c4 10             	add    $0x10,%esp
80101e35:	83 f8 10             	cmp    $0x10,%eax
80101e38:	75 4e                	jne    80101e88 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e3f:	75 df                	jne    80101e20 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e41:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e44:	83 ec 04             	sub    $0x4,%esp
80101e47:	6a 0e                	push   $0xe
80101e49:	ff 75 0c             	pushl  0xc(%ebp)
80101e4c:	50                   	push   %eax
80101e4d:	e8 9e 2d 00 00       	call   80104bf0 <strncpy>
  de.inum = inum;
80101e52:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e55:	6a 10                	push   $0x10
80101e57:	57                   	push   %edi
80101e58:	56                   	push   %esi
80101e59:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e5a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e5e:	e8 dd fb ff ff       	call   80101a40 <writei>
80101e63:	83 c4 20             	add    $0x20,%esp
80101e66:	83 f8 10             	cmp    $0x10,%eax
80101e69:	75 2a                	jne    80101e95 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e6b:	31 c0                	xor    %eax,%eax
}
80101e6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e70:	5b                   	pop    %ebx
80101e71:	5e                   	pop    %esi
80101e72:	5f                   	pop    %edi
80101e73:	5d                   	pop    %ebp
80101e74:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e75:	83 ec 0c             	sub    $0xc,%esp
80101e78:	50                   	push   %eax
80101e79:	e8 12 f9 ff ff       	call   80101790 <iput>
    return -1;
80101e7e:	83 c4 10             	add    $0x10,%esp
80101e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e86:	eb e5                	jmp    80101e6d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e88:	83 ec 0c             	sub    $0xc,%esp
80101e8b:	68 e8 77 10 80       	push   $0x801077e8
80101e90:	e8 db e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101e95:	83 ec 0c             	sub    $0xc,%esp
80101e98:	68 96 7e 10 80       	push   $0x80107e96
80101e9d:	e8 ce e4 ff ff       	call   80100370 <panic>
80101ea2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101eb0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101eb1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101eb3:	89 e5                	mov    %esp,%ebp
80101eb5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101eb8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ebe:	e8 7d fd ff ff       	call   80101c40 <namex>
}
80101ec3:	c9                   	leave  
80101ec4:	c3                   	ret    
80101ec5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ed0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ed0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ed1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ed6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ed8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101edb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ede:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101edf:	e9 5c fd ff ff       	jmp    80101c40 <namex>
80101ee4:	66 90                	xchg   %ax,%ax
80101ee6:	66 90                	xchg   %ax,%ax
80101ee8:	66 90                	xchg   %ax,%ax
80101eea:	66 90                	xchg   %ax,%ax
80101eec:	66 90                	xchg   %ax,%ax
80101eee:	66 90                	xchg   %ax,%ax

80101ef0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ef0:	55                   	push   %ebp
  if(b == 0)
80101ef1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ef3:	89 e5                	mov    %esp,%ebp
80101ef5:	56                   	push   %esi
80101ef6:	53                   	push   %ebx
  if(b == 0)
80101ef7:	0f 84 ad 00 00 00    	je     80101faa <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101efd:	8b 58 08             	mov    0x8(%eax),%ebx
80101f00:	89 c1                	mov    %eax,%ecx
80101f02:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f08:	0f 87 8f 00 00 00    	ja     80101f9d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f0e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f13:	90                   	nop
80101f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f18:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f19:	83 e0 c0             	and    $0xffffffc0,%eax
80101f1c:	3c 40                	cmp    $0x40,%al
80101f1e:	75 f8                	jne    80101f18 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f20:	31 f6                	xor    %esi,%esi
80101f22:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f27:	89 f0                	mov    %esi,%eax
80101f29:	ee                   	out    %al,(%dx)
80101f2a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f2f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f34:	ee                   	out    %al,(%dx)
80101f35:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f3a:	89 d8                	mov    %ebx,%eax
80101f3c:	ee                   	out    %al,(%dx)
80101f3d:	89 d8                	mov    %ebx,%eax
80101f3f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f44:	c1 f8 08             	sar    $0x8,%eax
80101f47:	ee                   	out    %al,(%dx)
80101f48:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f4d:	89 f0                	mov    %esi,%eax
80101f4f:	ee                   	out    %al,(%dx)
80101f50:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f54:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f59:	83 e0 01             	and    $0x1,%eax
80101f5c:	c1 e0 04             	shl    $0x4,%eax
80101f5f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f62:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f63:	f6 01 04             	testb  $0x4,(%ecx)
80101f66:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f6b:	75 13                	jne    80101f80 <idestart+0x90>
80101f6d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f72:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f73:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f76:	5b                   	pop    %ebx
80101f77:	5e                   	pop    %esi
80101f78:	5d                   	pop    %ebp
80101f79:	c3                   	ret    
80101f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f80:	b8 30 00 00 00       	mov    $0x30,%eax
80101f85:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f86:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f8b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f8e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f93:	fc                   	cld    
80101f94:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f99:	5b                   	pop    %ebx
80101f9a:	5e                   	pop    %esi
80101f9b:	5d                   	pop    %ebp
80101f9c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101f9d:	83 ec 0c             	sub    $0xc,%esp
80101fa0:	68 54 78 10 80       	push   $0x80107854
80101fa5:	e8 c6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101faa:	83 ec 0c             	sub    $0xc,%esp
80101fad:	68 4b 78 10 80       	push   $0x8010784b
80101fb2:	e8 b9 e3 ff ff       	call   80100370 <panic>
80101fb7:	89 f6                	mov    %esi,%esi
80101fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fc0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fc0:	55                   	push   %ebp
80101fc1:	89 e5                	mov    %esp,%ebp
80101fc3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fc6:	68 66 78 10 80       	push   $0x80107866
80101fcb:	68 00 b6 10 80       	push   $0x8010b600
80101fd0:	e8 1b 28 00 00       	call   801047f0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fd5:	58                   	pop    %eax
80101fd6:	a1 80 47 11 80       	mov    0x80114780,%eax
80101fdb:	5a                   	pop    %edx
80101fdc:	83 e8 01             	sub    $0x1,%eax
80101fdf:	50                   	push   %eax
80101fe0:	6a 0e                	push   $0xe
80101fe2:	e8 a9 02 00 00       	call   80102290 <ioapicenable>
80101fe7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fea:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fef:	90                   	nop
80101ff0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ff1:	83 e0 c0             	and    $0xffffffc0,%eax
80101ff4:	3c 40                	cmp    $0x40,%al
80101ff6:	75 f8                	jne    80101ff0 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101ff8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101ffd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102002:	ee                   	out    %al,(%dx)
80102003:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102008:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010200d:	eb 06                	jmp    80102015 <ideinit+0x55>
8010200f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102010:	83 e9 01             	sub    $0x1,%ecx
80102013:	74 0f                	je     80102024 <ideinit+0x64>
80102015:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102016:	84 c0                	test   %al,%al
80102018:	74 f6                	je     80102010 <ideinit+0x50>
      havedisk1 = 1;
8010201a:	c7 05 e0 b5 10 80 01 	movl   $0x1,0x8010b5e0
80102021:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102024:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102029:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010202e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010202f:	c9                   	leave  
80102030:	c3                   	ret    
80102031:	eb 0d                	jmp    80102040 <ideintr>
80102033:	90                   	nop
80102034:	90                   	nop
80102035:	90                   	nop
80102036:	90                   	nop
80102037:	90                   	nop
80102038:	90                   	nop
80102039:	90                   	nop
8010203a:	90                   	nop
8010203b:	90                   	nop
8010203c:	90                   	nop
8010203d:	90                   	nop
8010203e:	90                   	nop
8010203f:	90                   	nop

80102040 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	57                   	push   %edi
80102044:	56                   	push   %esi
80102045:	53                   	push   %ebx
80102046:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102049:	68 00 b6 10 80       	push   $0x8010b600
8010204e:	e8 fd 28 00 00       	call   80104950 <acquire>

  if((b = idequeue) == 0){
80102053:	8b 1d e4 b5 10 80    	mov    0x8010b5e4,%ebx
80102059:	83 c4 10             	add    $0x10,%esp
8010205c:	85 db                	test   %ebx,%ebx
8010205e:	74 34                	je     80102094 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102060:	8b 43 58             	mov    0x58(%ebx),%eax
80102063:	a3 e4 b5 10 80       	mov    %eax,0x8010b5e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102068:	8b 33                	mov    (%ebx),%esi
8010206a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102070:	74 3e                	je     801020b0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102072:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102075:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102078:	83 ce 02             	or     $0x2,%esi
8010207b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010207d:	53                   	push   %ebx
8010207e:	e8 bd 22 00 00       	call   80104340 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102083:	a1 e4 b5 10 80       	mov    0x8010b5e4,%eax
80102088:	83 c4 10             	add    $0x10,%esp
8010208b:	85 c0                	test   %eax,%eax
8010208d:	74 05                	je     80102094 <ideintr+0x54>
    idestart(idequeue);
8010208f:	e8 5c fe ff ff       	call   80101ef0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102094:	83 ec 0c             	sub    $0xc,%esp
80102097:	68 00 b6 10 80       	push   $0x8010b600
8010209c:	e8 5f 29 00 00       	call   80104a00 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801020a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020a4:	5b                   	pop    %ebx
801020a5:	5e                   	pop    %esi
801020a6:	5f                   	pop    %edi
801020a7:	5d                   	pop    %ebp
801020a8:	c3                   	ret    
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b5:	8d 76 00             	lea    0x0(%esi),%esi
801020b8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020b9:	89 c1                	mov    %eax,%ecx
801020bb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020be:	80 f9 40             	cmp    $0x40,%cl
801020c1:	75 f5                	jne    801020b8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020c3:	a8 21                	test   $0x21,%al
801020c5:	75 ab                	jne    80102072 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020c7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020ca:	b9 80 00 00 00       	mov    $0x80,%ecx
801020cf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020d4:	fc                   	cld    
801020d5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020d7:	8b 33                	mov    (%ebx),%esi
801020d9:	eb 97                	jmp    80102072 <ideintr+0x32>
801020db:	90                   	nop
801020dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	53                   	push   %ebx
801020e4:	83 ec 10             	sub    $0x10,%esp
801020e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801020ed:	50                   	push   %eax
801020ee:	e8 ad 26 00 00       	call   801047a0 <holdingsleep>
801020f3:	83 c4 10             	add    $0x10,%esp
801020f6:	85 c0                	test   %eax,%eax
801020f8:	0f 84 ad 00 00 00    	je     801021ab <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020fe:	8b 03                	mov    (%ebx),%eax
80102100:	83 e0 06             	and    $0x6,%eax
80102103:	83 f8 02             	cmp    $0x2,%eax
80102106:	0f 84 b9 00 00 00    	je     801021c5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010210c:	8b 53 04             	mov    0x4(%ebx),%edx
8010210f:	85 d2                	test   %edx,%edx
80102111:	74 0d                	je     80102120 <iderw+0x40>
80102113:	a1 e0 b5 10 80       	mov    0x8010b5e0,%eax
80102118:	85 c0                	test   %eax,%eax
8010211a:	0f 84 98 00 00 00    	je     801021b8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102120:	83 ec 0c             	sub    $0xc,%esp
80102123:	68 00 b6 10 80       	push   $0x8010b600
80102128:	e8 23 28 00 00       	call   80104950 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010212d:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
80102133:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102136:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010213d:	85 d2                	test   %edx,%edx
8010213f:	75 09                	jne    8010214a <iderw+0x6a>
80102141:	eb 58                	jmp    8010219b <iderw+0xbb>
80102143:	90                   	nop
80102144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102148:	89 c2                	mov    %eax,%edx
8010214a:	8b 42 58             	mov    0x58(%edx),%eax
8010214d:	85 c0                	test   %eax,%eax
8010214f:	75 f7                	jne    80102148 <iderw+0x68>
80102151:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102154:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102156:	3b 1d e4 b5 10 80    	cmp    0x8010b5e4,%ebx
8010215c:	74 44                	je     801021a2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	74 23                	je     8010218b <iderw+0xab>
80102168:	90                   	nop
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102170:	83 ec 08             	sub    $0x8,%esp
80102173:	68 00 b6 10 80       	push   $0x8010b600
80102178:	53                   	push   %ebx
80102179:	e8 a2 1e 00 00       	call   80104020 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010217e:	8b 03                	mov    (%ebx),%eax
80102180:	83 c4 10             	add    $0x10,%esp
80102183:	83 e0 06             	and    $0x6,%eax
80102186:	83 f8 02             	cmp    $0x2,%eax
80102189:	75 e5                	jne    80102170 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010218b:	c7 45 08 00 b6 10 80 	movl   $0x8010b600,0x8(%ebp)
}
80102192:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102195:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102196:	e9 65 28 00 00       	jmp    80104a00 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219b:	ba e4 b5 10 80       	mov    $0x8010b5e4,%edx
801021a0:	eb b2                	jmp    80102154 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801021a2:	89 d8                	mov    %ebx,%eax
801021a4:	e8 47 fd ff ff       	call   80101ef0 <idestart>
801021a9:	eb b3                	jmp    8010215e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801021ab:	83 ec 0c             	sub    $0xc,%esp
801021ae:	68 6a 78 10 80       	push   $0x8010786a
801021b3:	e8 b8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021b8:	83 ec 0c             	sub    $0xc,%esp
801021bb:	68 95 78 10 80       	push   $0x80107895
801021c0:	e8 ab e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021c5:	83 ec 0c             	sub    $0xc,%esp
801021c8:	68 80 78 10 80       	push   $0x80107880
801021cd:	e8 9e e1 ff ff       	call   80100370 <panic>
801021d2:	66 90                	xchg   %ax,%ax
801021d4:	66 90                	xchg   %ax,%ax
801021d6:	66 90                	xchg   %ax,%ax
801021d8:	66 90                	xchg   %ax,%ax
801021da:	66 90                	xchg   %ax,%ax
801021dc:	66 90                	xchg   %ax,%ax
801021de:	66 90                	xchg   %ax,%ax

801021e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021e1:	c7 05 94 40 11 80 00 	movl   $0xfec00000,0x80114094
801021e8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021eb:	89 e5                	mov    %esp,%ebp
801021ed:	56                   	push   %esi
801021ee:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021f6:	00 00 00 
  return ioapic->data;
801021f9:	8b 15 94 40 11 80    	mov    0x80114094,%edx
801021ff:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102202:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102208:	8b 0d 94 40 11 80    	mov    0x80114094,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010220e:	0f b6 15 c0 41 11 80 	movzbl 0x801141c0,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102215:	89 f0                	mov    %esi,%eax
80102217:	c1 e8 10             	shr    $0x10,%eax
8010221a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010221d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102220:	c1 e8 18             	shr    $0x18,%eax
80102223:	39 d0                	cmp    %edx,%eax
80102225:	74 16                	je     8010223d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102227:	83 ec 0c             	sub    $0xc,%esp
8010222a:	68 b4 78 10 80       	push   $0x801078b4
8010222f:	e8 2c e4 ff ff       	call   80100660 <cprintf>
80102234:	8b 0d 94 40 11 80    	mov    0x80114094,%ecx
8010223a:	83 c4 10             	add    $0x10,%esp
8010223d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	ba 10 00 00 00       	mov    $0x10,%edx
80102245:	b8 20 00 00 00       	mov    $0x20,%eax
8010224a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102250:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102252:	8b 0d 94 40 11 80    	mov    0x80114094,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102258:	89 c3                	mov    %eax,%ebx
8010225a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102260:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102263:	89 59 10             	mov    %ebx,0x10(%ecx)
80102266:	8d 5a 01             	lea    0x1(%edx),%ebx
80102269:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010226c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010226e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102270:	8b 0d 94 40 11 80    	mov    0x80114094,%ecx
80102276:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010227d:	75 d1                	jne    80102250 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010227f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102282:	5b                   	pop    %ebx
80102283:	5e                   	pop    %esi
80102284:	5d                   	pop    %ebp
80102285:	c3                   	ret    
80102286:	8d 76 00             	lea    0x0(%esi),%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102290 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102290:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102291:	8b 0d 94 40 11 80    	mov    0x80114094,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102297:	89 e5                	mov    %esp,%ebp
80102299:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010229c:	8d 50 20             	lea    0x20(%eax),%edx
8010229f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022a5:	8b 0d 94 40 11 80    	mov    0x80114094,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ae:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022b1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022b6:	a1 94 40 11 80       	mov    0x80114094,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022bb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022be:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022c1:	5d                   	pop    %ebp
801022c2:	c3                   	ret    
801022c3:	66 90                	xchg   %ax,%ax
801022c5:	66 90                	xchg   %ax,%ax
801022c7:	66 90                	xchg   %ax,%ax
801022c9:	66 90                	xchg   %ax,%ax
801022cb:	66 90                	xchg   %ax,%ax
801022cd:	66 90                	xchg   %ax,%ax
801022cf:	90                   	nop

801022d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	53                   	push   %ebx
801022d4:	83 ec 04             	sub    $0x4,%esp
801022d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022e0:	75 70                	jne    80102352 <kfree+0x82>
801022e2:	81 fb 28 7b 11 80    	cmp    $0x80117b28,%ebx
801022e8:	72 68                	jb     80102352 <kfree+0x82>
801022ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022f5:	77 5b                	ja     80102352 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022f7:	83 ec 04             	sub    $0x4,%esp
801022fa:	68 00 10 00 00       	push   $0x1000
801022ff:	6a 01                	push   $0x1
80102301:	53                   	push   %ebx
80102302:	e8 49 27 00 00       	call   80104a50 <memset>

  if(kmem.use_lock)
80102307:	8b 15 d4 40 11 80    	mov    0x801140d4,%edx
8010230d:	83 c4 10             	add    $0x10,%esp
80102310:	85 d2                	test   %edx,%edx
80102312:	75 2c                	jne    80102340 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102314:	a1 d8 40 11 80       	mov    0x801140d8,%eax
80102319:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010231b:	a1 d4 40 11 80       	mov    0x801140d4,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102320:	89 1d d8 40 11 80    	mov    %ebx,0x801140d8
  if(kmem.use_lock)
80102326:	85 c0                	test   %eax,%eax
80102328:	75 06                	jne    80102330 <kfree+0x60>
    release(&kmem.lock);
}
8010232a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010232d:	c9                   	leave  
8010232e:	c3                   	ret    
8010232f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102330:	c7 45 08 a0 40 11 80 	movl   $0x801140a0,0x8(%ebp)
}
80102337:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010233b:	e9 c0 26 00 00       	jmp    80104a00 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	68 a0 40 11 80       	push   $0x801140a0
80102348:	e8 03 26 00 00       	call   80104950 <acquire>
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	eb c2                	jmp    80102314 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102352:	83 ec 0c             	sub    $0xc,%esp
80102355:	68 e6 78 10 80       	push   $0x801078e6
8010235a:	e8 11 e0 ff ff       	call   80100370 <panic>
8010235f:	90                   	nop

80102360 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	56                   	push   %esi
80102364:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102365:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102368:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010236b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102371:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102377:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010237d:	39 de                	cmp    %ebx,%esi
8010237f:	72 23                	jb     801023a4 <freerange+0x44>
80102381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102388:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010238e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102391:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102397:	50                   	push   %eax
80102398:	e8 33 ff ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	39 f3                	cmp    %esi,%ebx
801023a2:	76 e4                	jbe    80102388 <freerange+0x28>
    kfree(p);
}
801023a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a7:	5b                   	pop    %ebx
801023a8:	5e                   	pop    %esi
801023a9:	5d                   	pop    %ebp
801023aa:	c3                   	ret    
801023ab:	90                   	nop
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
801023b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023b8:	83 ec 08             	sub    $0x8,%esp
801023bb:	68 ec 78 10 80       	push   $0x801078ec
801023c0:	68 a0 40 11 80       	push   $0x801140a0
801023c5:	e8 26 24 00 00       	call   801047f0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023cd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023d0:	c7 05 d4 40 11 80 00 	movl   $0x0,0x801140d4
801023d7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ec:	39 de                	cmp    %ebx,%esi
801023ee:	72 1c                	jb     8010240c <kinit1+0x5c>
    kfree(p);
801023f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023f6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023ff:	50                   	push   %eax
80102400:	e8 cb fe ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102405:	83 c4 10             	add    $0x10,%esp
80102408:	39 de                	cmp    %ebx,%esi
8010240a:	73 e4                	jae    801023f0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010240c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010240f:	5b                   	pop    %ebx
80102410:	5e                   	pop    %esi
80102411:	5d                   	pop    %ebp
80102412:	c3                   	ret    
80102413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102420 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102425:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102428:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010242b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102431:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102437:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243d:	39 de                	cmp    %ebx,%esi
8010243f:	72 23                	jb     80102464 <kinit2+0x44>
80102441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102448:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010244e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102451:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102457:	50                   	push   %eax
80102458:	e8 73 fe ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	39 de                	cmp    %ebx,%esi
80102462:	73 e4                	jae    80102448 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102464:	c7 05 d4 40 11 80 01 	movl   $0x1,0x801140d4
8010246b:	00 00 00 
}
8010246e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102471:	5b                   	pop    %ebx
80102472:	5e                   	pop    %esi
80102473:	5d                   	pop    %ebp
80102474:	c3                   	ret    
80102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102487:	a1 d4 40 11 80       	mov    0x801140d4,%eax
8010248c:	85 c0                	test   %eax,%eax
8010248e:	75 30                	jne    801024c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102490:	8b 1d d8 40 11 80    	mov    0x801140d8,%ebx
  if(r)
80102496:	85 db                	test   %ebx,%ebx
80102498:	74 1c                	je     801024b6 <kalloc+0x36>
    kmem.freelist = r->next;
8010249a:	8b 13                	mov    (%ebx),%edx
8010249c:	89 15 d8 40 11 80    	mov    %edx,0x801140d8
  if(kmem.use_lock)
801024a2:	85 c0                	test   %eax,%eax
801024a4:	74 10                	je     801024b6 <kalloc+0x36>
    release(&kmem.lock);
801024a6:	83 ec 0c             	sub    $0xc,%esp
801024a9:	68 a0 40 11 80       	push   $0x801140a0
801024ae:	e8 4d 25 00 00       	call   80104a00 <release>
801024b3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024b6:	89 d8                	mov    %ebx,%eax
801024b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024bb:	c9                   	leave  
801024bc:	c3                   	ret    
801024bd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024c0:	83 ec 0c             	sub    $0xc,%esp
801024c3:	68 a0 40 11 80       	push   $0x801140a0
801024c8:	e8 83 24 00 00       	call   80104950 <acquire>
  r = kmem.freelist;
801024cd:	8b 1d d8 40 11 80    	mov    0x801140d8,%ebx
  if(r)
801024d3:	83 c4 10             	add    $0x10,%esp
801024d6:	a1 d4 40 11 80       	mov    0x801140d4,%eax
801024db:	85 db                	test   %ebx,%ebx
801024dd:	75 bb                	jne    8010249a <kalloc+0x1a>
801024df:	eb c1                	jmp    801024a2 <kalloc+0x22>
801024e1:	66 90                	xchg   %ax,%ax
801024e3:	66 90                	xchg   %ax,%ax
801024e5:	66 90                	xchg   %ax,%ax
801024e7:	66 90                	xchg   %ax,%ax
801024e9:	66 90                	xchg   %ax,%ax
801024eb:	66 90                	xchg   %ax,%ax
801024ed:	66 90                	xchg   %ax,%ax
801024ef:	90                   	nop

801024f0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801024f0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f1:	ba 64 00 00 00       	mov    $0x64,%edx
801024f6:	89 e5                	mov    %esp,%ebp
801024f8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024f9:	a8 01                	test   $0x1,%al
801024fb:	0f 84 af 00 00 00    	je     801025b0 <kbdgetc+0xc0>
80102501:	ba 60 00 00 00       	mov    $0x60,%edx
80102506:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102507:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010250a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102510:	74 7e                	je     80102590 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102512:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102514:	8b 0d 34 b6 10 80    	mov    0x8010b634,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010251a:	79 24                	jns    80102540 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010251c:	f6 c1 40             	test   $0x40,%cl
8010251f:	75 05                	jne    80102526 <kbdgetc+0x36>
80102521:	89 c2                	mov    %eax,%edx
80102523:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102526:	0f b6 82 20 7a 10 80 	movzbl -0x7fef85e0(%edx),%eax
8010252d:	83 c8 40             	or     $0x40,%eax
80102530:	0f b6 c0             	movzbl %al,%eax
80102533:	f7 d0                	not    %eax
80102535:	21 c8                	and    %ecx,%eax
80102537:	a3 34 b6 10 80       	mov    %eax,0x8010b634
    return 0;
8010253c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010253e:	5d                   	pop    %ebp
8010253f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102540:	f6 c1 40             	test   $0x40,%cl
80102543:	74 09                	je     8010254e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102545:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102548:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010254b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010254e:	0f b6 82 20 7a 10 80 	movzbl -0x7fef85e0(%edx),%eax
80102555:	09 c1                	or     %eax,%ecx
80102557:	0f b6 82 20 79 10 80 	movzbl -0x7fef86e0(%edx),%eax
8010255e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102560:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102562:	89 0d 34 b6 10 80    	mov    %ecx,0x8010b634
  c = charcode[shift & (CTL | SHIFT)][data];
80102568:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010256b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010256e:	8b 04 85 00 79 10 80 	mov    -0x7fef8700(,%eax,4),%eax
80102575:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102579:	74 c3                	je     8010253e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010257b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010257e:	83 fa 19             	cmp    $0x19,%edx
80102581:	77 1d                	ja     801025a0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102583:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102586:	5d                   	pop    %ebp
80102587:	c3                   	ret    
80102588:	90                   	nop
80102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102590:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102592:	83 0d 34 b6 10 80 40 	orl    $0x40,0x8010b634
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102599:	5d                   	pop    %ebp
8010259a:	c3                   	ret    
8010259b:	90                   	nop
8010259c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025a0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025a3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801025a6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801025a7:	83 f9 19             	cmp    $0x19,%ecx
801025aa:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025ad:	c3                   	ret    
801025ae:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025b5:	5d                   	pop    %ebp
801025b6:	c3                   	ret    
801025b7:	89 f6                	mov    %esi,%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <kbdintr>:

void
kbdintr(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025c6:	68 f0 24 10 80       	push   $0x801024f0
801025cb:	e8 20 e2 ff ff       	call   801007f0 <consoleintr>
}
801025d0:	83 c4 10             	add    $0x10,%esp
801025d3:	c9                   	leave  
801025d4:	c3                   	ret    
801025d5:	66 90                	xchg   %ax,%ax
801025d7:	66 90                	xchg   %ax,%ax
801025d9:	66 90                	xchg   %ax,%ax
801025db:	66 90                	xchg   %ax,%ax
801025dd:	66 90                	xchg   %ax,%ax
801025df:	90                   	nop

801025e0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801025e0:	a1 dc 40 11 80       	mov    0x801140dc,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801025e5:	55                   	push   %ebp
801025e6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025e8:	85 c0                	test   %eax,%eax
801025ea:	0f 84 c8 00 00 00    	je     801026b8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025f0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801025f7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025fa:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025fd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102604:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102607:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010260a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102611:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102614:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102617:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010261e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102621:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102624:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010262b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010262e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102631:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102638:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010263b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010263e:	8b 50 30             	mov    0x30(%eax),%edx
80102641:	c1 ea 10             	shr    $0x10,%edx
80102644:	80 fa 03             	cmp    $0x3,%dl
80102647:	77 77                	ja     801026c0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102649:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102650:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102653:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102656:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010265d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102660:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102663:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010266a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102670:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102677:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010267a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102684:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102687:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010268a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102691:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102694:	8b 50 20             	mov    0x20(%eax),%edx
80102697:	89 f6                	mov    %esi,%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026a0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026a6:	80 e6 10             	and    $0x10,%dh
801026a9:	75 f5                	jne    801026a0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ab:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026b2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026b8:	5d                   	pop    %ebp
801026b9:	c3                   	ret    
801026ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026c7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ca:	8b 50 20             	mov    0x20(%eax),%edx
801026cd:	e9 77 ff ff ff       	jmp    80102649 <lapicinit+0x69>
801026d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026e0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801026e0:	a1 dc 40 11 80       	mov    0x801140dc,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801026e5:	55                   	push   %ebp
801026e6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801026e8:	85 c0                	test   %eax,%eax
801026ea:	74 0c                	je     801026f8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801026ec:	8b 40 20             	mov    0x20(%eax),%eax
}
801026ef:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801026f0:	c1 e8 18             	shr    $0x18,%eax
}
801026f3:	c3                   	ret    
801026f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801026f8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801026fa:	5d                   	pop    %ebp
801026fb:	c3                   	ret    
801026fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102700 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102700:	a1 dc 40 11 80       	mov    0x801140dc,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102705:	55                   	push   %ebp
80102706:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102708:	85 c0                	test   %eax,%eax
8010270a:	74 0d                	je     80102719 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010270c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102713:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102716:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102719:	5d                   	pop    %ebp
8010271a:	c3                   	ret    
8010271b:	90                   	nop
8010271c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102720 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
}
80102723:	5d                   	pop    %ebp
80102724:	c3                   	ret    
80102725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102730 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102730:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102731:	ba 70 00 00 00       	mov    $0x70,%edx
80102736:	b8 0f 00 00 00       	mov    $0xf,%eax
8010273b:	89 e5                	mov    %esp,%ebp
8010273d:	53                   	push   %ebx
8010273e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102741:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102744:	ee                   	out    %al,(%dx)
80102745:	ba 71 00 00 00       	mov    $0x71,%edx
8010274a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010274f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102750:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102752:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102755:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010275b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010275d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102760:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102763:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102765:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102768:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010276e:	a1 dc 40 11 80       	mov    0x801140dc,%eax
80102773:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102779:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010277c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102783:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102786:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102789:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102790:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102793:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102796:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010279c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010279f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027a5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ae:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027b7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027ba:	5b                   	pop    %ebx
801027bb:	5d                   	pop    %ebp
801027bc:	c3                   	ret    
801027bd:	8d 76 00             	lea    0x0(%esi),%esi

801027c0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801027c0:	55                   	push   %ebp
801027c1:	ba 70 00 00 00       	mov    $0x70,%edx
801027c6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027cb:	89 e5                	mov    %esp,%ebp
801027cd:	57                   	push   %edi
801027ce:	56                   	push   %esi
801027cf:	53                   	push   %ebx
801027d0:	83 ec 4c             	sub    $0x4c,%esp
801027d3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027d4:	ba 71 00 00 00       	mov    $0x71,%edx
801027d9:	ec                   	in     (%dx),%al
801027da:	83 e0 04             	and    $0x4,%eax
801027dd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027e0:	31 db                	xor    %ebx,%ebx
801027e2:	88 45 b7             	mov    %al,-0x49(%ebp)
801027e5:	bf 70 00 00 00       	mov    $0x70,%edi
801027ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801027f0:	89 d8                	mov    %ebx,%eax
801027f2:	89 fa                	mov    %edi,%edx
801027f4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027f5:	b9 71 00 00 00       	mov    $0x71,%ecx
801027fa:	89 ca                	mov    %ecx,%edx
801027fc:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801027fd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102800:	89 fa                	mov    %edi,%edx
80102802:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102805:	b8 02 00 00 00       	mov    $0x2,%eax
8010280a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010280b:	89 ca                	mov    %ecx,%edx
8010280d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010280e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102811:	89 fa                	mov    %edi,%edx
80102813:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102816:	b8 04 00 00 00       	mov    $0x4,%eax
8010281b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010281c:	89 ca                	mov    %ecx,%edx
8010281e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010281f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102822:	89 fa                	mov    %edi,%edx
80102824:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102827:	b8 07 00 00 00       	mov    $0x7,%eax
8010282c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010282d:	89 ca                	mov    %ecx,%edx
8010282f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102830:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102833:	89 fa                	mov    %edi,%edx
80102835:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102838:	b8 08 00 00 00       	mov    $0x8,%eax
8010283d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010283e:	89 ca                	mov    %ecx,%edx
80102840:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102841:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102844:	89 fa                	mov    %edi,%edx
80102846:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102849:	b8 09 00 00 00       	mov    $0x9,%eax
8010284e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284f:	89 ca                	mov    %ecx,%edx
80102851:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102852:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102855:	89 fa                	mov    %edi,%edx
80102857:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010285a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010285f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102860:	89 ca                	mov    %ecx,%edx
80102862:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102863:	84 c0                	test   %al,%al
80102865:	78 89                	js     801027f0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102867:	89 d8                	mov    %ebx,%eax
80102869:	89 fa                	mov    %edi,%edx
8010286b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286c:	89 ca                	mov    %ecx,%edx
8010286e:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010286f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102872:	89 fa                	mov    %edi,%edx
80102874:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102877:	b8 02 00 00 00       	mov    $0x2,%eax
8010287c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287d:	89 ca                	mov    %ecx,%edx
8010287f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102880:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102883:	89 fa                	mov    %edi,%edx
80102885:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102888:	b8 04 00 00 00       	mov    $0x4,%eax
8010288d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288e:	89 ca                	mov    %ecx,%edx
80102890:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102891:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102894:	89 fa                	mov    %edi,%edx
80102896:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102899:	b8 07 00 00 00       	mov    $0x7,%eax
8010289e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289f:	89 ca                	mov    %ecx,%edx
801028a1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801028a2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a5:	89 fa                	mov    %edi,%edx
801028a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028aa:	b8 08 00 00 00       	mov    $0x8,%eax
801028af:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b0:	89 ca                	mov    %ecx,%edx
801028b2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028b3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b6:	89 fa                	mov    %edi,%edx
801028b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028bb:	b8 09 00 00 00       	mov    $0x9,%eax
801028c0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c1:	89 ca                	mov    %ecx,%edx
801028c3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801028c4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028c7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801028ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028cd:	8d 45 b8             	lea    -0x48(%ebp),%eax
801028d0:	6a 18                	push   $0x18
801028d2:	56                   	push   %esi
801028d3:	50                   	push   %eax
801028d4:	e8 c7 21 00 00       	call   80104aa0 <memcmp>
801028d9:	83 c4 10             	add    $0x10,%esp
801028dc:	85 c0                	test   %eax,%eax
801028de:	0f 85 0c ff ff ff    	jne    801027f0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801028e4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028e8:	75 78                	jne    80102962 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028ea:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028ed:	89 c2                	mov    %eax,%edx
801028ef:	83 e0 0f             	and    $0xf,%eax
801028f2:	c1 ea 04             	shr    $0x4,%edx
801028f5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028f8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028fb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028fe:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102901:	89 c2                	mov    %eax,%edx
80102903:	83 e0 0f             	and    $0xf,%eax
80102906:	c1 ea 04             	shr    $0x4,%edx
80102909:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010290c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102912:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102915:	89 c2                	mov    %eax,%edx
80102917:	83 e0 0f             	and    $0xf,%eax
8010291a:	c1 ea 04             	shr    $0x4,%edx
8010291d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102920:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102923:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102926:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102929:	89 c2                	mov    %eax,%edx
8010292b:	83 e0 0f             	and    $0xf,%eax
8010292e:	c1 ea 04             	shr    $0x4,%edx
80102931:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102934:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102937:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010293a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010293d:	89 c2                	mov    %eax,%edx
8010293f:	83 e0 0f             	and    $0xf,%eax
80102942:	c1 ea 04             	shr    $0x4,%edx
80102945:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102948:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010294b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010294e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102951:	89 c2                	mov    %eax,%edx
80102953:	83 e0 0f             	and    $0xf,%eax
80102956:	c1 ea 04             	shr    $0x4,%edx
80102959:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010295c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102962:	8b 75 08             	mov    0x8(%ebp),%esi
80102965:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102968:	89 06                	mov    %eax,(%esi)
8010296a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010296d:	89 46 04             	mov    %eax,0x4(%esi)
80102970:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102973:	89 46 08             	mov    %eax,0x8(%esi)
80102976:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102979:	89 46 0c             	mov    %eax,0xc(%esi)
8010297c:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010297f:	89 46 10             	mov    %eax,0x10(%esi)
80102982:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102985:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102988:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
8010298f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102992:	5b                   	pop    %ebx
80102993:	5e                   	pop    %esi
80102994:	5f                   	pop    %edi
80102995:	5d                   	pop    %ebp
80102996:	c3                   	ret    
80102997:	66 90                	xchg   %ax,%ax
80102999:	66 90                	xchg   %ax,%ax
8010299b:	66 90                	xchg   %ax,%ax
8010299d:	66 90                	xchg   %ax,%ax
8010299f:	90                   	nop

801029a0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029a0:	8b 0d 28 41 11 80    	mov    0x80114128,%ecx
801029a6:	85 c9                	test   %ecx,%ecx
801029a8:	0f 8e 85 00 00 00    	jle    80102a33 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029ae:	55                   	push   %ebp
801029af:	89 e5                	mov    %esp,%ebp
801029b1:	57                   	push   %edi
801029b2:	56                   	push   %esi
801029b3:	53                   	push   %ebx
801029b4:	31 db                	xor    %ebx,%ebx
801029b6:	83 ec 0c             	sub    $0xc,%esp
801029b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029c0:	a1 14 41 11 80       	mov    0x80114114,%eax
801029c5:	83 ec 08             	sub    $0x8,%esp
801029c8:	01 d8                	add    %ebx,%eax
801029ca:	83 c0 01             	add    $0x1,%eax
801029cd:	50                   	push   %eax
801029ce:	ff 35 24 41 11 80    	pushl  0x80114124
801029d4:	e8 f7 d6 ff ff       	call   801000d0 <bread>
801029d9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029db:	58                   	pop    %eax
801029dc:	5a                   	pop    %edx
801029dd:	ff 34 9d 2c 41 11 80 	pushl  -0x7feebed4(,%ebx,4)
801029e4:	ff 35 24 41 11 80    	pushl  0x80114124
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029ea:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029ed:	e8 de d6 ff ff       	call   801000d0 <bread>
801029f2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029f4:	8d 47 5c             	lea    0x5c(%edi),%eax
801029f7:	83 c4 0c             	add    $0xc,%esp
801029fa:	68 00 02 00 00       	push   $0x200
801029ff:	50                   	push   %eax
80102a00:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a03:	50                   	push   %eax
80102a04:	e8 f7 20 00 00       	call   80104b00 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a09:	89 34 24             	mov    %esi,(%esp)
80102a0c:	e8 8f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a11:	89 3c 24             	mov    %edi,(%esp)
80102a14:	e8 c7 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a19:	89 34 24             	mov    %esi,(%esp)
80102a1c:	e8 bf d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a21:	83 c4 10             	add    $0x10,%esp
80102a24:	39 1d 28 41 11 80    	cmp    %ebx,0x80114128
80102a2a:	7f 94                	jg     801029c0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a2f:	5b                   	pop    %ebx
80102a30:	5e                   	pop    %esi
80102a31:	5f                   	pop    %edi
80102a32:	5d                   	pop    %ebp
80102a33:	f3 c3                	repz ret 
80102a35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	53                   	push   %ebx
80102a44:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a47:	ff 35 14 41 11 80    	pushl  0x80114114
80102a4d:	ff 35 24 41 11 80    	pushl  0x80114124
80102a53:	e8 78 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a58:	8b 0d 28 41 11 80    	mov    0x80114128,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102a5e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102a61:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a63:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a65:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102a68:	7e 1f                	jle    80102a89 <write_head+0x49>
80102a6a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102a71:	31 d2                	xor    %edx,%edx
80102a73:	90                   	nop
80102a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102a78:	8b 8a 2c 41 11 80    	mov    -0x7feebed4(%edx),%ecx
80102a7e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102a82:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a85:	39 c2                	cmp    %eax,%edx
80102a87:	75 ef                	jne    80102a78 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102a89:	83 ec 0c             	sub    $0xc,%esp
80102a8c:	53                   	push   %ebx
80102a8d:	e8 0e d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a92:	89 1c 24             	mov    %ebx,(%esp)
80102a95:	e8 46 d7 ff ff       	call   801001e0 <brelse>
}
80102a9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a9d:	c9                   	leave  
80102a9e:	c3                   	ret    
80102a9f:	90                   	nop

80102aa0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	53                   	push   %ebx
80102aa4:	83 ec 2c             	sub    $0x2c,%esp
80102aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102aaa:	68 20 7b 10 80       	push   $0x80107b20
80102aaf:	68 e0 40 11 80       	push   $0x801140e0
80102ab4:	e8 37 1d 00 00       	call   801047f0 <initlock>
  readsb(dev, &sb);
80102ab9:	58                   	pop    %eax
80102aba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102abd:	5a                   	pop    %edx
80102abe:	50                   	push   %eax
80102abf:	53                   	push   %ebx
80102ac0:	e8 5b e9 ff ff       	call   80101420 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ac5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ac8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102acb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102acc:	89 1d 24 41 11 80    	mov    %ebx,0x80114124

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102ad2:	89 15 18 41 11 80    	mov    %edx,0x80114118
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102ad8:	a3 14 41 11 80       	mov    %eax,0x80114114

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102add:	5a                   	pop    %edx
80102ade:	50                   	push   %eax
80102adf:	53                   	push   %ebx
80102ae0:	e8 eb d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102ae5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ae8:	83 c4 10             	add    $0x10,%esp
80102aeb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102aed:	89 0d 28 41 11 80    	mov    %ecx,0x80114128
  for (i = 0; i < log.lh.n; i++) {
80102af3:	7e 1c                	jle    80102b11 <initlog+0x71>
80102af5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102afc:	31 d2                	xor    %edx,%edx
80102afe:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b00:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b04:	83 c2 04             	add    $0x4,%edx
80102b07:	89 8a 28 41 11 80    	mov    %ecx,-0x7feebed8(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b0d:	39 da                	cmp    %ebx,%edx
80102b0f:	75 ef                	jne    80102b00 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b11:	83 ec 0c             	sub    $0xc,%esp
80102b14:	50                   	push   %eax
80102b15:	e8 c6 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b1a:	e8 81 fe ff ff       	call   801029a0 <install_trans>
  log.lh.n = 0;
80102b1f:	c7 05 28 41 11 80 00 	movl   $0x0,0x80114128
80102b26:	00 00 00 
  write_head(); // clear the log
80102b29:	e8 12 ff ff ff       	call   80102a40 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b31:	c9                   	leave  
80102b32:	c3                   	ret    
80102b33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b46:	68 e0 40 11 80       	push   $0x801140e0
80102b4b:	e8 00 1e 00 00       	call   80104950 <acquire>
80102b50:	83 c4 10             	add    $0x10,%esp
80102b53:	eb 18                	jmp    80102b6d <begin_op+0x2d>
80102b55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b58:	83 ec 08             	sub    $0x8,%esp
80102b5b:	68 e0 40 11 80       	push   $0x801140e0
80102b60:	68 e0 40 11 80       	push   $0x801140e0
80102b65:	e8 b6 14 00 00       	call   80104020 <sleep>
80102b6a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102b6d:	a1 20 41 11 80       	mov    0x80114120,%eax
80102b72:	85 c0                	test   %eax,%eax
80102b74:	75 e2                	jne    80102b58 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b76:	a1 1c 41 11 80       	mov    0x8011411c,%eax
80102b7b:	8b 15 28 41 11 80    	mov    0x80114128,%edx
80102b81:	83 c0 01             	add    $0x1,%eax
80102b84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b8a:	83 fa 1e             	cmp    $0x1e,%edx
80102b8d:	7f c9                	jg     80102b58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b8f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102b92:	a3 1c 41 11 80       	mov    %eax,0x8011411c
      release(&log.lock);
80102b97:	68 e0 40 11 80       	push   $0x801140e0
80102b9c:	e8 5f 1e 00 00       	call   80104a00 <release>
      break;
    }
  }
}
80102ba1:	83 c4 10             	add    $0x10,%esp
80102ba4:	c9                   	leave  
80102ba5:	c3                   	ret    
80102ba6:	8d 76 00             	lea    0x0(%esi),%esi
80102ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	57                   	push   %edi
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bb9:	68 e0 40 11 80       	push   $0x801140e0
80102bbe:	e8 8d 1d 00 00       	call   80104950 <acquire>
  log.outstanding -= 1;
80102bc3:	a1 1c 41 11 80       	mov    0x8011411c,%eax
  if(log.committing)
80102bc8:	8b 1d 20 41 11 80    	mov    0x80114120,%ebx
80102bce:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102bd1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102bd4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102bd6:	a3 1c 41 11 80       	mov    %eax,0x8011411c
  if(log.committing)
80102bdb:	0f 85 23 01 00 00    	jne    80102d04 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102be1:	85 c0                	test   %eax,%eax
80102be3:	0f 85 f7 00 00 00    	jne    80102ce0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102be9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102bec:	c7 05 20 41 11 80 01 	movl   $0x1,0x80114120
80102bf3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bf6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102bf8:	68 e0 40 11 80       	push   $0x801140e0
80102bfd:	e8 fe 1d 00 00       	call   80104a00 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c02:	8b 0d 28 41 11 80    	mov    0x80114128,%ecx
80102c08:	83 c4 10             	add    $0x10,%esp
80102c0b:	85 c9                	test   %ecx,%ecx
80102c0d:	0f 8e 8a 00 00 00    	jle    80102c9d <end_op+0xed>
80102c13:	90                   	nop
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c18:	a1 14 41 11 80       	mov    0x80114114,%eax
80102c1d:	83 ec 08             	sub    $0x8,%esp
80102c20:	01 d8                	add    %ebx,%eax
80102c22:	83 c0 01             	add    $0x1,%eax
80102c25:	50                   	push   %eax
80102c26:	ff 35 24 41 11 80    	pushl  0x80114124
80102c2c:	e8 9f d4 ff ff       	call   801000d0 <bread>
80102c31:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c33:	58                   	pop    %eax
80102c34:	5a                   	pop    %edx
80102c35:	ff 34 9d 2c 41 11 80 	pushl  -0x7feebed4(,%ebx,4)
80102c3c:	ff 35 24 41 11 80    	pushl  0x80114124
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c42:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c45:	e8 86 d4 ff ff       	call   801000d0 <bread>
80102c4a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c4c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c4f:	83 c4 0c             	add    $0xc,%esp
80102c52:	68 00 02 00 00       	push   $0x200
80102c57:	50                   	push   %eax
80102c58:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c5b:	50                   	push   %eax
80102c5c:	e8 9f 1e 00 00       	call   80104b00 <memmove>
    bwrite(to);  // write the log
80102c61:	89 34 24             	mov    %esi,(%esp)
80102c64:	e8 37 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c69:	89 3c 24             	mov    %edi,(%esp)
80102c6c:	e8 6f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c71:	89 34 24             	mov    %esi,(%esp)
80102c74:	e8 67 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c79:	83 c4 10             	add    $0x10,%esp
80102c7c:	3b 1d 28 41 11 80    	cmp    0x80114128,%ebx
80102c82:	7c 94                	jl     80102c18 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c84:	e8 b7 fd ff ff       	call   80102a40 <write_head>
    install_trans(); // Now install writes to home locations
80102c89:	e8 12 fd ff ff       	call   801029a0 <install_trans>
    log.lh.n = 0;
80102c8e:	c7 05 28 41 11 80 00 	movl   $0x0,0x80114128
80102c95:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c98:	e8 a3 fd ff ff       	call   80102a40 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102c9d:	83 ec 0c             	sub    $0xc,%esp
80102ca0:	68 e0 40 11 80       	push   $0x801140e0
80102ca5:	e8 a6 1c 00 00       	call   80104950 <acquire>
    log.committing = 0;
    wakeup(&log);
80102caa:	c7 04 24 e0 40 11 80 	movl   $0x801140e0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102cb1:	c7 05 20 41 11 80 00 	movl   $0x0,0x80114120
80102cb8:	00 00 00 
    wakeup(&log);
80102cbb:	e8 80 16 00 00       	call   80104340 <wakeup>
    release(&log.lock);
80102cc0:	c7 04 24 e0 40 11 80 	movl   $0x801140e0,(%esp)
80102cc7:	e8 34 1d 00 00       	call   80104a00 <release>
80102ccc:	83 c4 10             	add    $0x10,%esp
  }
}
80102ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cd2:	5b                   	pop    %ebx
80102cd3:	5e                   	pop    %esi
80102cd4:	5f                   	pop    %edi
80102cd5:	5d                   	pop    %ebp
80102cd6:	c3                   	ret    
80102cd7:	89 f6                	mov    %esi,%esi
80102cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102ce0:	83 ec 0c             	sub    $0xc,%esp
80102ce3:	68 e0 40 11 80       	push   $0x801140e0
80102ce8:	e8 53 16 00 00       	call   80104340 <wakeup>
  }
  release(&log.lock);
80102ced:	c7 04 24 e0 40 11 80 	movl   $0x801140e0,(%esp)
80102cf4:	e8 07 1d 00 00       	call   80104a00 <release>
80102cf9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102cfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cff:	5b                   	pop    %ebx
80102d00:	5e                   	pop    %esi
80102d01:	5f                   	pop    %edi
80102d02:	5d                   	pop    %ebp
80102d03:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d04:	83 ec 0c             	sub    $0xc,%esp
80102d07:	68 24 7b 10 80       	push   $0x80107b24
80102d0c:	e8 5f d6 ff ff       	call   80100370 <panic>
80102d11:	eb 0d                	jmp    80102d20 <log_write>
80102d13:	90                   	nop
80102d14:	90                   	nop
80102d15:	90                   	nop
80102d16:	90                   	nop
80102d17:	90                   	nop
80102d18:	90                   	nop
80102d19:	90                   	nop
80102d1a:	90                   	nop
80102d1b:	90                   	nop
80102d1c:	90                   	nop
80102d1d:	90                   	nop
80102d1e:	90                   	nop
80102d1f:	90                   	nop

80102d20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	53                   	push   %ebx
80102d24:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d27:	8b 15 28 41 11 80    	mov    0x80114128,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d30:	83 fa 1d             	cmp    $0x1d,%edx
80102d33:	0f 8f 97 00 00 00    	jg     80102dd0 <log_write+0xb0>
80102d39:	a1 18 41 11 80       	mov    0x80114118,%eax
80102d3e:	83 e8 01             	sub    $0x1,%eax
80102d41:	39 c2                	cmp    %eax,%edx
80102d43:	0f 8d 87 00 00 00    	jge    80102dd0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d49:	a1 1c 41 11 80       	mov    0x8011411c,%eax
80102d4e:	85 c0                	test   %eax,%eax
80102d50:	0f 8e 87 00 00 00    	jle    80102ddd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d56:	83 ec 0c             	sub    $0xc,%esp
80102d59:	68 e0 40 11 80       	push   $0x801140e0
80102d5e:	e8 ed 1b 00 00       	call   80104950 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d63:	8b 15 28 41 11 80    	mov    0x80114128,%edx
80102d69:	83 c4 10             	add    $0x10,%esp
80102d6c:	83 fa 00             	cmp    $0x0,%edx
80102d6f:	7e 50                	jle    80102dc1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d71:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102d74:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d76:	3b 0d 2c 41 11 80    	cmp    0x8011412c,%ecx
80102d7c:	75 0b                	jne    80102d89 <log_write+0x69>
80102d7e:	eb 38                	jmp    80102db8 <log_write+0x98>
80102d80:	39 0c 85 2c 41 11 80 	cmp    %ecx,-0x7feebed4(,%eax,4)
80102d87:	74 2f                	je     80102db8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102d89:	83 c0 01             	add    $0x1,%eax
80102d8c:	39 d0                	cmp    %edx,%eax
80102d8e:	75 f0                	jne    80102d80 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102d90:	89 0c 95 2c 41 11 80 	mov    %ecx,-0x7feebed4(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d97:	83 c2 01             	add    $0x1,%edx
80102d9a:	89 15 28 41 11 80    	mov    %edx,0x80114128
  b->flags |= B_DIRTY; // prevent eviction
80102da0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102da3:	c7 45 08 e0 40 11 80 	movl   $0x801140e0,0x8(%ebp)
}
80102daa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102dad:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102dae:	e9 4d 1c 00 00       	jmp    80104a00 <release>
80102db3:	90                   	nop
80102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102db8:	89 0c 85 2c 41 11 80 	mov    %ecx,-0x7feebed4(,%eax,4)
80102dbf:	eb df                	jmp    80102da0 <log_write+0x80>
80102dc1:	8b 43 08             	mov    0x8(%ebx),%eax
80102dc4:	a3 2c 41 11 80       	mov    %eax,0x8011412c
  if (i == log.lh.n)
80102dc9:	75 d5                	jne    80102da0 <log_write+0x80>
80102dcb:	eb ca                	jmp    80102d97 <log_write+0x77>
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102dd0:	83 ec 0c             	sub    $0xc,%esp
80102dd3:	68 33 7b 10 80       	push   $0x80107b33
80102dd8:	e8 93 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102ddd:	83 ec 0c             	sub    $0xc,%esp
80102de0:	68 49 7b 10 80       	push   $0x80107b49
80102de5:	e8 86 d5 ff ff       	call   80100370 <panic>
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax

80102df0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	53                   	push   %ebx
80102df4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102df7:	e8 c4 09 00 00       	call   801037c0 <cpuid>
80102dfc:	89 c3                	mov    %eax,%ebx
80102dfe:	e8 bd 09 00 00       	call   801037c0 <cpuid>
80102e03:	83 ec 04             	sub    $0x4,%esp
80102e06:	53                   	push   %ebx
80102e07:	50                   	push   %eax
80102e08:	68 64 7b 10 80       	push   $0x80107b64
80102e0d:	e8 4e d8 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e12:	e8 69 30 00 00       	call   80105e80 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e17:	e8 24 09 00 00       	call   80103740 <mycpu>
80102e1c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e1e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e23:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e2a:	e8 f1 0d 00 00       	call   80103c20 <scheduler>
80102e2f:	90                   	nop

80102e30 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e36:	e8 75 41 00 00       	call   80106fb0 <switchkvm>
  seginit();
80102e3b:	e8 70 40 00 00       	call   80106eb0 <seginit>
  lapicinit();
80102e40:	e8 9b f7 ff ff       	call   801025e0 <lapicinit>
  mpmain();
80102e45:	e8 a6 ff ff ff       	call   80102df0 <mpmain>
80102e4a:	66 90                	xchg   %ax,%ax
80102e4c:	66 90                	xchg   %ax,%ax
80102e4e:	66 90                	xchg   %ax,%ax

80102e50 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e50:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e54:	83 e4 f0             	and    $0xfffffff0,%esp
80102e57:	ff 71 fc             	pushl  -0x4(%ecx)
80102e5a:	55                   	push   %ebp
80102e5b:	89 e5                	mov    %esp,%ebp
80102e5d:	53                   	push   %ebx
80102e5e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102e5f:	bb e0 41 11 80       	mov    $0x801141e0,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e64:	83 ec 08             	sub    $0x8,%esp
80102e67:	68 00 00 40 80       	push   $0x80400000
80102e6c:	68 28 7b 11 80       	push   $0x80117b28
80102e71:	e8 3a f5 ff ff       	call   801023b0 <kinit1>
  kvmalloc();      // kernel page table
80102e76:	e8 d5 45 00 00       	call   80107450 <kvmalloc>
  mpinit();        // detect other processors
80102e7b:	e8 70 01 00 00       	call   80102ff0 <mpinit>
  lapicinit();     // interrupt controller
80102e80:	e8 5b f7 ff ff       	call   801025e0 <lapicinit>
  seginit();       // segment descriptors
80102e85:	e8 26 40 00 00       	call   80106eb0 <seginit>
  picinit();       // disable pic
80102e8a:	e8 31 03 00 00       	call   801031c0 <picinit>
  ioapicinit();    // another interrupt controller
80102e8f:	e8 4c f3 ff ff       	call   801021e0 <ioapicinit>
  consoleinit();   // console hardware
80102e94:	e8 07 db ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102e99:	e8 e2 32 00 00       	call   80106180 <uartinit>
  pinit();         // process table
80102e9e:	e8 7d 08 00 00       	call   80103720 <pinit>
  tvinit();        // trap vectors
80102ea3:	e8 38 2f 00 00       	call   80105de0 <tvinit>
  binit();         // buffer cache
80102ea8:	e8 93 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ead:	e8 9e de ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102eb2:	e8 09 f1 ff ff       	call   80101fc0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102eb7:	83 c4 0c             	add    $0xc,%esp
80102eba:	68 8a 00 00 00       	push   $0x8a
80102ebf:	68 0c b5 10 80       	push   $0x8010b50c
80102ec4:	68 00 70 00 80       	push   $0x80007000
80102ec9:	e8 32 1c 00 00       	call   80104b00 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ece:	69 05 80 47 11 80 b4 	imul   $0xb4,0x80114780,%eax
80102ed5:	00 00 00 
80102ed8:	83 c4 10             	add    $0x10,%esp
80102edb:	05 e0 41 11 80       	add    $0x801141e0,%eax
80102ee0:	39 d8                	cmp    %ebx,%eax
80102ee2:	76 6f                	jbe    80102f53 <main+0x103>
80102ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102ee8:	e8 53 08 00 00       	call   80103740 <mycpu>
80102eed:	39 d8                	cmp    %ebx,%eax
80102eef:	74 49                	je     80102f3a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ef1:	e8 8a f5 ff ff       	call   80102480 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ef6:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102efb:	c7 05 f8 6f 00 80 30 	movl   $0x80102e30,0x80006ff8
80102f02:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f05:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f0c:	a0 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f0f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f14:	0f b6 03             	movzbl (%ebx),%eax
80102f17:	83 ec 08             	sub    $0x8,%esp
80102f1a:	68 00 70 00 00       	push   $0x7000
80102f1f:	50                   	push   %eax
80102f20:	e8 0b f8 ff ff       	call   80102730 <lapicstartap>
80102f25:	83 c4 10             	add    $0x10,%esp
80102f28:	90                   	nop
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f30:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f36:	85 c0                	test   %eax,%eax
80102f38:	74 f6                	je     80102f30 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f3a:	69 05 80 47 11 80 b4 	imul   $0xb4,0x80114780,%eax
80102f41:	00 00 00 
80102f44:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
80102f4a:	05 e0 41 11 80       	add    $0x801141e0,%eax
80102f4f:	39 c3                	cmp    %eax,%ebx
80102f51:	72 95                	jb     80102ee8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f53:	83 ec 08             	sub    $0x8,%esp
80102f56:	68 00 00 00 8e       	push   $0x8e000000
80102f5b:	68 00 00 40 80       	push   $0x80400000
80102f60:	e8 bb f4 ff ff       	call   80102420 <kinit2>
  userinit();      // first user process
80102f65:	e8 46 09 00 00       	call   801038b0 <userinit>
  mpmain();        // finish this processor's setup
80102f6a:	e8 81 fe ff ff       	call   80102df0 <mpmain>
80102f6f:	90                   	nop

80102f70 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	57                   	push   %edi
80102f74:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f75:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f7b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102f7c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f7f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102f82:	39 de                	cmp    %ebx,%esi
80102f84:	73 48                	jae    80102fce <mpsearch1+0x5e>
80102f86:	8d 76 00             	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f90:	83 ec 04             	sub    $0x4,%esp
80102f93:	8d 7e 10             	lea    0x10(%esi),%edi
80102f96:	6a 04                	push   $0x4
80102f98:	68 78 7b 10 80       	push   $0x80107b78
80102f9d:	56                   	push   %esi
80102f9e:	e8 fd 1a 00 00       	call   80104aa0 <memcmp>
80102fa3:	83 c4 10             	add    $0x10,%esp
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	75 1e                	jne    80102fc8 <mpsearch1+0x58>
80102faa:	8d 7e 10             	lea    0x10(%esi),%edi
80102fad:	89 f2                	mov    %esi,%edx
80102faf:	31 c9                	xor    %ecx,%ecx
80102fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102fb8:	0f b6 02             	movzbl (%edx),%eax
80102fbb:	83 c2 01             	add    $0x1,%edx
80102fbe:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102fc0:	39 fa                	cmp    %edi,%edx
80102fc2:	75 f4                	jne    80102fb8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fc4:	84 c9                	test   %cl,%cl
80102fc6:	74 10                	je     80102fd8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fc8:	39 fb                	cmp    %edi,%ebx
80102fca:	89 fe                	mov    %edi,%esi
80102fcc:	77 c2                	ja     80102f90 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80102fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80102fd1:	31 c0                	xor    %eax,%eax
}
80102fd3:	5b                   	pop    %ebx
80102fd4:	5e                   	pop    %esi
80102fd5:	5f                   	pop    %edi
80102fd6:	5d                   	pop    %ebp
80102fd7:	c3                   	ret    
80102fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fdb:	89 f0                	mov    %esi,%eax
80102fdd:	5b                   	pop    %ebx
80102fde:	5e                   	pop    %esi
80102fdf:	5f                   	pop    %edi
80102fe0:	5d                   	pop    %ebp
80102fe1:	c3                   	ret    
80102fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ff0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
80102ff5:	53                   	push   %ebx
80102ff6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102ff9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103000:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103007:	c1 e0 08             	shl    $0x8,%eax
8010300a:	09 d0                	or     %edx,%eax
8010300c:	c1 e0 04             	shl    $0x4,%eax
8010300f:	85 c0                	test   %eax,%eax
80103011:	75 1b                	jne    8010302e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103013:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010301a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103021:	c1 e0 08             	shl    $0x8,%eax
80103024:	09 d0                	or     %edx,%eax
80103026:	c1 e0 0a             	shl    $0xa,%eax
80103029:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010302e:	ba 00 04 00 00       	mov    $0x400,%edx
80103033:	e8 38 ff ff ff       	call   80102f70 <mpsearch1>
80103038:	85 c0                	test   %eax,%eax
8010303a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010303d:	0f 84 37 01 00 00    	je     8010317a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103043:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103046:	8b 58 04             	mov    0x4(%eax),%ebx
80103049:	85 db                	test   %ebx,%ebx
8010304b:	0f 84 43 01 00 00    	je     80103194 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103051:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103057:	83 ec 04             	sub    $0x4,%esp
8010305a:	6a 04                	push   $0x4
8010305c:	68 7d 7b 10 80       	push   $0x80107b7d
80103061:	56                   	push   %esi
80103062:	e8 39 1a 00 00       	call   80104aa0 <memcmp>
80103067:	83 c4 10             	add    $0x10,%esp
8010306a:	85 c0                	test   %eax,%eax
8010306c:	0f 85 22 01 00 00    	jne    80103194 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103072:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103079:	3c 01                	cmp    $0x1,%al
8010307b:	74 08                	je     80103085 <mpinit+0x95>
8010307d:	3c 04                	cmp    $0x4,%al
8010307f:	0f 85 0f 01 00 00    	jne    80103194 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103085:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010308c:	85 ff                	test   %edi,%edi
8010308e:	74 21                	je     801030b1 <mpinit+0xc1>
80103090:	31 d2                	xor    %edx,%edx
80103092:	31 c0                	xor    %eax,%eax
80103094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103098:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010309f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030a0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801030a3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030a5:	39 c7                	cmp    %eax,%edi
801030a7:	75 ef                	jne    80103098 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030a9:	84 d2                	test   %dl,%dl
801030ab:	0f 85 e3 00 00 00    	jne    80103194 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801030b1:	85 f6                	test   %esi,%esi
801030b3:	0f 84 db 00 00 00    	je     80103194 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801030b9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801030bf:	a3 dc 40 11 80       	mov    %eax,0x801140dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030c4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801030cb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
801030d1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030d6:	01 d6                	add    %edx,%esi
801030d8:	90                   	nop
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030e0:	39 c6                	cmp    %eax,%esi
801030e2:	76 23                	jbe    80103107 <mpinit+0x117>
801030e4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
801030e7:	80 fa 04             	cmp    $0x4,%dl
801030ea:	0f 87 c0 00 00 00    	ja     801031b0 <mpinit+0x1c0>
801030f0:	ff 24 95 bc 7b 10 80 	jmp    *-0x7fef8444(,%edx,4)
801030f7:	89 f6                	mov    %esi,%esi
801030f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103100:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103103:	39 c6                	cmp    %eax,%esi
80103105:	77 dd                	ja     801030e4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103107:	85 db                	test   %ebx,%ebx
80103109:	0f 84 92 00 00 00    	je     801031a1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010310f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103112:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103116:	74 15                	je     8010312d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103118:	ba 22 00 00 00       	mov    $0x22,%edx
8010311d:	b8 70 00 00 00       	mov    $0x70,%eax
80103122:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103123:	ba 23 00 00 00       	mov    $0x23,%edx
80103128:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103129:	83 c8 01             	or     $0x1,%eax
8010312c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010312d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103130:	5b                   	pop    %ebx
80103131:	5e                   	pop    %esi
80103132:	5f                   	pop    %edi
80103133:	5d                   	pop    %ebp
80103134:	c3                   	ret    
80103135:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103138:	8b 0d 80 47 11 80    	mov    0x80114780,%ecx
8010313e:	83 f9 07             	cmp    $0x7,%ecx
80103141:	7f 19                	jg     8010315c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103143:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103147:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
        ncpu++;
8010314d:	83 c1 01             	add    $0x1,%ecx
80103150:	89 0d 80 47 11 80    	mov    %ecx,0x80114780
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103156:	88 97 e0 41 11 80    	mov    %dl,-0x7feebe20(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010315c:	83 c0 14             	add    $0x14,%eax
      continue;
8010315f:	e9 7c ff ff ff       	jmp    801030e0 <mpinit+0xf0>
80103164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010316c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010316f:	88 15 c0 41 11 80    	mov    %dl,0x801141c0
      p += sizeof(struct mpioapic);
      continue;
80103175:	e9 66 ff ff ff       	jmp    801030e0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010317a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010317f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103184:	e8 e7 fd ff ff       	call   80102f70 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103189:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010318b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010318e:	0f 85 af fe ff ff    	jne    80103043 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103194:	83 ec 0c             	sub    $0xc,%esp
80103197:	68 82 7b 10 80       	push   $0x80107b82
8010319c:	e8 cf d1 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801031a1:	83 ec 0c             	sub    $0xc,%esp
801031a4:	68 9c 7b 10 80       	push   $0x80107b9c
801031a9:	e8 c2 d1 ff ff       	call   80100370 <panic>
801031ae:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031b0:	31 db                	xor    %ebx,%ebx
801031b2:	e9 30 ff ff ff       	jmp    801030e7 <mpinit+0xf7>
801031b7:	66 90                	xchg   %ax,%ax
801031b9:	66 90                	xchg   %ax,%ax
801031bb:	66 90                	xchg   %ax,%ax
801031bd:	66 90                	xchg   %ax,%ax
801031bf:	90                   	nop

801031c0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	ba 21 00 00 00       	mov    $0x21,%edx
801031c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801031cb:	89 e5                	mov    %esp,%ebp
801031cd:	ee                   	out    %al,(%dx)
801031ce:	ba a1 00 00 00       	mov    $0xa1,%edx
801031d3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801031d4:	5d                   	pop    %ebp
801031d5:	c3                   	ret    
801031d6:	66 90                	xchg   %ax,%ax
801031d8:	66 90                	xchg   %ax,%ax
801031da:	66 90                	xchg   %ax,%ax
801031dc:	66 90                	xchg   %ax,%ax
801031de:	66 90                	xchg   %ax,%ax

801031e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	57                   	push   %edi
801031e4:	56                   	push   %esi
801031e5:	53                   	push   %ebx
801031e6:	83 ec 0c             	sub    $0xc,%esp
801031e9:	8b 75 08             	mov    0x8(%ebp),%esi
801031ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801031ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801031f5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801031fb:	e8 70 db ff ff       	call   80100d70 <filealloc>
80103200:	85 c0                	test   %eax,%eax
80103202:	89 06                	mov    %eax,(%esi)
80103204:	0f 84 a8 00 00 00    	je     801032b2 <pipealloc+0xd2>
8010320a:	e8 61 db ff ff       	call   80100d70 <filealloc>
8010320f:	85 c0                	test   %eax,%eax
80103211:	89 03                	mov    %eax,(%ebx)
80103213:	0f 84 87 00 00 00    	je     801032a0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103219:	e8 62 f2 ff ff       	call   80102480 <kalloc>
8010321e:	85 c0                	test   %eax,%eax
80103220:	89 c7                	mov    %eax,%edi
80103222:	0f 84 b0 00 00 00    	je     801032d8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103228:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010322b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103232:	00 00 00 
  p->writeopen = 1;
80103235:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010323c:	00 00 00 
  p->nwrite = 0;
8010323f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103246:	00 00 00 
  p->nread = 0;
80103249:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103250:	00 00 00 
  initlock(&p->lock, "pipe");
80103253:	68 d0 7b 10 80       	push   $0x80107bd0
80103258:	50                   	push   %eax
80103259:	e8 92 15 00 00       	call   801047f0 <initlock>
  (*f0)->type = FD_PIPE;
8010325e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103260:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103263:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103269:	8b 06                	mov    (%esi),%eax
8010326b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010326f:	8b 06                	mov    (%esi),%eax
80103271:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103275:	8b 06                	mov    (%esi),%eax
80103277:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010327a:	8b 03                	mov    (%ebx),%eax
8010327c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103282:	8b 03                	mov    (%ebx),%eax
80103284:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103288:	8b 03                	mov    (%ebx),%eax
8010328a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010328e:	8b 03                	mov    (%ebx),%eax
80103290:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103293:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103296:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103298:	5b                   	pop    %ebx
80103299:	5e                   	pop    %esi
8010329a:	5f                   	pop    %edi
8010329b:	5d                   	pop    %ebp
8010329c:	c3                   	ret    
8010329d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032a0:	8b 06                	mov    (%esi),%eax
801032a2:	85 c0                	test   %eax,%eax
801032a4:	74 1e                	je     801032c4 <pipealloc+0xe4>
    fileclose(*f0);
801032a6:	83 ec 0c             	sub    $0xc,%esp
801032a9:	50                   	push   %eax
801032aa:	e8 81 db ff ff       	call   80100e30 <fileclose>
801032af:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032b2:	8b 03                	mov    (%ebx),%eax
801032b4:	85 c0                	test   %eax,%eax
801032b6:	74 0c                	je     801032c4 <pipealloc+0xe4>
    fileclose(*f1);
801032b8:	83 ec 0c             	sub    $0xc,%esp
801032bb:	50                   	push   %eax
801032bc:	e8 6f db ff ff       	call   80100e30 <fileclose>
801032c1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801032c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032cc:	5b                   	pop    %ebx
801032cd:	5e                   	pop    %esi
801032ce:	5f                   	pop    %edi
801032cf:	5d                   	pop    %ebp
801032d0:	c3                   	ret    
801032d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801032d8:	8b 06                	mov    (%esi),%eax
801032da:	85 c0                	test   %eax,%eax
801032dc:	75 c8                	jne    801032a6 <pipealloc+0xc6>
801032de:	eb d2                	jmp    801032b2 <pipealloc+0xd2>

801032e0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	56                   	push   %esi
801032e4:	53                   	push   %ebx
801032e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801032e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801032eb:	83 ec 0c             	sub    $0xc,%esp
801032ee:	53                   	push   %ebx
801032ef:	e8 5c 16 00 00       	call   80104950 <acquire>
  if(writable){
801032f4:	83 c4 10             	add    $0x10,%esp
801032f7:	85 f6                	test   %esi,%esi
801032f9:	74 45                	je     80103340 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801032fb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103301:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103304:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010330b:	00 00 00 
    wakeup(&p->nread);
8010330e:	50                   	push   %eax
8010330f:	e8 2c 10 00 00       	call   80104340 <wakeup>
80103314:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103317:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010331d:	85 d2                	test   %edx,%edx
8010331f:	75 0a                	jne    8010332b <pipeclose+0x4b>
80103321:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103327:	85 c0                	test   %eax,%eax
80103329:	74 35                	je     80103360 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010332b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010332e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103331:	5b                   	pop    %ebx
80103332:	5e                   	pop    %esi
80103333:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103334:	e9 c7 16 00 00       	jmp    80104a00 <release>
80103339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103340:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103346:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103349:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103350:	00 00 00 
    wakeup(&p->nwrite);
80103353:	50                   	push   %eax
80103354:	e8 e7 0f 00 00       	call   80104340 <wakeup>
80103359:	83 c4 10             	add    $0x10,%esp
8010335c:	eb b9                	jmp    80103317 <pipeclose+0x37>
8010335e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103360:	83 ec 0c             	sub    $0xc,%esp
80103363:	53                   	push   %ebx
80103364:	e8 97 16 00 00       	call   80104a00 <release>
    kfree((char*)p);
80103369:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010336c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010336f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103372:	5b                   	pop    %ebx
80103373:	5e                   	pop    %esi
80103374:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103375:	e9 56 ef ff ff       	jmp    801022d0 <kfree>
8010337a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103380 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	57                   	push   %edi
80103384:	56                   	push   %esi
80103385:	53                   	push   %ebx
80103386:	83 ec 28             	sub    $0x28,%esp
80103389:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010338c:	53                   	push   %ebx
8010338d:	e8 be 15 00 00       	call   80104950 <acquire>
  for(i = 0; i < n; i++){
80103392:	8b 45 10             	mov    0x10(%ebp),%eax
80103395:	83 c4 10             	add    $0x10,%esp
80103398:	85 c0                	test   %eax,%eax
8010339a:	0f 8e b9 00 00 00    	jle    80103459 <pipewrite+0xd9>
801033a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033a3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033af:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801033b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801033b8:	03 4d 10             	add    0x10(%ebp),%ecx
801033bb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033be:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801033c4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801033ca:	39 d0                	cmp    %edx,%eax
801033cc:	74 38                	je     80103406 <pipewrite+0x86>
801033ce:	eb 59                	jmp    80103429 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801033d0:	e8 0b 04 00 00       	call   801037e0 <myproc>
801033d5:	8b 48 24             	mov    0x24(%eax),%ecx
801033d8:	85 c9                	test   %ecx,%ecx
801033da:	75 34                	jne    80103410 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801033dc:	83 ec 0c             	sub    $0xc,%esp
801033df:	57                   	push   %edi
801033e0:	e8 5b 0f 00 00       	call   80104340 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801033e5:	58                   	pop    %eax
801033e6:	5a                   	pop    %edx
801033e7:	53                   	push   %ebx
801033e8:	56                   	push   %esi
801033e9:	e8 32 0c 00 00       	call   80104020 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033ee:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801033f4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801033fa:	83 c4 10             	add    $0x10,%esp
801033fd:	05 00 02 00 00       	add    $0x200,%eax
80103402:	39 c2                	cmp    %eax,%edx
80103404:	75 2a                	jne    80103430 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103406:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010340c:	85 c0                	test   %eax,%eax
8010340e:	75 c0                	jne    801033d0 <pipewrite+0x50>
        release(&p->lock);
80103410:	83 ec 0c             	sub    $0xc,%esp
80103413:	53                   	push   %ebx
80103414:	e8 e7 15 00 00       	call   80104a00 <release>
        return -1;
80103419:	83 c4 10             	add    $0x10,%esp
8010341c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103421:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103424:	5b                   	pop    %ebx
80103425:	5e                   	pop    %esi
80103426:	5f                   	pop    %edi
80103427:	5d                   	pop    %ebp
80103428:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103429:	89 c2                	mov    %eax,%edx
8010342b:	90                   	nop
8010342c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103430:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103433:	8d 42 01             	lea    0x1(%edx),%eax
80103436:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010343a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103440:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103446:	0f b6 09             	movzbl (%ecx),%ecx
80103449:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010344d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103450:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103453:	0f 85 65 ff ff ff    	jne    801033be <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103459:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010345f:	83 ec 0c             	sub    $0xc,%esp
80103462:	50                   	push   %eax
80103463:	e8 d8 0e 00 00       	call   80104340 <wakeup>
  release(&p->lock);
80103468:	89 1c 24             	mov    %ebx,(%esp)
8010346b:	e8 90 15 00 00       	call   80104a00 <release>
  return n;
80103470:	83 c4 10             	add    $0x10,%esp
80103473:	8b 45 10             	mov    0x10(%ebp),%eax
80103476:	eb a9                	jmp    80103421 <pipewrite+0xa1>
80103478:	90                   	nop
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103480 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 18             	sub    $0x18,%esp
80103489:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010348c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010348f:	53                   	push   %ebx
80103490:	e8 bb 14 00 00       	call   80104950 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103495:	83 c4 10             	add    $0x10,%esp
80103498:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010349e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801034a4:	75 6a                	jne    80103510 <piperead+0x90>
801034a6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801034ac:	85 f6                	test   %esi,%esi
801034ae:	0f 84 cc 00 00 00    	je     80103580 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801034b4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801034ba:	eb 2d                	jmp    801034e9 <piperead+0x69>
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034c0:	83 ec 08             	sub    $0x8,%esp
801034c3:	53                   	push   %ebx
801034c4:	56                   	push   %esi
801034c5:	e8 56 0b 00 00       	call   80104020 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801034ca:	83 c4 10             	add    $0x10,%esp
801034cd:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801034d3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801034d9:	75 35                	jne    80103510 <piperead+0x90>
801034db:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801034e1:	85 d2                	test   %edx,%edx
801034e3:	0f 84 97 00 00 00    	je     80103580 <piperead+0x100>
    if(myproc()->killed){
801034e9:	e8 f2 02 00 00       	call   801037e0 <myproc>
801034ee:	8b 48 24             	mov    0x24(%eax),%ecx
801034f1:	85 c9                	test   %ecx,%ecx
801034f3:	74 cb                	je     801034c0 <piperead+0x40>
      release(&p->lock);
801034f5:	83 ec 0c             	sub    $0xc,%esp
801034f8:	53                   	push   %ebx
801034f9:	e8 02 15 00 00       	call   80104a00 <release>
      return -1;
801034fe:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103501:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103504:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103509:	5b                   	pop    %ebx
8010350a:	5e                   	pop    %esi
8010350b:	5f                   	pop    %edi
8010350c:	5d                   	pop    %ebp
8010350d:	c3                   	ret    
8010350e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103510:	8b 45 10             	mov    0x10(%ebp),%eax
80103513:	85 c0                	test   %eax,%eax
80103515:	7e 69                	jle    80103580 <piperead+0x100>
    if(p->nread == p->nwrite)
80103517:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010351d:	31 c9                	xor    %ecx,%ecx
8010351f:	eb 15                	jmp    80103536 <piperead+0xb6>
80103521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103528:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010352e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103534:	74 5a                	je     80103590 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103536:	8d 70 01             	lea    0x1(%eax),%esi
80103539:	25 ff 01 00 00       	and    $0x1ff,%eax
8010353e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103544:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103549:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010354c:	83 c1 01             	add    $0x1,%ecx
8010354f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103552:	75 d4                	jne    80103528 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103554:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010355a:	83 ec 0c             	sub    $0xc,%esp
8010355d:	50                   	push   %eax
8010355e:	e8 dd 0d 00 00       	call   80104340 <wakeup>
  release(&p->lock);
80103563:	89 1c 24             	mov    %ebx,(%esp)
80103566:	e8 95 14 00 00       	call   80104a00 <release>
  return i;
8010356b:	8b 45 10             	mov    0x10(%ebp),%eax
8010356e:	83 c4 10             	add    $0x10,%esp
}
80103571:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103574:	5b                   	pop    %ebx
80103575:	5e                   	pop    %esi
80103576:	5f                   	pop    %edi
80103577:	5d                   	pop    %ebp
80103578:	c3                   	ret    
80103579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103580:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103587:	eb cb                	jmp    80103554 <piperead+0xd4>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103590:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103593:	eb bf                	jmp    80103554 <piperead+0xd4>
80103595:	66 90                	xchg   %ax,%ax
80103597:	66 90                	xchg   %ax,%ax
80103599:	66 90                	xchg   %ax,%ax
8010359b:	66 90                	xchg   %ax,%ax
8010359d:	66 90                	xchg   %ax,%ax
8010359f:	90                   	nop

801035a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801035a0:	55                   	push   %ebp
801035a1:	89 e5                	mov    %esp,%ebp
801035a3:	56                   	push   %esi
801035a4:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035a5:	bb d4 47 11 80       	mov    $0x801147d4,%ebx
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801035aa:	83 ec 0c             	sub    $0xc,%esp
801035ad:	68 a0 47 11 80       	push   $0x801147a0
801035b2:	e8 99 13 00 00       	call   80104950 <acquire>
801035b7:	83 c4 10             	add    $0x10,%esp
801035ba:	eb 16                	jmp    801035d2 <allocproc+0x32>
801035bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801035c0:	81 c3 ac 00 00 00    	add    $0xac,%ebx
801035c6:	81 fb d4 72 11 80    	cmp    $0x801172d4,%ebx
801035cc:	0f 84 ce 00 00 00    	je     801036a0 <allocproc+0x100>
    if(p->state == UNUSED)
801035d2:	8b 43 0c             	mov    0xc(%ebx),%eax
801035d5:	85 c0                	test   %eax,%eax
801035d7:	75 e7                	jne    801035c0 <allocproc+0x20>
  #if LOTTERY
    p->tickets = 10;
  #endif

  p->state = EMBRYO;
  p->pid = nextpid++;
801035d9:	a1 04 b0 10 80       	mov    0x8010b004,%eax

int
curr_time(void){
  uint time;

  acquire(&tickslock);
801035de:	83 ec 0c             	sub    $0xc,%esp

  #if LOTTERY
    p->tickets = 10;
  #endif

  p->state = EMBRYO;
801035e1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)

int
curr_time(void){
  uint time;

  acquire(&tickslock);
801035e8:	68 e0 72 11 80       	push   $0x801172e0

  p->state = EMBRYO;
  p->pid = nextpid++;

  #if PRIORITY
    p->priority = 1;
801035ed:	c7 83 a8 00 00 00 01 	movl   $0x1,0xa8(%ebx)
801035f4:	00 00 00 
  #if LOTTERY
    p->tickets = 10;
  #endif

  p->state = EMBRYO;
  p->pid = nextpid++;
801035f7:	8d 50 01             	lea    0x1(%eax),%edx
801035fa:	89 43 10             	mov    %eax,0x10(%ebx)
801035fd:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

int
curr_time(void){
  uint time;

  acquire(&tickslock);
80103603:	e8 48 13 00 00       	call   80104950 <acquire>
  time = ticks;
80103608:	8b 35 20 7b 11 80    	mov    0x80117b20,%esi
  release(&tickslock);
8010360e:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
80103615:	e8 e6 13 00 00       	call   80104a00 <release>
  #if PRIORITY
    p->priority = 1;
    p->init_time = curr_time();
  #endif

  release(&ptable.lock);
8010361a:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
  p->state = EMBRYO;
  p->pid = nextpid++;

  #if PRIORITY
    p->priority = 1;
    p->init_time = curr_time();
80103621:	89 b3 a4 00 00 00    	mov    %esi,0xa4(%ebx)
  #endif

  release(&ptable.lock);
80103627:	e8 d4 13 00 00       	call   80104a00 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010362c:	e8 4f ee ff ff       	call   80102480 <kalloc>
80103631:	83 c4 10             	add    $0x10,%esp
80103634:	85 c0                	test   %eax,%eax
80103636:	89 43 08             	mov    %eax,0x8(%ebx)
80103639:	74 7e                	je     801036b9 <allocproc+0x119>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010363b:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103641:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103644:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103649:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010364c:	c7 40 14 cf 5d 10 80 	movl   $0x80105dcf,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103653:	6a 14                	push   $0x14
80103655:	6a 00                	push   $0x0
80103657:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103658:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010365b:	e8 f0 13 00 00       	call   80104a50 <memset>
  p->context->eip = (uint)forkret;
80103660:	8b 43 1c             	mov    0x1c(%ebx),%eax
  p->ctime = ticks;
	p->stime = 0;
	p->retime = 0;
	p->rutime = 0;

  return p;
80103663:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103666:	c7 40 10 d0 36 10 80 	movl   $0x801036d0,0x10(%eax)

  p->ctime = ticks;
8010366d:	a1 20 7b 11 80       	mov    0x80117b20,%eax
	p->stime = 0;
80103672:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103679:	00 00 00 
	p->retime = 0;
8010367c:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103683:	00 00 00 
	p->rutime = 0;
80103686:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
8010368d:	00 00 00 
  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  p->ctime = ticks;
80103690:	89 83 98 00 00 00    	mov    %eax,0x98(%ebx)
	p->stime = 0;
	p->retime = 0;
	p->rutime = 0;

  return p;
80103696:	89 d8                	mov    %ebx,%eax
}
80103698:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010369b:	5b                   	pop    %ebx
8010369c:	5e                   	pop    %esi
8010369d:	5d                   	pop    %ebp
8010369e:	c3                   	ret    
8010369f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	68 a0 47 11 80       	push   $0x801147a0
801036a8:	e8 53 13 00 00       	call   80104a00 <release>
  return 0;
801036ad:	83 c4 10             	add    $0x10,%esp
	p->stime = 0;
	p->retime = 0;
	p->rutime = 0;

  return p;
}
801036b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;
801036b3:	31 c0                	xor    %eax,%eax
	p->stime = 0;
	p->retime = 0;
	p->rutime = 0;

  return p;
}
801036b5:	5b                   	pop    %ebx
801036b6:	5e                   	pop    %esi
801036b7:	5d                   	pop    %ebp
801036b8:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801036b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036c0:	eb d6                	jmp    80103698 <allocproc+0xf8>
801036c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036d6:	68 a0 47 11 80       	push   $0x801147a0
801036db:	e8 20 13 00 00       	call   80104a00 <release>

  if (first) {
801036e0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801036e5:	83 c4 10             	add    $0x10,%esp
801036e8:	85 c0                	test   %eax,%eax
801036ea:	75 04                	jne    801036f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036ec:	c9                   	leave  
801036ed:	c3                   	ret    
801036ee:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801036f0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801036f3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801036fa:	00 00 00 
    iinit(ROOTDEV);
801036fd:	6a 01                	push   $0x1
801036ff:	e8 5c dd ff ff       	call   80101460 <iinit>
    initlog(ROOTDEV);
80103704:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010370b:	e8 90 f3 ff ff       	call   80102aa0 <initlog>
80103710:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103713:	c9                   	leave  
80103714:	c3                   	ret    
80103715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103726:	68 d5 7b 10 80       	push   $0x80107bd5
8010372b:	68 a0 47 11 80       	push   $0x801147a0
80103730:	e8 bb 10 00 00       	call   801047f0 <initlock>
}
80103735:	83 c4 10             	add    $0x10,%esp
80103738:	c9                   	leave  
80103739:	c3                   	ret    
8010373a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103740 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	56                   	push   %esi
80103744:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103745:	9c                   	pushf  
80103746:	58                   	pop    %eax
  int apicid, i;

  if(readeflags()&FL_IF)
80103747:	f6 c4 02             	test   $0x2,%ah
8010374a:	75 5b                	jne    801037a7 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
8010374c:	e8 8f ef ff ff       	call   801026e0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103751:	8b 35 80 47 11 80    	mov    0x80114780,%esi
80103757:	85 f6                	test   %esi,%esi
80103759:	7e 3f                	jle    8010379a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010375b:	0f b6 15 e0 41 11 80 	movzbl 0x801141e0,%edx
80103762:	39 d0                	cmp    %edx,%eax
80103764:	74 30                	je     80103796 <mycpu+0x56>
80103766:	b9 94 42 11 80       	mov    $0x80114294,%ecx
8010376b:	31 d2                	xor    %edx,%edx
8010376d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103770:	83 c2 01             	add    $0x1,%edx
80103773:	39 f2                	cmp    %esi,%edx
80103775:	74 23                	je     8010379a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103777:	0f b6 19             	movzbl (%ecx),%ebx
8010377a:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
80103780:	39 d8                	cmp    %ebx,%eax
80103782:	75 ec                	jne    80103770 <mycpu+0x30>
      return &cpus[i];
80103784:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010378a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010378d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010378e:	05 e0 41 11 80       	add    $0x801141e0,%eax
  }
  panic("unknown apicid\n");
}
80103793:	5e                   	pop    %esi
80103794:	5d                   	pop    %ebp
80103795:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103796:	31 d2                	xor    %edx,%edx
80103798:	eb ea                	jmp    80103784 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010379a:	83 ec 0c             	sub    $0xc,%esp
8010379d:	68 dc 7b 10 80       	push   $0x80107bdc
801037a2:	e8 c9 cb ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;

  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
801037a7:	83 ec 0c             	sub    $0xc,%esp
801037aa:	68 b8 7c 10 80       	push   $0x80107cb8
801037af:	e8 bc cb ff ff       	call   80100370 <panic>
801037b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037c0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037c6:	e8 75 ff ff ff       	call   80103740 <mycpu>
801037cb:	2d e0 41 11 80       	sub    $0x801141e0,%eax
}
801037d0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801037d1:	c1 f8 02             	sar    $0x2,%eax
801037d4:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
801037da:	c3                   	ret    
801037db:	90                   	nop
801037dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037e0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	53                   	push   %ebx
801037e4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801037e7:	e8 84 10 00 00       	call   80104870 <pushcli>
  c = mycpu();
801037ec:	e8 4f ff ff ff       	call   80103740 <mycpu>
  p = c->proc;
801037f1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037f7:	e8 b4 10 00 00       	call   801048b0 <popcli>
  return p;
}
801037fc:	83 c4 04             	add    $0x4,%esp
801037ff:	89 d8                	mov    %ebx,%eax
80103801:	5b                   	pop    %ebx
80103802:	5d                   	pop    %ebp
80103803:	c3                   	ret    
80103804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010380a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103810 <curr_time>:

int proc_quantum = 0;

int
curr_time(void){
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 10             	sub    $0x10,%esp
  uint time;

  acquire(&tickslock);
80103817:	68 e0 72 11 80       	push   $0x801172e0
8010381c:	e8 2f 11 00 00       	call   80104950 <acquire>
  time = ticks;
80103821:	8b 1d 20 7b 11 80    	mov    0x80117b20,%ebx
  release(&tickslock);
80103827:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
8010382e:	e8 cd 11 00 00       	call   80104a00 <release>

  return time;
}
80103833:	89 d8                	mov    %ebx,%eax
80103835:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103838:	c9                   	leave  
80103839:	c3                   	ret    
8010383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103840 <set_max_time>:

int
set_max_time(void){
80103840:	55                   	push   %ebp
  struct proc *p;
  int priority_sum = 0;
  int proc_quantum = 0;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103841:	b8 d4 47 11 80       	mov    $0x801147d4,%eax

  return time;
}

int
set_max_time(void){
80103846:	89 e5                	mov    %esp,%ebp
80103848:	56                   	push   %esi
  struct proc *p;
  int priority_sum = 0;
  int proc_quantum = 0;
80103849:	31 f6                	xor    %esi,%esi

  return time;
}

int
set_max_time(void){
8010384b:	53                   	push   %ebx
  struct proc *p;
  int priority_sum = 0;
8010384c:	31 db                	xor    %ebx,%ebx
8010384e:	66 90                	xchg   %ax,%ax
  int proc_quantum = 0;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid){
80103850:	8b 50 10             	mov    0x10(%eax),%edx
80103853:	85 d2                	test   %edx,%edx
80103855:	74 09                	je     80103860 <set_max_time+0x20>
      proc_quantum = proc_quantum + 1;
      priority_sum = priority_sum + p->priority;
80103857:	03 98 a8 00 00 00    	add    0xa8(%eax),%ebx
  int priority_sum = 0;
  int proc_quantum = 0;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid){
      proc_quantum = proc_quantum + 1;
8010385d:	83 c6 01             	add    $0x1,%esi
set_max_time(void){
  struct proc *p;
  int priority_sum = 0;
  int proc_quantum = 0;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103860:	05 ac 00 00 00       	add    $0xac,%eax
80103865:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
8010386a:	75 e4                	jne    80103850 <set_max_time+0x10>
8010386c:	b9 d4 47 11 80       	mov    $0x801147d4,%ecx
80103871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      priority_sum = priority_sum + p->priority;
    }
  }

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid){
80103878:	8b 41 10             	mov    0x10(%ecx),%eax
8010387b:	85 c0                	test   %eax,%eax
8010387d:	74 13                	je     80103892 <set_max_time+0x52>
      p->max_time = (10000*p->priority)/priority_sum;
8010387f:	69 81 a8 00 00 00 10 	imul   $0x2710,0xa8(%ecx),%eax
80103886:	27 00 00 
80103889:	99                   	cltd   
8010388a:	f7 fb                	idiv   %ebx
8010388c:	89 81 a0 00 00 00    	mov    %eax,0xa0(%ecx)
      proc_quantum = proc_quantum + 1;
      priority_sum = priority_sum + p->priority;
    }
  }

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103892:	81 c1 ac 00 00 00    	add    $0xac,%ecx
80103898:	81 f9 d4 72 11 80    	cmp    $0x801172d4,%ecx
8010389e:	75 d8                	jne    80103878 <set_max_time+0x38>
      p->max_time = (10000*p->priority)/priority_sum;
    }
  }

  return proc_quantum;
}
801038a0:	89 f0                	mov    %esi,%eax
801038a2:	5b                   	pop    %ebx
801038a3:	5e                   	pop    %esi
801038a4:	5d                   	pop    %ebp
801038a5:	c3                   	ret    
801038a6:	8d 76 00             	lea    0x0(%esi),%esi
801038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038b0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	53                   	push   %ebx
801038b4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801038b7:	e8 e4 fc ff ff       	call   801035a0 <allocproc>
801038bc:	89 c3                	mov    %eax,%ebx

  initproc = p;
801038be:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  if((p->pgdir = setupkvm()) == 0)
801038c3:	e8 08 3b 00 00       	call   801073d0 <setupkvm>
801038c8:	85 c0                	test   %eax,%eax
801038ca:	89 43 04             	mov    %eax,0x4(%ebx)
801038cd:	0f 84 c8 00 00 00    	je     8010399b <userinit+0xeb>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038d3:	83 ec 04             	sub    $0x4,%esp
801038d6:	68 2c 00 00 00       	push   $0x2c
801038db:	68 e0 b4 10 80       	push   $0x8010b4e0
801038e0:	50                   	push   %eax
801038e1:	e8 fa 37 00 00       	call   801070e0 <inituvm>
  p->sz = PGSIZE;
801038e6:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  p->ctime = ticks;
801038ec:	a1 20 7b 11 80       	mov    0x80117b20,%eax
  memset(p->tf, 0, sizeof(*p->tf));
801038f1:	83 c4 0c             	add    $0xc,%esp
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  p->ctime = ticks;
801038f4:	89 83 98 00 00 00    	mov    %eax,0x98(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038fa:	6a 4c                	push   $0x4c
801038fc:	6a 00                	push   $0x0
801038fe:	ff 73 18             	pushl  0x18(%ebx)
80103901:	e8 4a 11 00 00       	call   80104a50 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103906:	8b 43 18             	mov    0x18(%ebx),%eax
80103909:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010390e:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103913:	83 c4 0c             	add    $0xc,%esp
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  p->ctime = ticks;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103916:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010391a:	8b 43 18             	mov    0x18(%ebx),%eax
8010391d:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103921:	8b 43 18             	mov    0x18(%ebx),%eax
80103924:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103928:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010392c:	8b 43 18             	mov    0x18(%ebx),%eax
8010392f:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103933:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103937:	8b 43 18             	mov    0x18(%ebx),%eax
8010393a:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103941:	8b 43 18             	mov    0x18(%ebx),%eax
80103944:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010394b:	8b 43 18             	mov    0x18(%ebx),%eax
8010394e:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103955:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103958:	6a 10                	push   $0x10
8010395a:	68 05 7c 10 80       	push   $0x80107c05
8010395f:	50                   	push   %eax
80103960:	e8 eb 12 00 00       	call   80104c50 <safestrcpy>
  p->cwd = namei("/");
80103965:	c7 04 24 0e 7c 10 80 	movl   $0x80107c0e,(%esp)
8010396c:	e8 3f e5 ff ff       	call   80101eb0 <namei>
80103971:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103974:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
8010397b:	e8 d0 0f 00 00       	call   80104950 <acquire>

  p->state = RUNNABLE;
80103980:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103987:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
8010398e:	e8 6d 10 00 00       	call   80104a00 <release>
}
80103993:	83 c4 10             	add    $0x10,%esp
80103996:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103999:	c9                   	leave  
8010399a:	c3                   	ret    

  p = allocproc();

  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
8010399b:	83 ec 0c             	sub    $0xc,%esp
8010399e:	68 ec 7b 10 80       	push   $0x80107bec
801039a3:	e8 c8 c9 ff ff       	call   80100370 <panic>
801039a8:	90                   	nop
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039b0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	56                   	push   %esi
801039b4:	53                   	push   %ebx
801039b5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801039b8:	e8 b3 0e 00 00       	call   80104870 <pushcli>
  c = mycpu();
801039bd:	e8 7e fd ff ff       	call   80103740 <mycpu>
  p = c->proc;
801039c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039c8:	e8 e3 0e 00 00       	call   801048b0 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
801039cd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
801039d0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039d2:	7e 34                	jle    80103a08 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801039d4:	83 ec 04             	sub    $0x4,%esp
801039d7:	01 c6                	add    %eax,%esi
801039d9:	56                   	push   %esi
801039da:	50                   	push   %eax
801039db:	ff 73 04             	pushl  0x4(%ebx)
801039de:	e8 3d 38 00 00       	call   80107220 <allocuvm>
801039e3:	83 c4 10             	add    $0x10,%esp
801039e6:	85 c0                	test   %eax,%eax
801039e8:	74 36                	je     80103a20 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
801039ea:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801039ed:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039ef:	53                   	push   %ebx
801039f0:	e8 db 35 00 00       	call   80106fd0 <switchuvm>
  return 0;
801039f5:	83 c4 10             	add    $0x10,%esp
801039f8:	31 c0                	xor    %eax,%eax
}
801039fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039fd:	5b                   	pop    %ebx
801039fe:	5e                   	pop    %esi
801039ff:	5d                   	pop    %ebp
80103a00:	c3                   	ret    
80103a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103a08:	74 e0                	je     801039ea <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a0a:	83 ec 04             	sub    $0x4,%esp
80103a0d:	01 c6                	add    %eax,%esi
80103a0f:	56                   	push   %esi
80103a10:	50                   	push   %eax
80103a11:	ff 73 04             	pushl  0x4(%ebx)
80103a14:	e8 07 39 00 00       	call   80107320 <deallocuvm>
80103a19:	83 c4 10             	add    $0x10,%esp
80103a1c:	85 c0                	test   %eax,%eax
80103a1e:	75 ca                	jne    801039ea <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a25:	eb d3                	jmp    801039fa <growproc+0x4a>
80103a27:	89 f6                	mov    %esi,%esi
80103a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a30 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	57                   	push   %edi
80103a34:	56                   	push   %esi
80103a35:	53                   	push   %ebx
80103a36:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a39:	e8 32 0e 00 00       	call   80104870 <pushcli>
  c = mycpu();
80103a3e:	e8 fd fc ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103a43:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a49:	e8 62 0e 00 00       	call   801048b0 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103a4e:	e8 4d fb ff ff       	call   801035a0 <allocproc>
80103a53:	85 c0                	test   %eax,%eax
80103a55:	89 c7                	mov    %eax,%edi
80103a57:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a5a:	0f 84 bd 00 00 00    	je     80103b1d <fork+0xed>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a60:	83 ec 08             	sub    $0x8,%esp
80103a63:	ff 33                	pushl  (%ebx)
80103a65:	ff 73 04             	pushl  0x4(%ebx)
80103a68:	e8 33 3a 00 00       	call   801074a0 <copyuvm>
80103a6d:	83 c4 10             	add    $0x10,%esp
80103a70:	85 c0                	test   %eax,%eax
80103a72:	89 47 04             	mov    %eax,0x4(%edi)
80103a75:	0f 84 a9 00 00 00    	je     80103b24 <fork+0xf4>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103a7b:	8b 03                	mov    (%ebx),%eax
80103a7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->parent = curproc;
  *np->tf = *curproc->tf;
80103a80:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103a85:	89 02                	mov    %eax,(%edx)
  np->parent = curproc;
80103a87:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
80103a8a:	8b 7a 18             	mov    0x18(%edx),%edi
80103a8d:	8b 73 18             	mov    0x18(%ebx),%esi
80103a90:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->traceflag = curproc->traceflag;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a92:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Copy trace flag
  np->traceflag = curproc->traceflag;
80103a94:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a97:	89 42 7c             	mov    %eax,0x7c(%edx)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103a9a:	8b 42 18             	mov    0x18(%edx),%eax
80103a9d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103aa8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103aac:	85 c0                	test   %eax,%eax
80103aae:	74 13                	je     80103ac3 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ab0:	83 ec 0c             	sub    $0xc,%esp
80103ab3:	50                   	push   %eax
80103ab4:	e8 27 d3 ff ff       	call   80100de0 <filedup>
80103ab9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103abc:	83 c4 10             	add    $0x10,%esp
80103abf:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  np->traceflag = curproc->traceflag;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103ac3:	83 c6 01             	add    $0x1,%esi
80103ac6:	83 fe 10             	cmp    $0x10,%esi
80103ac9:	75 dd                	jne    80103aa8 <fork+0x78>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103acb:	83 ec 0c             	sub    $0xc,%esp
80103ace:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ad1:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103ad4:	e8 57 db ff ff       	call   80101630 <idup>
80103ad9:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103adc:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103adf:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ae2:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ae5:	6a 10                	push   $0x10
80103ae7:	53                   	push   %ebx
80103ae8:	50                   	push   %eax
80103ae9:	e8 62 11 00 00       	call   80104c50 <safestrcpy>

  pid = np->pid;
80103aee:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103af1:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
80103af8:	e8 53 0e 00 00       	call   80104950 <acquire>

  np->state = RUNNABLE;
80103afd:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103b04:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
80103b0b:	e8 f0 0e 00 00       	call   80104a00 <release>

  return pid;
80103b10:	83 c4 10             	add    $0x10,%esp
80103b13:	89 d8                	mov    %ebx,%eax
}
80103b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b18:	5b                   	pop    %ebx
80103b19:	5e                   	pop    %esi
80103b1a:	5f                   	pop    %edi
80103b1b:	5d                   	pop    %ebp
80103b1c:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103b1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b22:	eb f1                	jmp    80103b15 <fork+0xe5>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103b24:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b27:	83 ec 0c             	sub    $0xc,%esp
80103b2a:	ff 77 08             	pushl  0x8(%edi)
80103b2d:	e8 9e e7 ff ff       	call   801022d0 <kfree>
    np->kstack = 0;
80103b32:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103b39:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103b40:	83 c4 10             	add    $0x10,%esp
80103b43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b48:	eb cb                	jmp    80103b15 <fork+0xe5>
80103b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b50 <countprocs>:
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

void countprocs(){
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  acquire(&ptable.lock);
80103b56:	68 a0 47 11 80       	push   $0x801147a0
80103b5b:	e8 f0 0d 00 00       	call   80104950 <acquire>
80103b60:	83 c4 10             	add    $0x10,%esp

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b63:	b8 d4 47 11 80       	mov    $0x801147d4,%eax
80103b68:	eb 23                	jmp    80103b8d <countprocs+0x3d>
80103b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      switch (p->state){
80103b70:	83 fa 04             	cmp    $0x4,%edx
80103b73:	74 4b                	je     80103bc0 <countprocs+0x70>
80103b75:	83 fa 02             	cmp    $0x2,%edx
80103b78:	75 07                	jne    80103b81 <countprocs+0x31>
        break;
        case RUNNING:
        p->rutime++;
        break;
        case SLEEPING:
        p->stime++;
80103b7a:	83 80 90 00 00 00 01 	addl   $0x1,0x90(%eax)

void countprocs(){
  struct proc *p;
  acquire(&ptable.lock);

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b81:	05 ac 00 00 00       	add    $0xac,%eax
80103b86:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103b8b:	74 1b                	je     80103ba8 <countprocs+0x58>
      switch (p->state){
80103b8d:	8b 50 0c             	mov    0xc(%eax),%edx
80103b90:	83 fa 03             	cmp    $0x3,%edx
80103b93:	75 db                	jne    80103b70 <countprocs+0x20>
        case RUNNABLE:
        p->retime++;
80103b95:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)

void countprocs(){
  struct proc *p;
  acquire(&ptable.lock);

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b9c:	05 ac 00 00 00       	add    $0xac,%eax
80103ba1:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103ba6:	75 e5                	jne    80103b8d <countprocs+0x3d>
        default:
        ;
      }
    }

  release(&ptable.lock);
80103ba8:	83 ec 0c             	sub    $0xc,%esp
80103bab:	68 a0 47 11 80       	push   $0x801147a0
80103bb0:	e8 4b 0e 00 00       	call   80104a00 <release>
}
80103bb5:	83 c4 10             	add    $0x10,%esp
80103bb8:	c9                   	leave  
80103bb9:	c3                   	ret    
80103bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      switch (p->state){
        case RUNNABLE:
        p->retime++;
        break;
        case RUNNING:
        p->rutime++;
80103bc0:	83 80 94 00 00 00 01 	addl   $0x1,0x94(%eax)
        break;
80103bc7:	eb b8                	jmp    80103b81 <countprocs+0x31>
80103bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bd0 <set_priority>:
  release(&ptable.lock);
}

int
set_priority(int pid, int priority)
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	53                   	push   %ebx
80103bd4:	83 ec 10             	sub    $0x10,%esp
80103bd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  acquire(&ptable.lock);
80103bda:	68 a0 47 11 80       	push   $0x801147a0
80103bdf:	e8 6c 0d 00 00       	call   80104950 <acquire>
80103be4:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103be7:	ba d4 47 11 80       	mov    $0x801147d4,%edx
80103bec:	eb 10                	jmp    80103bfe <set_priority+0x2e>
80103bee:	66 90                	xchg   %ax,%ax
80103bf0:	81 c2 ac 00 00 00    	add    $0xac,%edx
80103bf6:	81 fa d4 72 11 80    	cmp    $0x801172d4,%edx
80103bfc:	74 0e                	je     80103c0c <set_priority+0x3c>
    if(p->pid == pid){
80103bfe:	39 5a 10             	cmp    %ebx,0x10(%edx)
80103c01:	75 ed                	jne    80103bf0 <set_priority+0x20>
	  p->priority = priority;
80103c03:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c06:	89 82 a8 00 00 00    	mov    %eax,0xa8(%edx)
	  break;
	}
  }

  release(&ptable.lock);
80103c0c:	83 ec 0c             	sub    $0xc,%esp
80103c0f:	68 a0 47 11 80       	push   $0x801147a0
80103c14:	e8 e7 0d 00 00       	call   80104a00 <release>

  return pid;
}
80103c19:	89 d8                	mov    %ebx,%eax
80103c1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c1e:	c9                   	leave  
80103c1f:	c3                   	ret    

80103c20 <scheduler>:

void
scheduler(void)
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	57                   	push   %edi
80103c24:	56                   	push   %esi
80103c25:	53                   	push   %ebx
80103c26:	83 ec 1c             	sub    $0x1c,%esp
      }
  #endif

  #if PRIORITY
      struct proc *p, *p1;
      struct cpu *c = mycpu();
80103c29:	e8 12 fb ff ff       	call   80103740 <mycpu>
      c->proc = 0;
80103c2e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c35:	00 00 00 
      }
  #endif

  #if PRIORITY
      struct proc *p, *p1;
      struct cpu *c = mycpu();
80103c38:	89 c3                	mov    %eax,%ebx
80103c3a:	8d 40 04             	lea    0x4(%eax),%eax
80103c3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}

static inline void
sti(void)
{
  asm volatile("sti");
80103c40:	fb                   	sti    
        sti();

        struct proc *highP;

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80103c41:	83 ec 0c             	sub    $0xc,%esp
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c44:	bf d4 47 11 80       	mov    $0x801147d4,%edi
        sti();

        struct proc *highP;

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80103c49:	68 a0 47 11 80       	push   $0x801147a0
80103c4e:	e8 fd 0c 00 00       	call   80104950 <acquire>
        proc_quantum = set_max_time();
80103c53:	e8 e8 fb ff ff       	call   80103840 <set_max_time>
80103c58:	83 c4 10             	add    $0x10,%esp
80103c5b:	a3 38 b6 10 80       	mov    %eax,0x8010b638
80103c60:	eb 24                	jmp    80103c86 <scheduler+0x66>
80103c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          int proc_time = (curr_time()*10) - (p->init_time*10);

          if(p->state != RUNNABLE || proc_time >= p->max_time){
            if(proc_time >= p->max_time){
80103c68:	3b 87 a0 00 00 00    	cmp    0xa0(%edi),%eax
80103c6e:	0f 8d ec 00 00 00    	jge    80103d60 <scheduler+0x140>

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c74:	81 c7 ac 00 00 00    	add    $0xac,%edi
80103c7a:	81 ff d4 72 11 80    	cmp    $0x801172d4,%edi
80103c80:	0f 83 c4 00 00 00    	jae    80103d4a <scheduler+0x12a>

int
curr_time(void){
  uint time;

  acquire(&tickslock);
80103c86:	83 ec 0c             	sub    $0xc,%esp
80103c89:	68 e0 72 11 80       	push   $0x801172e0
80103c8e:	e8 bd 0c 00 00       	call   80104950 <acquire>
  time = ticks;
80103c93:	8b 35 20 7b 11 80    	mov    0x80117b20,%esi
  release(&tickslock);
80103c99:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
80103ca0:	e8 5b 0d 00 00       	call   80104a00 <release>
        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          int proc_time = (curr_time()*10) - (p->init_time*10);
80103ca5:	6b 97 a4 00 00 00 f6 	imul   $0xfffffff6,0xa4(%edi),%edx

          if(p->state != RUNNABLE || proc_time >= p->max_time){
80103cac:	83 c4 10             	add    $0x10,%esp
80103caf:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          int proc_time = (curr_time()*10) - (p->init_time*10);
80103cb3:	8d 04 b6             	lea    (%esi,%esi,4),%eax
80103cb6:	8d 04 42             	lea    (%edx,%eax,2),%eax

          if(p->state != RUNNABLE || proc_time >= p->max_time){
80103cb9:	75 ad                	jne    80103c68 <scheduler+0x48>
80103cbb:	3b 87 a0 00 00 00    	cmp    0xa0(%edi),%eax
80103cc1:	0f 8d 99 00 00 00    	jge    80103d60 <scheduler+0x140>
80103cc7:	b8 d4 47 11 80       	mov    $0x801147d4,%eax
80103ccc:	eb 0e                	jmp    80103cdc <scheduler+0xbc>
80103cce:	66 90                	xchg   %ax,%ax
          continue;
          }

          highP = p;

          for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103cd0:	05 ac 00 00 00       	add    $0xac,%eax
80103cd5:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103cda:	74 21                	je     80103cfd <scheduler+0xdd>
            if(p1->state != RUNNABLE)
80103cdc:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103ce0:	75 ee                	jne    80103cd0 <scheduler+0xb0>
              continue;

            if(p1->priority > highP->priority)
80103ce2:	8b 8f a8 00 00 00    	mov    0xa8(%edi),%ecx
80103ce8:	39 88 a8 00 00 00    	cmp    %ecx,0xa8(%eax)
80103cee:	0f 4f f8             	cmovg  %eax,%edi
          continue;
          }

          highP = p;

          for(p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++){
80103cf1:	05 ac 00 00 00       	add    $0xac,%eax
80103cf6:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103cfb:	75 df                	jne    80103cdc <scheduler+0xbc>
          // Switch to chosen process.  It is the process's job
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          c->proc = p;

          switchuvm(p);
80103cfd:	83 ec 0c             	sub    $0xc,%esp
          p = highP;

          // Switch to chosen process.  It is the process's job
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          c->proc = p;
80103d00:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)

          switchuvm(p);
80103d06:	57                   	push   %edi

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d07:	81 c7 ac 00 00 00    	add    $0xac,%edi
          // Switch to chosen process.  It is the process's job
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          c->proc = p;

          switchuvm(p);
80103d0d:	e8 be 32 00 00       	call   80106fd0 <switchuvm>
          p->state = RUNNING;
80103d12:	c7 87 60 ff ff ff 04 	movl   $0x4,-0xa0(%edi)
80103d19:	00 00 00 

          swtch(&(c->scheduler), p->context);
80103d1c:	58                   	pop    %eax
80103d1d:	5a                   	pop    %edx
80103d1e:	ff b7 70 ff ff ff    	pushl  -0x90(%edi)
80103d24:	ff 75 e4             	pushl  -0x1c(%ebp)
80103d27:	e8 7f 0f 00 00       	call   80104cab <swtch>
          switchkvm();
80103d2c:	e8 7f 32 00 00       	call   80106fb0 <switchkvm>

          // Process is done running for now.
          // It should have changed its p->state before coming back.
          c->proc = 0;
80103d31:	83 c4 10             	add    $0x10,%esp

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d34:	81 ff d4 72 11 80    	cmp    $0x801172d4,%edi
          swtch(&(c->scheduler), p->context);
          switchkvm();

          // Process is done running for now.
          // It should have changed its p->state before coming back.
          c->proc = 0;
80103d3a:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103d41:	00 00 00 

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        proc_quantum = set_max_time();

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d44:	0f 82 3c ff ff ff    	jb     80103c86 <scheduler+0x66>
          // Process is done running for now.
          // It should have changed its p->state before coming back.
          c->proc = 0;
        }

        release(&ptable.lock);
80103d4a:	83 ec 0c             	sub    $0xc,%esp
80103d4d:	68 a0 47 11 80       	push   $0x801147a0
80103d52:	e8 a9 0c 00 00       	call   80104a00 <release>
      }
80103d57:	83 c4 10             	add    $0x10,%esp
80103d5a:	e9 e1 fe ff ff       	jmp    80103c40 <scheduler+0x20>
80103d5f:	90                   	nop

int
curr_time(void){
  uint time;

  acquire(&tickslock);
80103d60:	83 ec 0c             	sub    $0xc,%esp
80103d63:	68 e0 72 11 80       	push   $0x801172e0
80103d68:	e8 e3 0b 00 00       	call   80104950 <acquire>
  time = ticks;
80103d6d:	8b 35 20 7b 11 80    	mov    0x80117b20,%esi
  release(&tickslock);
80103d73:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
80103d7a:	e8 81 0c 00 00       	call   80104a00 <release>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          int proc_time = (curr_time()*10) - (p->init_time*10);

          if(p->state != RUNNABLE || proc_time >= p->max_time){
            if(proc_time >= p->max_time){
              p->total_time =  (curr_time()) - (p->init_time);
80103d7f:	89 f0                	mov    %esi,%eax
80103d81:	2b 87 a4 00 00 00    	sub    0xa4(%edi),%eax
80103d87:	89 87 9c 00 00 00    	mov    %eax,0x9c(%edi)

int
curr_time(void){
  uint time;

  acquire(&tickslock);
80103d8d:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
80103d94:	e8 b7 0b 00 00       	call   80104950 <acquire>
  time = ticks;
80103d99:	8b 35 20 7b 11 80    	mov    0x80117b20,%esi
  release(&tickslock);
80103d9f:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
80103da6:	e8 55 0c 00 00       	call   80104a00 <release>
          int proc_time = (curr_time()*10) - (p->init_time*10);

          if(p->state != RUNNABLE || proc_time >= p->max_time){
            if(proc_time >= p->max_time){
              p->total_time =  (curr_time()) - (p->init_time);
              p->init_time = curr_time();
80103dab:	83 c4 10             	add    $0x10,%esp
80103dae:	89 b7 a4 00 00 00    	mov    %esi,0xa4(%edi)
80103db4:	e9 bb fe ff ff       	jmp    80103c74 <scheduler+0x54>
80103db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103dc0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	56                   	push   %esi
80103dc4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103dc5:	e8 a6 0a 00 00       	call   80104870 <pushcli>
  c = mycpu();
80103dca:	e8 71 f9 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103dcf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dd5:	e8 d6 0a 00 00       	call   801048b0 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	68 a0 47 11 80       	push   $0x801147a0
80103de2:	e8 39 0b 00 00       	call   80104920 <holding>
80103de7:	83 c4 10             	add    $0x10,%esp
80103dea:	85 c0                	test   %eax,%eax
80103dec:	74 56                	je     80103e44 <sched+0x84>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103dee:	e8 4d f9 ff ff       	call   80103740 <mycpu>
80103df3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dfa:	75 6f                	jne    80103e6b <sched+0xab>
    panic("sched locks");
  if(p->state == RUNNING)
80103dfc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e00:	74 5c                	je     80103e5e <sched+0x9e>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e02:	9c                   	pushf  
80103e03:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103e04:	f6 c4 02             	test   $0x2,%ah
80103e07:	75 48                	jne    80103e51 <sched+0x91>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e09:	e8 32 f9 ff ff       	call   80103740 <mycpu>
80103e0e:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  p->counter++;
80103e14:	83 83 80 00 00 00 01 	addl   $0x1,0x80(%ebx)
  swtch(&p->context, mycpu()->scheduler);
80103e1b:	83 c3 1c             	add    $0x1c,%ebx
80103e1e:	e8 1d f9 ff ff       	call   80103740 <mycpu>
80103e23:	83 ec 08             	sub    $0x8,%esp
80103e26:	ff 70 04             	pushl  0x4(%eax)
80103e29:	53                   	push   %ebx
80103e2a:	e8 7c 0e 00 00       	call   80104cab <swtch>
  mycpu()->intena = intena;
80103e2f:	e8 0c f9 ff ff       	call   80103740 <mycpu>
}
80103e34:	83 c4 10             	add    $0x10,%esp
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  p->counter++;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103e37:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e40:	5b                   	pop    %ebx
80103e41:	5e                   	pop    %esi
80103e42:	5d                   	pop    %ebp
80103e43:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103e44:	83 ec 0c             	sub    $0xc,%esp
80103e47:	68 10 7c 10 80       	push   $0x80107c10
80103e4c:	e8 1f c5 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103e51:	83 ec 0c             	sub    $0xc,%esp
80103e54:	68 3c 7c 10 80       	push   $0x80107c3c
80103e59:	e8 12 c5 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103e5e:	83 ec 0c             	sub    $0xc,%esp
80103e61:	68 2e 7c 10 80       	push   $0x80107c2e
80103e66:	e8 05 c5 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103e6b:	83 ec 0c             	sub    $0xc,%esp
80103e6e:	68 22 7c 10 80       	push   $0x80107c22
80103e73:	e8 f8 c4 ff ff       	call   80100370 <panic>
80103e78:	90                   	nop
80103e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e80 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e89:	e8 e2 09 00 00       	call   80104870 <pushcli>
  c = mycpu();
80103e8e:	e8 ad f8 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103e93:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e99:	e8 12 0a 00 00       	call   801048b0 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103e9e:	39 35 3c b6 10 80    	cmp    %esi,0x8010b63c
80103ea4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103ea7:	8d 7e 68             	lea    0x68(%esi),%edi
80103eaa:	0f 84 f1 00 00 00    	je     80103fa1 <exit+0x121>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103eb0:	8b 03                	mov    (%ebx),%eax
80103eb2:	85 c0                	test   %eax,%eax
80103eb4:	74 12                	je     80103ec8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103eb6:	83 ec 0c             	sub    $0xc,%esp
80103eb9:	50                   	push   %eax
80103eba:	e8 71 cf ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103ebf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103ec5:	83 c4 10             	add    $0x10,%esp
80103ec8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103ecb:	39 df                	cmp    %ebx,%edi
80103ecd:	75 e1                	jne    80103eb0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103ecf:	e8 6c ec ff ff       	call   80102b40 <begin_op>
  iput(curproc->cwd);
80103ed4:	83 ec 0c             	sub    $0xc,%esp
80103ed7:	ff 76 68             	pushl  0x68(%esi)
80103eda:	e8 b1 d8 ff ff       	call   80101790 <iput>
  end_op();
80103edf:	e8 cc ec ff ff       	call   80102bb0 <end_op>
  curproc->cwd = 0;
80103ee4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103eeb:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
80103ef2:	e8 59 0a 00 00       	call   80104950 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103ef7:	8b 56 14             	mov    0x14(%esi),%edx
80103efa:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103efd:	b8 d4 47 11 80       	mov    $0x801147d4,%eax
80103f02:	eb 10                	jmp    80103f14 <exit+0x94>
80103f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f08:	05 ac 00 00 00       	add    $0xac,%eax
80103f0d:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103f12:	74 1e                	je     80103f32 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103f14:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f18:	75 ee                	jne    80103f08 <exit+0x88>
80103f1a:	3b 50 20             	cmp    0x20(%eax),%edx
80103f1d:	75 e9                	jne    80103f08 <exit+0x88>
      p->state = RUNNABLE;
80103f1f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f26:	05 ac 00 00 00       	add    $0xac,%eax
80103f2b:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103f30:	75 e2                	jne    80103f14 <exit+0x94>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f32:	8b 0d 3c b6 10 80    	mov    0x8010b63c,%ecx
80103f38:	ba d4 47 11 80       	mov    $0x801147d4,%edx
80103f3d:	eb 0f                	jmp    80103f4e <exit+0xce>
80103f3f:	90                   	nop

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f40:	81 c2 ac 00 00 00    	add    $0xac,%edx
80103f46:	81 fa d4 72 11 80    	cmp    $0x801172d4,%edx
80103f4c:	74 3a                	je     80103f88 <exit+0x108>
    if(p->parent == curproc){
80103f4e:	39 72 14             	cmp    %esi,0x14(%edx)
80103f51:	75 ed                	jne    80103f40 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103f53:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103f57:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f5a:	75 e4                	jne    80103f40 <exit+0xc0>
80103f5c:	b8 d4 47 11 80       	mov    $0x801147d4,%eax
80103f61:	eb 11                	jmp    80103f74 <exit+0xf4>
80103f63:	90                   	nop
80103f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f68:	05 ac 00 00 00       	add    $0xac,%eax
80103f6d:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80103f72:	74 cc                	je     80103f40 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f78:	75 ee                	jne    80103f68 <exit+0xe8>
80103f7a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f7d:	75 e9                	jne    80103f68 <exit+0xe8>
      p->state = RUNNABLE;
80103f7f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f86:	eb e0                	jmp    80103f68 <exit+0xe8>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103f88:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103f8f:	e8 2c fe ff ff       	call   80103dc0 <sched>
  panic("zombie exit");
80103f94:	83 ec 0c             	sub    $0xc,%esp
80103f97:	68 5d 7c 10 80       	push   $0x80107c5d
80103f9c:	e8 cf c3 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103fa1:	83 ec 0c             	sub    $0xc,%esp
80103fa4:	68 50 7c 10 80       	push   $0x80107c50
80103fa9:	e8 c2 c3 ff ff       	call   80100370 <panic>
80103fae:	66 90                	xchg   %ax,%ax

80103fb0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	53                   	push   %ebx
80103fb4:	83 ec 04             	sub    $0x4,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103fb7:	e8 b4 08 00 00       	call   80104870 <pushcli>
  c = mycpu();
80103fbc:	e8 7f f7 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103fc1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fc7:	e8 e4 08 00 00       	call   801048b0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  struct proc *p = myproc();
  acquire(&ptable.lock);  //DOC: yieldlock
80103fcc:	83 ec 0c             	sub    $0xc,%esp
80103fcf:	68 a0 47 11 80       	push   $0x801147a0
80103fd4:	e8 77 09 00 00       	call   80104950 <acquire>

  p->timeslice--;
80103fd9:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  if(!p->timeslice) {
80103fdf:	83 c4 10             	add    $0x10,%esp
yield(void)
{
  struct proc *p = myproc();
  acquire(&ptable.lock);  //DOC: yieldlock

  p->timeslice--;
80103fe2:	83 e8 01             	sub    $0x1,%eax
  if(!p->timeslice) {
80103fe5:	85 c0                	test   %eax,%eax
yield(void)
{
  struct proc *p = myproc();
  acquire(&ptable.lock);  //DOC: yieldlock

  p->timeslice--;
80103fe7:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
  if(!p->timeslice) {
80103fed:	75 0c                	jne    80103ffb <yield+0x4b>
    p->state = RUNNABLE;
80103fef:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    sched();
80103ff6:	e8 c5 fd ff ff       	call   80103dc0 <sched>
   }

  release(&ptable.lock);
80103ffb:	83 ec 0c             	sub    $0xc,%esp
80103ffe:	68 a0 47 11 80       	push   $0x801147a0
80104003:	e8 f8 09 00 00       	call   80104a00 <release>
}
80104008:	83 c4 10             	add    $0x10,%esp
8010400b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010400e:	c9                   	leave  
8010400f:	c3                   	ret    

80104010 <sys_yield>:

int
sys_yield(void)
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	83 ec 08             	sub    $0x8,%esp
  yield();
80104016:	e8 95 ff ff ff       	call   80103fb0 <yield>

  return 0;
}
8010401b:	31 c0                	xor    %eax,%eax
8010401d:	c9                   	leave  
8010401e:	c3                   	ret    
8010401f:	90                   	nop

80104020 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	57                   	push   %edi
80104024:	56                   	push   %esi
80104025:	53                   	push   %ebx
80104026:	83 ec 0c             	sub    $0xc,%esp
80104029:	8b 7d 08             	mov    0x8(%ebp),%edi
8010402c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
8010402f:	e8 3c 08 00 00       	call   80104870 <pushcli>
  c = mycpu();
80104034:	e8 07 f7 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80104039:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010403f:	e8 6c 08 00 00       	call   801048b0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if(p == 0)
80104044:	85 db                	test   %ebx,%ebx
80104046:	0f 84 87 00 00 00    	je     801040d3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
8010404c:	85 f6                	test   %esi,%esi
8010404e:	74 76                	je     801040c6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104050:	81 fe a0 47 11 80    	cmp    $0x801147a0,%esi
80104056:	74 50                	je     801040a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104058:	83 ec 0c             	sub    $0xc,%esp
8010405b:	68 a0 47 11 80       	push   $0x801147a0
80104060:	e8 eb 08 00 00       	call   80104950 <acquire>
    release(lk);
80104065:	89 34 24             	mov    %esi,(%esp)
80104068:	e8 93 09 00 00       	call   80104a00 <release>
  }
  // Go to sleep.
  p->chan = chan;
8010406d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104070:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104077:	e8 44 fd ff ff       	call   80103dc0 <sched>

  // Tidy up.
  p->chan = 0;
8010407c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104083:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
8010408a:	e8 71 09 00 00       	call   80104a00 <release>
    acquire(lk);
8010408f:	89 75 08             	mov    %esi,0x8(%ebp)
80104092:	83 c4 10             	add    $0x10,%esp
  }
}
80104095:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104098:	5b                   	pop    %ebx
80104099:	5e                   	pop    %esi
8010409a:	5f                   	pop    %edi
8010409b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
8010409c:	e9 af 08 00 00       	jmp    80104950 <acquire>
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
801040a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801040b2:	e8 09 fd ff ff       	call   80103dc0 <sched>

  // Tidy up.
  p->chan = 0;
801040b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
801040be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040c1:	5b                   	pop    %ebx
801040c2:	5e                   	pop    %esi
801040c3:	5f                   	pop    %edi
801040c4:	5d                   	pop    %ebp
801040c5:	c3                   	ret    

  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
801040c6:	83 ec 0c             	sub    $0xc,%esp
801040c9:	68 6f 7c 10 80       	push   $0x80107c6f
801040ce:	e8 9d c2 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if(p == 0)
    panic("sleep");
801040d3:	83 ec 0c             	sub    $0xc,%esp
801040d6:	68 69 7c 10 80       	push   $0x80107c69
801040db:	e8 90 c2 ff ff       	call   80100370 <panic>

801040e0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
801040e4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801040e5:	e8 86 07 00 00       	call   80104870 <pushcli>
  c = mycpu();
801040ea:	e8 51 f6 ff ff       	call   80103740 <mycpu>
  p = c->proc;
801040ef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040f5:	e8 b6 07 00 00       	call   801048b0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
801040fa:	83 ec 0c             	sub    $0xc,%esp
801040fd:	68 a0 47 11 80       	push   $0x801147a0
80104102:	e8 49 08 00 00       	call   80104950 <acquire>
80104107:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010410a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010410c:	bb d4 47 11 80       	mov    $0x801147d4,%ebx
80104111:	eb 13                	jmp    80104126 <wait+0x46>
80104113:	90                   	nop
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104118:	81 c3 ac 00 00 00    	add    $0xac,%ebx
8010411e:	81 fb d4 72 11 80    	cmp    $0x801172d4,%ebx
80104124:	74 22                	je     80104148 <wait+0x68>
      if(p->parent != curproc)
80104126:	39 73 14             	cmp    %esi,0x14(%ebx)
80104129:	75 ed                	jne    80104118 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
8010412b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010412f:	74 35                	je     80104166 <wait+0x86>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104131:	81 c3 ac 00 00 00    	add    $0xac,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104137:	b8 01 00 00 00       	mov    $0x1,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010413c:	81 fb d4 72 11 80    	cmp    $0x801172d4,%ebx
80104142:	75 e2                	jne    80104126 <wait+0x46>
80104144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104148:	85 c0                	test   %eax,%eax
8010414a:	74 7a                	je     801041c6 <wait+0xe6>
8010414c:	8b 46 24             	mov    0x24(%esi),%eax
8010414f:	85 c0                	test   %eax,%eax
80104151:	75 73                	jne    801041c6 <wait+0xe6>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104153:	83 ec 08             	sub    $0x8,%esp
80104156:	68 a0 47 11 80       	push   $0x801147a0
8010415b:	56                   	push   %esi
8010415c:	e8 bf fe ff ff       	call   80104020 <sleep>
  }
80104161:	83 c4 10             	add    $0x10,%esp
80104164:	eb a4                	jmp    8010410a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80104166:	83 ec 0c             	sub    $0xc,%esp
80104169:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
8010416c:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
8010416f:	e8 5c e1 ff ff       	call   801022d0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104174:	5a                   	pop    %edx
80104175:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104178:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
8010417f:	e8 cc 31 00 00       	call   80107350 <freevm>
        p->pid = 0;
80104184:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010418b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104192:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104196:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->ctime = 0;
8010419d:	c7 83 98 00 00 00 00 	movl   $0x0,0x98(%ebx)
801041a4:	00 00 00 
        p->state = UNUSED;
801041a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801041ae:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
801041b5:	e8 46 08 00 00       	call   80104a00 <release>
        return pid;
801041ba:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->name[0] = 0;
        p->killed = 0;
        p->ctime = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
801041c0:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041c2:	5b                   	pop    %ebx
801041c3:	5e                   	pop    %esi
801041c4:	5d                   	pop    %ebp
801041c5:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
801041c6:	83 ec 0c             	sub    $0xc,%esp
801041c9:	68 a0 47 11 80       	push   $0x801147a0
801041ce:	e8 2d 08 00 00       	call   80104a00 <release>
      return -1;
801041d3:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
801041d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
801041de:	5b                   	pop    %ebx
801041df:	5e                   	pop    %esi
801041e0:	5d                   	pop    %ebp
801041e1:	c3                   	ret    
801041e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041f0 <wait2>:
//  - eventually that process transfers control
//      via swtch back to the scheduler.

int
wait2(int *retime, int *rutime, int *stime) //recebe o ponteiro de 3 variaveis
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	56                   	push   %esi
801041f4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801041f5:	e8 76 06 00 00       	call   80104870 <pushcli>
  c = mycpu();
801041fa:	e8 41 f5 ff ff       	call   80103740 <mycpu>
  p = c->proc;
801041ff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104205:	e8 a6 06 00 00       	call   801048b0 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
8010420a:	83 ec 0c             	sub    $0xc,%esp
8010420d:	68 a0 47 11 80       	push   $0x801147a0
80104212:	e8 39 07 00 00       	call   80104950 <acquire>
80104217:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
8010421a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010421c:	bb d4 47 11 80       	mov    $0x801147d4,%ebx
80104221:	eb 13                	jmp    80104236 <wait2+0x46>
80104223:	90                   	nop
80104224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104228:	81 c3 ac 00 00 00    	add    $0xac,%ebx
8010422e:	81 fb d4 72 11 80    	cmp    $0x801172d4,%ebx
80104234:	74 22                	je     80104258 <wait2+0x68>
      if(p->parent != curproc)
80104236:	39 73 14             	cmp    %esi,0x14(%ebx)
80104239:	75 ed                	jne    80104228 <wait2+0x38>
        continue;

      havekids = 1;
      if(p->state == ZOMBIE){
8010423b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010423f:	74 3d                	je     8010427e <wait2+0x8e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104241:	81 c3 ac 00 00 00    	add    $0xac,%ebx
      if(p->parent != curproc)
        continue;

      havekids = 1;
80104247:	b8 01 00 00 00       	mov    $0x1,%eax

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010424c:	81 fb d4 72 11 80    	cmp    $0x801172d4,%ebx
80104252:	75 e2                	jne    80104236 <wait2+0x46>
80104254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&ptable.lock);
        return pid;
      }
    }
    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104258:	85 c0                	test   %eax,%eax
8010425a:	0f 84 bd 00 00 00    	je     8010431d <wait2+0x12d>
80104260:	8b 46 24             	mov    0x24(%esi),%eax
80104263:	85 c0                	test   %eax,%eax
80104265:	0f 85 b2 00 00 00    	jne    8010431d <wait2+0x12d>
      release(&ptable.lock);
      return -1;
    }
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010426b:	83 ec 08             	sub    $0x8,%esp
8010426e:	68 a0 47 11 80       	push   $0x801147a0
80104273:	56                   	push   %esi
80104274:	e8 a7 fd ff ff       	call   80104020 <sleep>
  }
80104279:	83 c4 10             	add    $0x10,%esp
8010427c:	eb 9c                	jmp    8010421a <wait2+0x2a>
      if(p->parent != curproc)
        continue;

      havekids = 1;
      if(p->state == ZOMBIE){
        *retime = p->retime;
8010427e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80104284:	8b 45 08             	mov    0x8(%ebp),%eax
        *rutime = p->rutime;
        *stime = p->stime; // seta o valor dar 3 variaveis

        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80104287:	83 ec 0c             	sub    $0xc,%esp
      if(p->parent != curproc)
        continue;

      havekids = 1;
      if(p->state == ZOMBIE){
        *retime = p->retime;
8010428a:	89 10                	mov    %edx,(%eax)
        *rutime = p->rutime;
8010428c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010428f:	8b 93 94 00 00 00    	mov    0x94(%ebx),%edx
80104295:	89 10                	mov    %edx,(%eax)
        *stime = p->stime; // seta o valor dar 3 variaveis
80104297:	8b 45 10             	mov    0x10(%ebp),%eax
8010429a:	8b 93 90 00 00 00    	mov    0x90(%ebx),%edx
801042a0:	89 10                	mov    %edx,(%eax)

        // Found one.
        pid = p->pid;
        kfree(p->kstack);
801042a2:	ff 73 08             	pushl  0x8(%ebx)
        *retime = p->retime;
        *rutime = p->rutime;
        *stime = p->stime; // seta o valor dar 3 variaveis

        // Found one.
        pid = p->pid;
801042a5:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801042a8:	e8 23 e0 ff ff       	call   801022d0 <kfree>

        p->kstack = 0;
        freevm(p->pgdir);
801042ad:	5a                   	pop    %edx
801042ae:	ff 73 04             	pushl  0x4(%ebx)

        // Found one.
        pid = p->pid;
        kfree(p->kstack);

        p->kstack = 0;
801042b1:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801042b8:	e8 93 30 00 00       	call   80107350 <freevm>

        p->pid = 0;
801042bd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801042c4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801042cb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801042cf:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801042d6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)

        // seta pra 0
        p->ctime = 0;
801042dd:	c7 83 98 00 00 00 00 	movl   $0x0,0x98(%ebx)
801042e4:	00 00 00 
        p->retime = 0;
801042e7:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801042ee:	00 00 00 
        p->rutime = 0;
801042f1:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
801042f8:	00 00 00 
        p->stime = 0;
801042fb:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80104302:	00 00 00 

        release(&ptable.lock);
80104305:	c7 04 24 a0 47 11 80 	movl   $0x801147a0,(%esp)
8010430c:	e8 ef 06 00 00       	call   80104a00 <release>
        return pid;
80104311:	83 c4 10             	add    $0x10,%esp
      return -1;
    }
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104314:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->retime = 0;
        p->rutime = 0;
        p->stime = 0;

        release(&ptable.lock);
        return pid;
80104317:	89 f0                	mov    %esi,%eax
      return -1;
    }
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104319:	5b                   	pop    %ebx
8010431a:	5e                   	pop    %esi
8010431b:	5d                   	pop    %ebp
8010431c:	c3                   	ret    
        return pid;
      }
    }
    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
8010431d:	83 ec 0c             	sub    $0xc,%esp
80104320:	68 a0 47 11 80       	push   $0x801147a0
80104325:	e8 d6 06 00 00       	call   80104a00 <release>
      return -1;
8010432a:	83 c4 10             	add    $0x10,%esp
    }
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010432d:	8d 65 f8             	lea    -0x8(%ebp),%esp
      }
    }
    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104335:	5b                   	pop    %ebx
80104336:	5e                   	pop    %esi
80104337:	5d                   	pop    %ebp
80104338:	c3                   	ret    
80104339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104340 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 10             	sub    $0x10,%esp
80104347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010434a:	68 a0 47 11 80       	push   $0x801147a0
8010434f:	e8 fc 05 00 00       	call   80104950 <acquire>
80104354:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104357:	b8 d4 47 11 80       	mov    $0x801147d4,%eax
8010435c:	eb 0e                	jmp    8010436c <wakeup+0x2c>
8010435e:	66 90                	xchg   %ax,%ax
80104360:	05 ac 00 00 00       	add    $0xac,%eax
80104365:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
8010436a:	74 1e                	je     8010438a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010436c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104370:	75 ee                	jne    80104360 <wakeup+0x20>
80104372:	3b 58 20             	cmp    0x20(%eax),%ebx
80104375:	75 e9                	jne    80104360 <wakeup+0x20>
      p->state = RUNNABLE;
80104377:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010437e:	05 ac 00 00 00       	add    $0xac,%eax
80104383:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
80104388:	75 e2                	jne    8010436c <wakeup+0x2c>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
8010438a:	c7 45 08 a0 47 11 80 	movl   $0x801147a0,0x8(%ebp)
}
80104391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104394:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104395:	e9 66 06 00 00       	jmp    80104a00 <release>
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 10             	sub    $0x10,%esp
801043a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801043aa:	68 a0 47 11 80       	push   $0x801147a0
801043af:	e8 9c 05 00 00       	call   80104950 <acquire>
801043b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043b7:	b8 d4 47 11 80       	mov    $0x801147d4,%eax
801043bc:	eb 0e                	jmp    801043cc <kill+0x2c>
801043be:	66 90                	xchg   %ax,%ax
801043c0:	05 ac 00 00 00       	add    $0xac,%eax
801043c5:	3d d4 72 11 80       	cmp    $0x801172d4,%eax
801043ca:	74 3c                	je     80104408 <kill+0x68>
    if(p->pid == pid){
801043cc:	39 58 10             	cmp    %ebx,0x10(%eax)
801043cf:	75 ef                	jne    801043c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801043d1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
801043d5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801043dc:	74 1a                	je     801043f8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801043de:	83 ec 0c             	sub    $0xc,%esp
801043e1:	68 a0 47 11 80       	push   $0x801147a0
801043e6:	e8 15 06 00 00       	call   80104a00 <release>
      return 0;
801043eb:	83 c4 10             	add    $0x10,%esp
801043ee:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801043f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043f3:	c9                   	leave  
801043f4:	c3                   	ret    
801043f5:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801043f8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801043ff:	eb dd                	jmp    801043de <kill+0x3e>
80104401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	68 a0 47 11 80       	push   $0x801147a0
80104410:	e8 eb 05 00 00       	call   80104a00 <release>
  return -1;
80104415:	83 c4 10             	add    $0x10,%esp
80104418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010441d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104420:	c9                   	leave  
80104421:	c3                   	ret    
80104422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104430 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	57                   	push   %edi
80104434:	56                   	push   %esi
80104435:	53                   	push   %ebx
80104436:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104439:	bb 40 48 11 80       	mov    $0x80114840,%ebx
8010443e:	83 ec 3c             	sub    $0x3c,%esp
80104441:	eb 27                	jmp    8010446a <procdump+0x3a>
80104443:	90                   	nop
80104444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104448:	83 ec 0c             	sub    $0xc,%esp
8010444b:	68 ab 80 10 80       	push   $0x801080ab
80104450:	e8 0b c2 ff ff       	call   80100660 <cprintf>
80104455:	83 c4 10             	add    $0x10,%esp
80104458:	81 c3 ac 00 00 00    	add    $0xac,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010445e:	81 fb 40 73 11 80    	cmp    $0x80117340,%ebx
80104464:	0f 84 7e 00 00 00    	je     801044e8 <procdump+0xb8>
    if(p->state == UNUSED)
8010446a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010446d:	85 c0                	test   %eax,%eax
8010446f:	74 e7                	je     80104458 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104471:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104474:	ba 80 7c 10 80       	mov    $0x80107c80,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104479:	77 11                	ja     8010448c <procdump+0x5c>
8010447b:	8b 14 85 e0 7c 10 80 	mov    -0x7fef8320(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
80104482:	b8 80 7c 10 80       	mov    $0x80107c80,%eax
80104487:	85 d2                	test   %edx,%edx
80104489:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010448c:	53                   	push   %ebx
8010448d:	52                   	push   %edx
8010448e:	ff 73 a4             	pushl  -0x5c(%ebx)
80104491:	68 84 7c 10 80       	push   $0x80107c84
80104496:	e8 c5 c1 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010449b:	83 c4 10             	add    $0x10,%esp
8010449e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801044a2:	75 a4                	jne    80104448 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044a4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801044a7:	83 ec 08             	sub    $0x8,%esp
801044aa:	8d 7d c0             	lea    -0x40(%ebp),%edi
801044ad:	50                   	push   %eax
801044ae:	8b 43 b0             	mov    -0x50(%ebx),%eax
801044b1:	8b 40 0c             	mov    0xc(%eax),%eax
801044b4:	83 c0 08             	add    $0x8,%eax
801044b7:	50                   	push   %eax
801044b8:	e8 53 03 00 00       	call   80104810 <getcallerpcs>
801044bd:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801044c0:	8b 17                	mov    (%edi),%edx
801044c2:	85 d2                	test   %edx,%edx
801044c4:	74 82                	je     80104448 <procdump+0x18>
        cprintf(" %p", pc[i]);
801044c6:	83 ec 08             	sub    $0x8,%esp
801044c9:	83 c7 04             	add    $0x4,%edi
801044cc:	52                   	push   %edx
801044cd:	68 c1 76 10 80       	push   $0x801076c1
801044d2:	e8 89 c1 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801044d7:	83 c4 10             	add    $0x10,%esp
801044da:	39 f7                	cmp    %esi,%edi
801044dc:	75 e2                	jne    801044c0 <procdump+0x90>
801044de:	e9 65 ff ff ff       	jmp    80104448 <procdump+0x18>
801044e3:	90                   	nop
801044e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801044e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044eb:	5b                   	pop    %ebx
801044ec:	5e                   	pop    %esi
801044ed:	5f                   	pop    %edi
801044ee:	5d                   	pop    %ebp
801044ef:	c3                   	ret    

801044f0 <sgenrand>:
static int mti=N+1; /* mti==N+1 means mt[N] is not initialized */

/* initializing the array with a NONZERO seed */
void
sgenrand(unsigned long seed)
{
801044f0:	55                   	push   %ebp
801044f1:	b8 44 b6 10 80       	mov    $0x8010b644,%eax
801044f6:	89 e5                	mov    %esp,%ebp
801044f8:	8b 55 08             	mov    0x8(%ebp),%edx
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
801044fb:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
80104501:	eb 08                	jmp    8010450b <sgenrand+0x1b>
80104503:	90                   	nop
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104508:	83 c0 04             	add    $0x4,%eax
    for (mti=1; mti<N; mti++)
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
8010450b:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
    for (mti=1; mti<N; mti++)
80104511:	3d fc bf 10 80       	cmp    $0x8010bffc,%eax
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
80104516:	89 10                	mov    %edx,(%eax)
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
    for (mti=1; mti<N; mti++)
80104518:	75 ee                	jne    80104508 <sgenrand+0x18>
8010451a:	c7 05 08 b0 10 80 70 	movl   $0x270,0x8010b008
80104521:	02 00 00 
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
}
80104524:	5d                   	pop    %ebp
80104525:	c3                   	ret    
80104526:	8d 76 00             	lea    0x0(%esi),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104530 <genrand>:
{
    unsigned long y;
    static unsigned long mag01[2]={0x0, MATRIX_A};
    /* mag01[x] = x * MATRIX_A  for x=0,1 */

    if (mti >= N) { /* generate N words at one time */
80104530:	a1 08 b0 10 80       	mov    0x8010b008,%eax
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
}

long /* for integer generation */
genrand()
{
80104535:	55                   	push   %ebp
80104536:	89 e5                	mov    %esp,%ebp
80104538:	53                   	push   %ebx
    unsigned long y;
    static unsigned long mag01[2]={0x0, MATRIX_A};
    /* mag01[x] = x * MATRIX_A  for x=0,1 */

    if (mti >= N) { /* generate N words at one time */
80104539:	3d 6f 02 00 00       	cmp    $0x26f,%eax
8010453e:	0f 8e f2 00 00 00    	jle    80104636 <genrand+0x106>
        int kk;

        if (mti == N+1)   /* if sgenrand() has not been called, */
80104544:	3d 71 02 00 00       	cmp    $0x271,%eax
80104549:	0f 84 f3 00 00 00    	je     80104642 <genrand+0x112>
8010454f:	b9 40 b6 10 80       	mov    $0x8010b640,%ecx
80104554:	ba cc b9 10 80       	mov    $0x8010b9cc,%edx
80104559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            sgenrand(4357); /* a default initial seed is used   */

        for (kk=0;kk<N-M;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
80104560:	8b 19                	mov    (%ecx),%ebx
80104562:	8b 41 04             	mov    0x4(%ecx),%eax
80104565:	83 c1 04             	add    $0x4,%ecx
80104568:	81 e3 00 00 00 80    	and    $0x80000000,%ebx
8010456e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
80104573:	09 d8                	or     %ebx,%eax
            mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
80104575:	89 c3                	mov    %eax,%ebx
80104577:	83 e0 01             	and    $0x1,%eax
8010457a:	d1 eb                	shr    %ebx
8010457c:	33 99 30 06 00 00    	xor    0x630(%ecx),%ebx
80104582:	33 1c 85 f8 7c 10 80 	xor    -0x7fef8308(,%eax,4),%ebx
80104589:	89 59 fc             	mov    %ebx,-0x4(%ecx)
        int kk;

        if (mti == N+1)   /* if sgenrand() has not been called, */
            sgenrand(4357); /* a default initial seed is used   */

        for (kk=0;kk<N-M;kk++) {
8010458c:	39 ca                	cmp    %ecx,%edx
8010458e:	75 d0                	jne    80104560 <genrand+0x30>
80104590:	b9 fc bf 10 80       	mov    $0x8010bffc,%ecx
80104595:	8d 76 00             	lea    0x0(%esi),%esi
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
            mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
        }
        for (;kk<N-1;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
80104598:	8b 1a                	mov    (%edx),%ebx
8010459a:	8b 42 04             	mov    0x4(%edx),%eax
8010459d:	83 c2 04             	add    $0x4,%edx
801045a0:	81 e3 00 00 00 80    	and    $0x80000000,%ebx
801045a6:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
801045ab:	09 d8                	or     %ebx,%eax
            mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1];
801045ad:	89 c3                	mov    %eax,%ebx
801045af:	83 e0 01             	and    $0x1,%eax
801045b2:	d1 eb                	shr    %ebx
801045b4:	33 9a 70 fc ff ff    	xor    -0x390(%edx),%ebx
801045ba:	33 1c 85 f8 7c 10 80 	xor    -0x7fef8308(,%eax,4),%ebx
801045c1:	89 5a fc             	mov    %ebx,-0x4(%edx)

        for (kk=0;kk<N-M;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
            mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
        }
        for (;kk<N-1;kk++) {
801045c4:	39 d1                	cmp    %edx,%ecx
801045c6:	75 d0                	jne    80104598 <genrand+0x68>
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
            mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1];
        }
        y = (mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK);
801045c8:	a1 40 b6 10 80       	mov    0x8010b640,%eax
801045cd:	8b 0d fc bf 10 80    	mov    0x8010bffc,%ecx
801045d3:	89 c2                	mov    %eax,%edx
801045d5:	81 e1 00 00 00 80    	and    $0x80000000,%ecx
801045db:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
801045e1:	09 ca                	or     %ecx,%edx
        mt[N-1] = mt[M-1] ^ (y >> 1) ^ mag01[y & 0x1];
801045e3:	89 d1                	mov    %edx,%ecx
801045e5:	83 e2 01             	and    $0x1,%edx
801045e8:	d1 e9                	shr    %ecx
801045ea:	33 0d 70 bc 10 80    	xor    0x8010bc70,%ecx
801045f0:	33 0c 95 f8 7c 10 80 	xor    -0x7fef8308(,%edx,4),%ecx
801045f7:	ba 01 00 00 00       	mov    $0x1,%edx
801045fc:	89 0d fc bf 10 80    	mov    %ecx,0x8010bffc

        mti = 0;
    }

    y = mt[mti++];
80104602:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
    y ^= TEMPERING_SHIFT_U(y);
80104608:	89 c2                	mov    %eax,%edx
8010460a:	c1 ea 0b             	shr    $0xb,%edx
8010460d:	31 c2                	xor    %eax,%edx
    y ^= TEMPERING_SHIFT_S(y) & TEMPERING_MASK_B;
8010460f:	89 d0                	mov    %edx,%eax
80104611:	c1 e0 07             	shl    $0x7,%eax
80104614:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
80104619:	31 c2                	xor    %eax,%edx
    y ^= TEMPERING_SHIFT_T(y) & TEMPERING_MASK_C;
8010461b:	89 d0                	mov    %edx,%eax
8010461d:	c1 e0 0f             	shl    $0xf,%eax
80104620:	25 00 00 c6 ef       	and    $0xefc60000,%eax
80104625:	31 d0                	xor    %edx,%eax
    y ^= TEMPERING_SHIFT_L(y);
80104627:	89 c2                	mov    %eax,%edx
80104629:	c1 ea 12             	shr    $0x12,%edx

    // Strip off uppermost bit because we want a long,
    // not an unsigned long
    return y & RAND_MAX;
8010462c:	31 d0                	xor    %edx,%eax
8010462e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
80104633:	5b                   	pop    %ebx
80104634:	5d                   	pop    %ebp
80104635:	c3                   	ret    
80104636:	8d 50 01             	lea    0x1(%eax),%edx
80104639:	8b 04 85 40 b6 10 80 	mov    -0x7fef49c0(,%eax,4),%eax
80104640:	eb c0                	jmp    80104602 <genrand+0xd2>
{
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
80104642:	c7 05 40 b6 10 80 05 	movl   $0x1105,0x8010b640
80104649:	11 00 00 
8010464c:	b8 44 b6 10 80       	mov    $0x8010b644,%eax
80104651:	b9 fc bf 10 80       	mov    $0x8010bffc,%ecx
80104656:	ba 05 11 00 00       	mov    $0x1105,%edx
8010465b:	eb 06                	jmp    80104663 <genrand+0x133>
8010465d:	8d 76 00             	lea    0x0(%esi),%esi
80104660:	83 c0 04             	add    $0x4,%eax
    for (mti=1; mti<N; mti++)
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
80104663:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
    for (mti=1; mti<N; mti++)
80104669:	39 c1                	cmp    %eax,%ecx
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
8010466b:	89 10                	mov    %edx,(%eax)
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
    for (mti=1; mti<N; mti++)
8010466d:	75 f1                	jne    80104660 <genrand+0x130>
8010466f:	e9 db fe ff ff       	jmp    8010454f <genrand+0x1f>
80104674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010467a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104680 <random_at_most>:
    return y & RAND_MAX;
}

// Assumes 0 <= max <= RAND_MAX
// Returns in the half-open interval [0, max]
long random_at_most(long max) {
80104680:	55                   	push   %ebp
  unsigned long
    // max <= RAND_MAX < ULONG_MAX, so this is okay.
    num_bins = (unsigned long) max + 1,
    num_rand = (unsigned long) RAND_MAX + 1,
    bin_size = num_rand / num_bins,
80104681:	31 d2                	xor    %edx,%edx
    return y & RAND_MAX;
}

// Assumes 0 <= max <= RAND_MAX
// Returns in the half-open interval [0, max]
long random_at_most(long max) {
80104683:	89 e5                	mov    %esp,%ebp
80104685:	56                   	push   %esi
80104686:	53                   	push   %ebx
  unsigned long
    // max <= RAND_MAX < ULONG_MAX, so this is okay.
    num_bins = (unsigned long) max + 1,
80104687:	8b 45 08             	mov    0x8(%ebp),%eax
    num_rand = (unsigned long) RAND_MAX + 1,
    bin_size = num_rand / num_bins,
8010468a:	bb 00 00 00 80       	mov    $0x80000000,%ebx
// Assumes 0 <= max <= RAND_MAX
// Returns in the half-open interval [0, max]
long random_at_most(long max) {
  unsigned long
    // max <= RAND_MAX < ULONG_MAX, so this is okay.
    num_bins = (unsigned long) max + 1,
8010468f:	8d 48 01             	lea    0x1(%eax),%ecx
    num_rand = (unsigned long) RAND_MAX + 1,
    bin_size = num_rand / num_bins,
80104692:	89 d8                	mov    %ebx,%eax
80104694:	f7 f1                	div    %ecx
80104696:	89 c6                	mov    %eax,%esi
80104698:	29 d3                	sub    %edx,%ebx
8010469a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    defect   = num_rand % num_bins;

  long x;
  do {
   x = genrand();
801046a0:	e8 8b fe ff ff       	call   80104530 <genrand>
  }
  // This is carefully written not to overflow
  while (num_rand - defect <= (unsigned long)x);
801046a5:	39 d8                	cmp    %ebx,%eax
801046a7:	73 f7                	jae    801046a0 <random_at_most+0x20>

  // Truncated division is intentional
  return x/bin_size;
801046a9:	31 d2                	xor    %edx,%edx
801046ab:	f7 f6                	div    %esi
}
801046ad:	5b                   	pop    %ebx
801046ae:	5e                   	pop    %esi
801046af:	5d                   	pop    %ebp
801046b0:	c3                   	ret    
801046b1:	66 90                	xchg   %ax,%ax
801046b3:	66 90                	xchg   %ax,%ax
801046b5:	66 90                	xchg   %ax,%ax
801046b7:	66 90                	xchg   %ax,%ax
801046b9:	66 90                	xchg   %ax,%ax
801046bb:	66 90                	xchg   %ax,%ax
801046bd:	66 90                	xchg   %ax,%ax
801046bf:	90                   	nop

801046c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	53                   	push   %ebx
801046c4:	83 ec 0c             	sub    $0xc,%esp
801046c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801046ca:	68 00 7d 10 80       	push   $0x80107d00
801046cf:	8d 43 04             	lea    0x4(%ebx),%eax
801046d2:	50                   	push   %eax
801046d3:	e8 18 01 00 00       	call   801047f0 <initlock>
  lk->name = name;
801046d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801046db:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801046e1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801046e4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801046eb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801046ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046f1:	c9                   	leave  
801046f2:	c3                   	ret    
801046f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
80104705:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104708:	83 ec 0c             	sub    $0xc,%esp
8010470b:	8d 73 04             	lea    0x4(%ebx),%esi
8010470e:	56                   	push   %esi
8010470f:	e8 3c 02 00 00       	call   80104950 <acquire>
  while (lk->locked) {
80104714:	8b 13                	mov    (%ebx),%edx
80104716:	83 c4 10             	add    $0x10,%esp
80104719:	85 d2                	test   %edx,%edx
8010471b:	74 16                	je     80104733 <acquiresleep+0x33>
8010471d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104720:	83 ec 08             	sub    $0x8,%esp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	e8 f6 f8 ff ff       	call   80104020 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010472a:	8b 03                	mov    (%ebx),%eax
8010472c:	83 c4 10             	add    $0x10,%esp
8010472f:	85 c0                	test   %eax,%eax
80104731:	75 ed                	jne    80104720 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104733:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104739:	e8 a2 f0 ff ff       	call   801037e0 <myproc>
8010473e:	8b 40 10             	mov    0x10(%eax),%eax
80104741:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104744:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104747:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010474a:	5b                   	pop    %ebx
8010474b:	5e                   	pop    %esi
8010474c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010474d:	e9 ae 02 00 00       	jmp    80104a00 <release>
80104752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104760 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104768:	83 ec 0c             	sub    $0xc,%esp
8010476b:	8d 73 04             	lea    0x4(%ebx),%esi
8010476e:	56                   	push   %esi
8010476f:	e8 dc 01 00 00       	call   80104950 <acquire>
  lk->locked = 0;
80104774:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010477a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104781:	89 1c 24             	mov    %ebx,(%esp)
80104784:	e8 b7 fb ff ff       	call   80104340 <wakeup>
  release(&lk->lk);
80104789:	89 75 08             	mov    %esi,0x8(%ebp)
8010478c:	83 c4 10             	add    $0x10,%esp
}
8010478f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104792:	5b                   	pop    %ebx
80104793:	5e                   	pop    %esi
80104794:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104795:	e9 66 02 00 00       	jmp    80104a00 <release>
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	56                   	push   %esi
801047a5:	53                   	push   %ebx
801047a6:	31 ff                	xor    %edi,%edi
801047a8:	83 ec 18             	sub    $0x18,%esp
801047ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801047ae:	8d 73 04             	lea    0x4(%ebx),%esi
801047b1:	56                   	push   %esi
801047b2:	e8 99 01 00 00       	call   80104950 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801047b7:	8b 03                	mov    (%ebx),%eax
801047b9:	83 c4 10             	add    $0x10,%esp
801047bc:	85 c0                	test   %eax,%eax
801047be:	74 13                	je     801047d3 <holdingsleep+0x33>
801047c0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801047c3:	e8 18 f0 ff ff       	call   801037e0 <myproc>
801047c8:	39 58 10             	cmp    %ebx,0x10(%eax)
801047cb:	0f 94 c0             	sete   %al
801047ce:	0f b6 c0             	movzbl %al,%eax
801047d1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801047d3:	83 ec 0c             	sub    $0xc,%esp
801047d6:	56                   	push   %esi
801047d7:	e8 24 02 00 00       	call   80104a00 <release>
  return r;
}
801047dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047df:	89 f8                	mov    %edi,%eax
801047e1:	5b                   	pop    %ebx
801047e2:	5e                   	pop    %esi
801047e3:	5f                   	pop    %edi
801047e4:	5d                   	pop    %ebp
801047e5:	c3                   	ret    
801047e6:	66 90                	xchg   %ax,%ax
801047e8:	66 90                	xchg   %ax,%ax
801047ea:	66 90                	xchg   %ax,%ax
801047ec:	66 90                	xchg   %ax,%ax
801047ee:	66 90                	xchg   %ax,%ax

801047f0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801047f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801047f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801047ff:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104802:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104809:	5d                   	pop    %ebp
8010480a:	c3                   	ret    
8010480b:	90                   	nop
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104814:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104817:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010481a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010481d:	31 c0                	xor    %eax,%eax
8010481f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104820:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104826:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010482c:	77 1a                	ja     80104848 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010482e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104831:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104834:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104837:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104839:	83 f8 0a             	cmp    $0xa,%eax
8010483c:	75 e2                	jne    80104820 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010483e:	5b                   	pop    %ebx
8010483f:	5d                   	pop    %ebp
80104840:	c3                   	ret    
80104841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104848:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010484f:	83 c0 01             	add    $0x1,%eax
80104852:	83 f8 0a             	cmp    $0xa,%eax
80104855:	74 e7                	je     8010483e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104857:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010485e:	83 c0 01             	add    $0x1,%eax
80104861:	83 f8 0a             	cmp    $0xa,%eax
80104864:	75 e2                	jne    80104848 <getcallerpcs+0x38>
80104866:	eb d6                	jmp    8010483e <getcallerpcs+0x2e>
80104868:	90                   	nop
80104869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104870 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	83 ec 04             	sub    $0x4,%esp
80104877:	9c                   	pushf  
80104878:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104879:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010487a:	e8 c1 ee ff ff       	call   80103740 <mycpu>
8010487f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104885:	85 c0                	test   %eax,%eax
80104887:	75 11                	jne    8010489a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104889:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010488f:	e8 ac ee ff ff       	call   80103740 <mycpu>
80104894:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010489a:	e8 a1 ee ff ff       	call   80103740 <mycpu>
8010489f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801048a6:	83 c4 04             	add    $0x4,%esp
801048a9:	5b                   	pop    %ebx
801048aa:	5d                   	pop    %ebp
801048ab:	c3                   	ret    
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048b0 <popcli>:

void
popcli(void)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801048b6:	9c                   	pushf  
801048b7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801048b8:	f6 c4 02             	test   $0x2,%ah
801048bb:	75 52                	jne    8010490f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801048bd:	e8 7e ee ff ff       	call   80103740 <mycpu>
801048c2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801048c8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801048cb:	85 d2                	test   %edx,%edx
801048cd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801048d3:	78 2d                	js     80104902 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801048d5:	e8 66 ee ff ff       	call   80103740 <mycpu>
801048da:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801048e0:	85 d2                	test   %edx,%edx
801048e2:	74 0c                	je     801048f0 <popcli+0x40>
    sti();
}
801048e4:	c9                   	leave  
801048e5:	c3                   	ret    
801048e6:	8d 76 00             	lea    0x0(%esi),%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801048f0:	e8 4b ee ff ff       	call   80103740 <mycpu>
801048f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801048fb:	85 c0                	test   %eax,%eax
801048fd:	74 e5                	je     801048e4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801048ff:	fb                   	sti    
    sti();
}
80104900:	c9                   	leave  
80104901:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80104902:	83 ec 0c             	sub    $0xc,%esp
80104905:	68 22 7d 10 80       	push   $0x80107d22
8010490a:	e8 61 ba ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010490f:	83 ec 0c             	sub    $0xc,%esp
80104912:	68 0b 7d 10 80       	push   $0x80107d0b
80104917:	e8 54 ba ff ff       	call   80100370 <panic>
8010491c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104920 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	56                   	push   %esi
80104924:	53                   	push   %ebx
80104925:	8b 75 08             	mov    0x8(%ebp),%esi
80104928:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
8010492a:	e8 41 ff ff ff       	call   80104870 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010492f:	8b 06                	mov    (%esi),%eax
80104931:	85 c0                	test   %eax,%eax
80104933:	74 10                	je     80104945 <holding+0x25>
80104935:	8b 5e 08             	mov    0x8(%esi),%ebx
80104938:	e8 03 ee ff ff       	call   80103740 <mycpu>
8010493d:	39 c3                	cmp    %eax,%ebx
8010493f:	0f 94 c3             	sete   %bl
80104942:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104945:	e8 66 ff ff ff       	call   801048b0 <popcli>
  return r;
}
8010494a:	89 d8                	mov    %ebx,%eax
8010494c:	5b                   	pop    %ebx
8010494d:	5e                   	pop    %esi
8010494e:	5d                   	pop    %ebp
8010494f:	c3                   	ret    

80104950 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104957:	e8 14 ff ff ff       	call   80104870 <pushcli>
  if(holding(lk))
8010495c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010495f:	83 ec 0c             	sub    $0xc,%esp
80104962:	53                   	push   %ebx
80104963:	e8 b8 ff ff ff       	call   80104920 <holding>
80104968:	83 c4 10             	add    $0x10,%esp
8010496b:	85 c0                	test   %eax,%eax
8010496d:	0f 85 7d 00 00 00    	jne    801049f0 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104973:	ba 01 00 00 00       	mov    $0x1,%edx
80104978:	eb 09                	jmp    80104983 <acquire+0x33>
8010497a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104980:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104983:	89 d0                	mov    %edx,%eax
80104985:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104988:	85 c0                	test   %eax,%eax
8010498a:	75 f4                	jne    80104980 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010498c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104991:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104994:	e8 a7 ed ff ff       	call   80103740 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104999:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010499b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010499e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801049a1:	31 c0                	xor    %eax,%eax
801049a3:	90                   	nop
801049a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801049a8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801049ae:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801049b4:	77 1a                	ja     801049d0 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
801049b6:	8b 5a 04             	mov    0x4(%edx),%ebx
801049b9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801049bc:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801049bf:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801049c1:	83 f8 0a             	cmp    $0xa,%eax
801049c4:	75 e2                	jne    801049a8 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801049c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c9:	c9                   	leave  
801049ca:	c3                   	ret    
801049cb:	90                   	nop
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801049d0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801049d7:	83 c0 01             	add    $0x1,%eax
801049da:	83 f8 0a             	cmp    $0xa,%eax
801049dd:	74 e7                	je     801049c6 <acquire+0x76>
    pcs[i] = 0;
801049df:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801049e6:	83 c0 01             	add    $0x1,%eax
801049e9:	83 f8 0a             	cmp    $0xa,%eax
801049ec:	75 e2                	jne    801049d0 <acquire+0x80>
801049ee:	eb d6                	jmp    801049c6 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801049f0:	83 ec 0c             	sub    $0xc,%esp
801049f3:	68 29 7d 10 80       	push   $0x80107d29
801049f8:	e8 73 b9 ff ff       	call   80100370 <panic>
801049fd:	8d 76 00             	lea    0x0(%esi),%esi

80104a00 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	53                   	push   %ebx
80104a04:	83 ec 10             	sub    $0x10,%esp
80104a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104a0a:	53                   	push   %ebx
80104a0b:	e8 10 ff ff ff       	call   80104920 <holding>
80104a10:	83 c4 10             	add    $0x10,%esp
80104a13:	85 c0                	test   %eax,%eax
80104a15:	74 22                	je     80104a39 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104a17:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104a1e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104a25:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104a2a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104a30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a33:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104a34:	e9 77 fe ff ff       	jmp    801048b0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104a39:	83 ec 0c             	sub    $0xc,%esp
80104a3c:	68 31 7d 10 80       	push   $0x80107d31
80104a41:	e8 2a b9 ff ff       	call   80100370 <panic>
80104a46:	66 90                	xchg   %ax,%ax
80104a48:	66 90                	xchg   %ax,%ax
80104a4a:	66 90                	xchg   %ax,%ax
80104a4c:	66 90                	xchg   %ax,%ax
80104a4e:	66 90                	xchg   %ax,%ax

80104a50 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	53                   	push   %ebx
80104a55:	8b 55 08             	mov    0x8(%ebp),%edx
80104a58:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a5b:	f6 c2 03             	test   $0x3,%dl
80104a5e:	75 05                	jne    80104a65 <memset+0x15>
80104a60:	f6 c1 03             	test   $0x3,%cl
80104a63:	74 13                	je     80104a78 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104a65:	89 d7                	mov    %edx,%edi
80104a67:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a6a:	fc                   	cld    
80104a6b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104a6d:	5b                   	pop    %ebx
80104a6e:	89 d0                	mov    %edx,%eax
80104a70:	5f                   	pop    %edi
80104a71:	5d                   	pop    %ebp
80104a72:	c3                   	ret    
80104a73:	90                   	nop
80104a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104a78:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80104a7c:	c1 e9 02             	shr    $0x2,%ecx
80104a7f:	89 fb                	mov    %edi,%ebx
80104a81:	89 f8                	mov    %edi,%eax
80104a83:	c1 e3 18             	shl    $0x18,%ebx
80104a86:	c1 e0 10             	shl    $0x10,%eax
80104a89:	09 d8                	or     %ebx,%eax
80104a8b:	09 f8                	or     %edi,%eax
80104a8d:	c1 e7 08             	shl    $0x8,%edi
80104a90:	09 f8                	or     %edi,%eax
80104a92:	89 d7                	mov    %edx,%edi
80104a94:	fc                   	cld    
80104a95:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104a97:	5b                   	pop    %ebx
80104a98:	89 d0                	mov    %edx,%eax
80104a9a:	5f                   	pop    %edi
80104a9b:	5d                   	pop    %ebp
80104a9c:	c3                   	ret    
80104a9d:	8d 76 00             	lea    0x0(%esi),%esi

80104aa0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	56                   	push   %esi
80104aa5:	8b 45 10             	mov    0x10(%ebp),%eax
80104aa8:	53                   	push   %ebx
80104aa9:	8b 75 0c             	mov    0xc(%ebp),%esi
80104aac:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104aaf:	85 c0                	test   %eax,%eax
80104ab1:	74 29                	je     80104adc <memcmp+0x3c>
    if(*s1 != *s2)
80104ab3:	0f b6 13             	movzbl (%ebx),%edx
80104ab6:	0f b6 0e             	movzbl (%esi),%ecx
80104ab9:	38 d1                	cmp    %dl,%cl
80104abb:	75 2b                	jne    80104ae8 <memcmp+0x48>
80104abd:	8d 78 ff             	lea    -0x1(%eax),%edi
80104ac0:	31 c0                	xor    %eax,%eax
80104ac2:	eb 14                	jmp    80104ad8 <memcmp+0x38>
80104ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ac8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
80104acd:	83 c0 01             	add    $0x1,%eax
80104ad0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ad4:	38 ca                	cmp    %cl,%dl
80104ad6:	75 10                	jne    80104ae8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104ad8:	39 f8                	cmp    %edi,%eax
80104ada:	75 ec                	jne    80104ac8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104adc:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104add:	31 c0                	xor    %eax,%eax
}
80104adf:	5e                   	pop    %esi
80104ae0:	5f                   	pop    %edi
80104ae1:	5d                   	pop    %ebp
80104ae2:	c3                   	ret    
80104ae3:	90                   	nop
80104ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104ae8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
80104aeb:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104aec:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80104aee:	5e                   	pop    %esi
80104aef:	5f                   	pop    %edi
80104af0:	5d                   	pop    %ebp
80104af1:	c3                   	ret    
80104af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b00 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	56                   	push   %esi
80104b04:	53                   	push   %ebx
80104b05:	8b 45 08             	mov    0x8(%ebp),%eax
80104b08:	8b 75 0c             	mov    0xc(%ebp),%esi
80104b0b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104b0e:	39 c6                	cmp    %eax,%esi
80104b10:	73 2e                	jae    80104b40 <memmove+0x40>
80104b12:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104b15:	39 c8                	cmp    %ecx,%eax
80104b17:	73 27                	jae    80104b40 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104b19:	85 db                	test   %ebx,%ebx
80104b1b:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104b1e:	74 17                	je     80104b37 <memmove+0x37>
      *--d = *--s;
80104b20:	29 d9                	sub    %ebx,%ecx
80104b22:	89 cb                	mov    %ecx,%ebx
80104b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b28:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b2c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104b2f:	83 ea 01             	sub    $0x1,%edx
80104b32:	83 fa ff             	cmp    $0xffffffff,%edx
80104b35:	75 f1                	jne    80104b28 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104b37:	5b                   	pop    %ebx
80104b38:	5e                   	pop    %esi
80104b39:	5d                   	pop    %ebp
80104b3a:	c3                   	ret    
80104b3b:	90                   	nop
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104b40:	31 d2                	xor    %edx,%edx
80104b42:	85 db                	test   %ebx,%ebx
80104b44:	74 f1                	je     80104b37 <memmove+0x37>
80104b46:	8d 76 00             	lea    0x0(%esi),%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104b50:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104b54:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104b57:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104b5a:	39 d3                	cmp    %edx,%ebx
80104b5c:	75 f2                	jne    80104b50 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
80104b5e:	5b                   	pop    %ebx
80104b5f:	5e                   	pop    %esi
80104b60:	5d                   	pop    %ebp
80104b61:	c3                   	ret    
80104b62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104b73:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104b74:	eb 8a                	jmp    80104b00 <memmove>
80104b76:	8d 76 00             	lea    0x0(%esi),%esi
80104b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b80 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	57                   	push   %edi
80104b84:	56                   	push   %esi
80104b85:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b88:	53                   	push   %ebx
80104b89:	8b 7d 08             	mov    0x8(%ebp),%edi
80104b8c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104b8f:	85 c9                	test   %ecx,%ecx
80104b91:	74 37                	je     80104bca <strncmp+0x4a>
80104b93:	0f b6 17             	movzbl (%edi),%edx
80104b96:	0f b6 1e             	movzbl (%esi),%ebx
80104b99:	84 d2                	test   %dl,%dl
80104b9b:	74 3f                	je     80104bdc <strncmp+0x5c>
80104b9d:	38 d3                	cmp    %dl,%bl
80104b9f:	75 3b                	jne    80104bdc <strncmp+0x5c>
80104ba1:	8d 47 01             	lea    0x1(%edi),%eax
80104ba4:	01 cf                	add    %ecx,%edi
80104ba6:	eb 1b                	jmp    80104bc3 <strncmp+0x43>
80104ba8:	90                   	nop
80104ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bb0:	0f b6 10             	movzbl (%eax),%edx
80104bb3:	84 d2                	test   %dl,%dl
80104bb5:	74 21                	je     80104bd8 <strncmp+0x58>
80104bb7:	0f b6 19             	movzbl (%ecx),%ebx
80104bba:	83 c0 01             	add    $0x1,%eax
80104bbd:	89 ce                	mov    %ecx,%esi
80104bbf:	38 da                	cmp    %bl,%dl
80104bc1:	75 19                	jne    80104bdc <strncmp+0x5c>
80104bc3:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104bc5:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104bc8:	75 e6                	jne    80104bb0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104bca:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80104bcb:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80104bcd:	5e                   	pop    %esi
80104bce:	5f                   	pop    %edi
80104bcf:	5d                   	pop    %ebp
80104bd0:	c3                   	ret    
80104bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bd8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104bdc:	0f b6 c2             	movzbl %dl,%eax
80104bdf:	29 d8                	sub    %ebx,%eax
}
80104be1:	5b                   	pop    %ebx
80104be2:	5e                   	pop    %esi
80104be3:	5f                   	pop    %edi
80104be4:	5d                   	pop    %ebp
80104be5:	c3                   	ret    
80104be6:	8d 76 00             	lea    0x0(%esi),%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bf0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
80104bf5:	8b 45 08             	mov    0x8(%ebp),%eax
80104bf8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104bfb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104bfe:	89 c2                	mov    %eax,%edx
80104c00:	eb 19                	jmp    80104c1b <strncpy+0x2b>
80104c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c08:	83 c3 01             	add    $0x1,%ebx
80104c0b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104c0f:	83 c2 01             	add    $0x1,%edx
80104c12:	84 c9                	test   %cl,%cl
80104c14:	88 4a ff             	mov    %cl,-0x1(%edx)
80104c17:	74 09                	je     80104c22 <strncpy+0x32>
80104c19:	89 f1                	mov    %esi,%ecx
80104c1b:	85 c9                	test   %ecx,%ecx
80104c1d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104c20:	7f e6                	jg     80104c08 <strncpy+0x18>
    ;
  while(n-- > 0)
80104c22:	31 c9                	xor    %ecx,%ecx
80104c24:	85 f6                	test   %esi,%esi
80104c26:	7e 17                	jle    80104c3f <strncpy+0x4f>
80104c28:	90                   	nop
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104c30:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104c34:	89 f3                	mov    %esi,%ebx
80104c36:	83 c1 01             	add    $0x1,%ecx
80104c39:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104c3b:	85 db                	test   %ebx,%ebx
80104c3d:	7f f1                	jg     80104c30 <strncpy+0x40>
    *s++ = 0;
  return os;
}
80104c3f:	5b                   	pop    %ebx
80104c40:	5e                   	pop    %esi
80104c41:	5d                   	pop    %ebp
80104c42:	c3                   	ret    
80104c43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c50 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	56                   	push   %esi
80104c54:	53                   	push   %ebx
80104c55:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c58:	8b 45 08             	mov    0x8(%ebp),%eax
80104c5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104c5e:	85 c9                	test   %ecx,%ecx
80104c60:	7e 26                	jle    80104c88 <safestrcpy+0x38>
80104c62:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104c66:	89 c1                	mov    %eax,%ecx
80104c68:	eb 17                	jmp    80104c81 <safestrcpy+0x31>
80104c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104c70:	83 c2 01             	add    $0x1,%edx
80104c73:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104c77:	83 c1 01             	add    $0x1,%ecx
80104c7a:	84 db                	test   %bl,%bl
80104c7c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104c7f:	74 04                	je     80104c85 <safestrcpy+0x35>
80104c81:	39 f2                	cmp    %esi,%edx
80104c83:	75 eb                	jne    80104c70 <safestrcpy+0x20>
    ;
  *s = 0;
80104c85:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104c88:	5b                   	pop    %ebx
80104c89:	5e                   	pop    %esi
80104c8a:	5d                   	pop    %ebp
80104c8b:	c3                   	ret    
80104c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c90 <strlen>:

int
strlen(const char *s)
{
80104c90:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c91:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104c98:	80 3a 00             	cmpb   $0x0,(%edx)
80104c9b:	74 0c                	je     80104ca9 <strlen+0x19>
80104c9d:	8d 76 00             	lea    0x0(%esi),%esi
80104ca0:	83 c0 01             	add    $0x1,%eax
80104ca3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104ca7:	75 f7                	jne    80104ca0 <strlen+0x10>
    ;
  return n;
}
80104ca9:	5d                   	pop    %ebp
80104caa:	c3                   	ret    

80104cab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104cab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104caf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104cb3:	55                   	push   %ebp
  pushl %ebx
80104cb4:	53                   	push   %ebx
  pushl %esi
80104cb5:	56                   	push   %esi
  pushl %edi
80104cb6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104cb7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104cb9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104cbb:	5f                   	pop    %edi
  popl %esi
80104cbc:	5e                   	pop    %esi
  popl %ebx
80104cbd:	5b                   	pop    %ebx
  popl %ebp
80104cbe:	5d                   	pop    %ebp
  ret
80104cbf:	c3                   	ret    

80104cc0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	53                   	push   %ebx
80104cc4:	83 ec 04             	sub    $0x4,%esp
80104cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104cca:	e8 11 eb ff ff       	call   801037e0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ccf:	8b 00                	mov    (%eax),%eax
80104cd1:	39 d8                	cmp    %ebx,%eax
80104cd3:	76 1b                	jbe    80104cf0 <fetchint+0x30>
80104cd5:	8d 53 04             	lea    0x4(%ebx),%edx
80104cd8:	39 d0                	cmp    %edx,%eax
80104cda:	72 14                	jb     80104cf0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cdf:	8b 13                	mov    (%ebx),%edx
80104ce1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ce3:	31 c0                	xor    %eax,%eax
}
80104ce5:	83 c4 04             	add    $0x4,%esp
80104ce8:	5b                   	pop    %ebx
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    
80104ceb:	90                   	nop
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cf5:	eb ee                	jmp    80104ce5 <fetchint+0x25>
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	53                   	push   %ebx
80104d04:	83 ec 04             	sub    $0x4,%esp
80104d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104d0a:	e8 d1 ea ff ff       	call   801037e0 <myproc>

  if(addr >= curproc->sz)
80104d0f:	39 18                	cmp    %ebx,(%eax)
80104d11:	76 29                	jbe    80104d3c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104d13:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104d16:	89 da                	mov    %ebx,%edx
80104d18:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104d1a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104d1c:	39 c3                	cmp    %eax,%ebx
80104d1e:	73 1c                	jae    80104d3c <fetchstr+0x3c>
    if(*s == 0)
80104d20:	80 3b 00             	cmpb   $0x0,(%ebx)
80104d23:	75 10                	jne    80104d35 <fetchstr+0x35>
80104d25:	eb 29                	jmp    80104d50 <fetchstr+0x50>
80104d27:	89 f6                	mov    %esi,%esi
80104d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d30:	80 3a 00             	cmpb   $0x0,(%edx)
80104d33:	74 1b                	je     80104d50 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104d35:	83 c2 01             	add    $0x1,%edx
80104d38:	39 d0                	cmp    %edx,%eax
80104d3a:	77 f4                	ja     80104d30 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104d3c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80104d3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104d44:	5b                   	pop    %ebx
80104d45:	5d                   	pop    %ebp
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d50:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104d53:	89 d0                	mov    %edx,%eax
80104d55:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104d57:	5b                   	pop    %ebx
80104d58:	5d                   	pop    %ebp
80104d59:	c3                   	ret    
80104d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d60 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	56                   	push   %esi
80104d64:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d65:	e8 76 ea ff ff       	call   801037e0 <myproc>
80104d6a:	8b 40 18             	mov    0x18(%eax),%eax
80104d6d:	8b 55 08             	mov    0x8(%ebp),%edx
80104d70:	8b 40 44             	mov    0x44(%eax),%eax
80104d73:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104d76:	e8 65 ea ff ff       	call   801037e0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d7b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d7d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d80:	39 c6                	cmp    %eax,%esi
80104d82:	73 1c                	jae    80104da0 <argint+0x40>
80104d84:	8d 53 08             	lea    0x8(%ebx),%edx
80104d87:	39 d0                	cmp    %edx,%eax
80104d89:	72 15                	jb     80104da0 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80104d8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d8e:	8b 53 04             	mov    0x4(%ebx),%edx
80104d91:	89 10                	mov    %edx,(%eax)
  return 0;
80104d93:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104d95:	5b                   	pop    %ebx
80104d96:	5e                   	pop    %esi
80104d97:	5d                   	pop    %ebp
80104d98:	c3                   	ret    
80104d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da5:	eb ee                	jmp    80104d95 <argint+0x35>
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
80104db5:	83 ec 10             	sub    $0x10,%esp
80104db8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104dbb:	e8 20 ea ff ff       	call   801037e0 <myproc>
80104dc0:	89 c6                	mov    %eax,%esi

  if(argint(n, &i) < 0)
80104dc2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dc5:	83 ec 08             	sub    $0x8,%esp
80104dc8:	50                   	push   %eax
80104dc9:	ff 75 08             	pushl  0x8(%ebp)
80104dcc:	e8 8f ff ff ff       	call   80104d60 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104dd1:	c1 e8 1f             	shr    $0x1f,%eax
80104dd4:	83 c4 10             	add    $0x10,%esp
80104dd7:	84 c0                	test   %al,%al
80104dd9:	75 2d                	jne    80104e08 <argptr+0x58>
80104ddb:	89 d8                	mov    %ebx,%eax
80104ddd:	c1 e8 1f             	shr    $0x1f,%eax
80104de0:	84 c0                	test   %al,%al
80104de2:	75 24                	jne    80104e08 <argptr+0x58>
80104de4:	8b 16                	mov    (%esi),%edx
80104de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104de9:	39 c2                	cmp    %eax,%edx
80104deb:	76 1b                	jbe    80104e08 <argptr+0x58>
80104ded:	01 c3                	add    %eax,%ebx
80104def:	39 da                	cmp    %ebx,%edx
80104df1:	72 15                	jb     80104e08 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104df3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104df6:	89 02                	mov    %eax,(%edx)
  return 0;
80104df8:	31 c0                	xor    %eax,%eax
}
80104dfa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dfd:	5b                   	pop    %ebx
80104dfe:	5e                   	pop    %esi
80104dff:	5d                   	pop    %ebp
80104e00:	c3                   	ret    
80104e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e0d:	eb eb                	jmp    80104dfa <argptr+0x4a>
80104e0f:	90                   	nop

80104e10 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104e16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e19:	50                   	push   %eax
80104e1a:	ff 75 08             	pushl  0x8(%ebp)
80104e1d:	e8 3e ff ff ff       	call   80104d60 <argint>
80104e22:	83 c4 10             	add    $0x10,%esp
80104e25:	85 c0                	test   %eax,%eax
80104e27:	78 17                	js     80104e40 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104e29:	83 ec 08             	sub    $0x8,%esp
80104e2c:	ff 75 0c             	pushl  0xc(%ebp)
80104e2f:	ff 75 f4             	pushl  -0xc(%ebp)
80104e32:	e8 c9 fe ff ff       	call   80104d00 <fetchstr>
80104e37:	83 c4 10             	add    $0x10,%esp
}
80104e3a:	c9                   	leave  
80104e3b:	c3                   	ret    
80104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104e45:	c9                   	leave  
80104e46:	c3                   	ret    
80104e47:	89 f6                	mov    %esi,%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <syscall>:
[SYS_sys_yield]        "sys_yield",
};

void
syscall(void)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	57                   	push   %edi
80104e54:	56                   	push   %esi
80104e55:	53                   	push   %ebx
80104e56:	83 ec 0c             	sub    $0xc,%esp
  int num;
  struct proc *curproc = myproc();
80104e59:	e8 82 e9 ff ff       	call   801037e0 <myproc>

  num = curproc->tf->eax;
80104e5e:	8b 78 18             	mov    0x18(%eax),%edi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104e61:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104e63:	8b 77 1c             	mov    0x1c(%edi),%esi
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e66:	8d 46 ff             	lea    -0x1(%esi),%eax
80104e69:	83 f8 1a             	cmp    $0x1a,%eax
80104e6c:	77 22                	ja     80104e90 <syscall+0x40>
80104e6e:	8b 04 b5 00 7e 10 80 	mov    -0x7fef8200(,%esi,4),%eax
80104e75:	85 c0                	test   %eax,%eax
80104e77:	74 17                	je     80104e90 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104e79:	ff d0                	call   *%eax
80104e7b:	89 47 1c             	mov    %eax,0x1c(%edi)
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }

  // Trace //
  if (curproc->traceflag != 0) {
80104e7e:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104e81:	85 c0                	test   %eax,%eax
80104e83:	75 31                	jne    80104eb6 <syscall+0x66>
        curproc->pid,
        curproc->name,
        num,
        syscallnames[num]);
  }
}
80104e85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e88:	5b                   	pop    %ebx
80104e89:	5e                   	pop    %esi
80104e8a:	5f                   	pop    %edi
80104e8b:	5d                   	pop    %ebp
80104e8c:	c3                   	ret    
80104e8d:	8d 76 00             	lea    0x0(%esi),%esi
  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
80104e90:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104e93:	56                   	push   %esi
80104e94:	50                   	push   %eax
80104e95:	ff 73 10             	pushl  0x10(%ebx)
80104e98:	68 39 7d 10 80       	push   $0x80107d39
80104e9d:	e8 be b7 ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104ea2:	8b 43 18             	mov    0x18(%ebx),%eax
80104ea5:	83 c4 10             	add    $0x10,%esp
80104ea8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }

  // Trace //
  if (curproc->traceflag != 0) {
80104eaf:	8b 43 7c             	mov    0x7c(%ebx),%eax
80104eb2:	85 c0                	test   %eax,%eax
80104eb4:	74 cf                	je     80104e85 <syscall+0x35>
      cprintf("ID: %d NOME: %s NUM_CALL: %d CALL_NAME %s\n",
        curproc->pid,
        curproc->name,
80104eb6:	8d 43 6c             	lea    0x6c(%ebx),%eax
    curproc->tf->eax = -1;
  }

  // Trace //
  if (curproc->traceflag != 0) {
      cprintf("ID: %d NOME: %s NUM_CALL: %d CALL_NAME %s\n",
80104eb9:	83 ec 0c             	sub    $0xc,%esp
80104ebc:	ff 34 b5 20 b0 10 80 	pushl  -0x7fef4fe0(,%esi,4)
80104ec3:	56                   	push   %esi
80104ec4:	50                   	push   %eax
80104ec5:	ff 73 10             	pushl  0x10(%ebx)
80104ec8:	68 d4 7d 10 80       	push   $0x80107dd4
80104ecd:	e8 8e b7 ff ff       	call   80100660 <cprintf>
80104ed2:	83 c4 20             	add    $0x20,%esp
        curproc->pid,
        curproc->name,
        num,
        syscallnames[num]);
  }
}
80104ed5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ed8:	5b                   	pop    %ebx
80104ed9:	5e                   	pop    %esi
80104eda:	5f                   	pop    %edi
80104edb:	5d                   	pop    %ebp
80104edc:	c3                   	ret    
80104edd:	66 90                	xchg   %ax,%ax
80104edf:	90                   	nop

80104ee0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	57                   	push   %edi
80104ee4:	56                   	push   %esi
80104ee5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ee6:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ee9:	83 ec 34             	sub    $0x34,%esp
80104eec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104eef:	8b 4d 08             	mov    0x8(%ebp),%ecx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ef2:	56                   	push   %esi
80104ef3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ef4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104ef7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104efa:	e8 d1 cf ff ff       	call   80101ed0 <nameiparent>
80104eff:	83 c4 10             	add    $0x10,%esp
80104f02:	85 c0                	test   %eax,%eax
80104f04:	0f 84 f6 00 00 00    	je     80105000 <create+0x120>
    return 0;
  ilock(dp);
80104f0a:	83 ec 0c             	sub    $0xc,%esp
80104f0d:	89 c7                	mov    %eax,%edi
80104f0f:	50                   	push   %eax
80104f10:	e8 4b c7 ff ff       	call   80101660 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104f15:	83 c4 0c             	add    $0xc,%esp
80104f18:	6a 00                	push   $0x0
80104f1a:	56                   	push   %esi
80104f1b:	57                   	push   %edi
80104f1c:	e8 6f cc ff ff       	call   80101b90 <dirlookup>
80104f21:	83 c4 10             	add    $0x10,%esp
80104f24:	85 c0                	test   %eax,%eax
80104f26:	89 c3                	mov    %eax,%ebx
80104f28:	74 56                	je     80104f80 <create+0xa0>
    iunlockput(dp);
80104f2a:	83 ec 0c             	sub    $0xc,%esp
80104f2d:	57                   	push   %edi
80104f2e:	e8 bd c9 ff ff       	call   801018f0 <iunlockput>
    ilock(ip);
80104f33:	89 1c 24             	mov    %ebx,(%esp)
80104f36:	e8 25 c7 ff ff       	call   80101660 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104f3b:	83 c4 10             	add    $0x10,%esp
80104f3e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104f43:	75 1b                	jne    80104f60 <create+0x80>
80104f45:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104f4a:	89 d8                	mov    %ebx,%eax
80104f4c:	75 12                	jne    80104f60 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104f4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f51:	5b                   	pop    %ebx
80104f52:	5e                   	pop    %esi
80104f53:	5f                   	pop    %edi
80104f54:	5d                   	pop    %ebp
80104f55:	c3                   	ret    
80104f56:	8d 76 00             	lea    0x0(%esi),%esi
80104f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104f60:	83 ec 0c             	sub    $0xc,%esp
80104f63:	53                   	push   %ebx
80104f64:	e8 87 c9 ff ff       	call   801018f0 <iunlockput>
    return 0;
80104f69:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104f6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104f6f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104f71:	5b                   	pop    %ebx
80104f72:	5e                   	pop    %esi
80104f73:	5f                   	pop    %edi
80104f74:	5d                   	pop    %ebp
80104f75:	c3                   	ret    
80104f76:	8d 76 00             	lea    0x0(%esi),%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104f80:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104f84:	83 ec 08             	sub    $0x8,%esp
80104f87:	50                   	push   %eax
80104f88:	ff 37                	pushl  (%edi)
80104f8a:	e8 61 c5 ff ff       	call   801014f0 <ialloc>
80104f8f:	83 c4 10             	add    $0x10,%esp
80104f92:	85 c0                	test   %eax,%eax
80104f94:	89 c3                	mov    %eax,%ebx
80104f96:	0f 84 cc 00 00 00    	je     80105068 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104f9c:	83 ec 0c             	sub    $0xc,%esp
80104f9f:	50                   	push   %eax
80104fa0:	e8 bb c6 ff ff       	call   80101660 <ilock>
  ip->major = major;
80104fa5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104fa9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104fad:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104fb1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104fb5:	b8 01 00 00 00       	mov    $0x1,%eax
80104fba:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104fbe:	89 1c 24             	mov    %ebx,(%esp)
80104fc1:	e8 ea c5 ff ff       	call   801015b0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104fc6:	83 c4 10             	add    $0x10,%esp
80104fc9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104fce:	74 40                	je     80105010 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104fd0:	83 ec 04             	sub    $0x4,%esp
80104fd3:	ff 73 04             	pushl  0x4(%ebx)
80104fd6:	56                   	push   %esi
80104fd7:	57                   	push   %edi
80104fd8:	e8 13 ce ff ff       	call   80101df0 <dirlink>
80104fdd:	83 c4 10             	add    $0x10,%esp
80104fe0:	85 c0                	test   %eax,%eax
80104fe2:	78 77                	js     8010505b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104fe4:	83 ec 0c             	sub    $0xc,%esp
80104fe7:	57                   	push   %edi
80104fe8:	e8 03 c9 ff ff       	call   801018f0 <iunlockput>

  return ip;
80104fed:	83 c4 10             	add    $0x10,%esp
}
80104ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104ff3:	89 d8                	mov    %ebx,%eax
}
80104ff5:	5b                   	pop    %ebx
80104ff6:	5e                   	pop    %esi
80104ff7:	5f                   	pop    %edi
80104ff8:	5d                   	pop    %ebp
80104ff9:	c3                   	ret    
80104ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80105000:	31 c0                	xor    %eax,%eax
80105002:	e9 47 ff ff ff       	jmp    80104f4e <create+0x6e>
80105007:	89 f6                	mov    %esi,%esi
80105009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80105010:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80105015:	83 ec 0c             	sub    $0xc,%esp
80105018:	57                   	push   %edi
80105019:	e8 92 c5 ff ff       	call   801015b0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010501e:	83 c4 0c             	add    $0xc,%esp
80105021:	ff 73 04             	pushl  0x4(%ebx)
80105024:	68 8c 7e 10 80       	push   $0x80107e8c
80105029:	53                   	push   %ebx
8010502a:	e8 c1 cd ff ff       	call   80101df0 <dirlink>
8010502f:	83 c4 10             	add    $0x10,%esp
80105032:	85 c0                	test   %eax,%eax
80105034:	78 18                	js     8010504e <create+0x16e>
80105036:	83 ec 04             	sub    $0x4,%esp
80105039:	ff 77 04             	pushl  0x4(%edi)
8010503c:	68 8b 7e 10 80       	push   $0x80107e8b
80105041:	53                   	push   %ebx
80105042:	e8 a9 cd ff ff       	call   80101df0 <dirlink>
80105047:	83 c4 10             	add    $0x10,%esp
8010504a:	85 c0                	test   %eax,%eax
8010504c:	79 82                	jns    80104fd0 <create+0xf0>
      panic("create dots");
8010504e:	83 ec 0c             	sub    $0xc,%esp
80105051:	68 7f 7e 10 80       	push   $0x80107e7f
80105056:	e8 15 b3 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
8010505b:	83 ec 0c             	sub    $0xc,%esp
8010505e:	68 8e 7e 10 80       	push   $0x80107e8e
80105063:	e8 08 b3 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80105068:	83 ec 0c             	sub    $0xc,%esp
8010506b:	68 70 7e 10 80       	push   $0x80107e70
80105070:	e8 fb b2 ff ff       	call   80100370 <panic>
80105075:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105080 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
80105085:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105087:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
8010508a:	89 d3                	mov    %edx,%ebx
8010508c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010508f:	50                   	push   %eax
80105090:	6a 00                	push   $0x0
80105092:	e8 c9 fc ff ff       	call   80104d60 <argint>
80105097:	83 c4 10             	add    $0x10,%esp
8010509a:	85 c0                	test   %eax,%eax
8010509c:	78 32                	js     801050d0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010509e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050a2:	77 2c                	ja     801050d0 <argfd.constprop.0+0x50>
801050a4:	e8 37 e7 ff ff       	call   801037e0 <myproc>
801050a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050ac:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801050b0:	85 c0                	test   %eax,%eax
801050b2:	74 1c                	je     801050d0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
801050b4:	85 f6                	test   %esi,%esi
801050b6:	74 02                	je     801050ba <argfd.constprop.0+0x3a>
    *pfd = fd;
801050b8:	89 16                	mov    %edx,(%esi)
  if(pf)
801050ba:	85 db                	test   %ebx,%ebx
801050bc:	74 22                	je     801050e0 <argfd.constprop.0+0x60>
    *pf = f;
801050be:	89 03                	mov    %eax,(%ebx)
  return 0;
801050c0:	31 c0                	xor    %eax,%eax
}
801050c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050c5:	5b                   	pop    %ebx
801050c6:	5e                   	pop    %esi
801050c7:	5d                   	pop    %ebp
801050c8:	c3                   	ret    
801050c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801050d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
801050d8:	5b                   	pop    %ebx
801050d9:	5e                   	pop    %esi
801050da:	5d                   	pop    %ebp
801050db:	c3                   	ret    
801050dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801050e0:	31 c0                	xor    %eax,%eax
801050e2:	eb de                	jmp    801050c2 <argfd.constprop.0+0x42>
801050e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050f0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801050f0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801050f1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
801050f3:	89 e5                	mov    %esp,%ebp
801050f5:	56                   	push   %esi
801050f6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801050f7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
801050fa:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801050fd:	e8 7e ff ff ff       	call   80105080 <argfd.constprop.0>
80105102:	85 c0                	test   %eax,%eax
80105104:	78 1a                	js     80105120 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105106:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80105108:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
8010510b:	e8 d0 e6 ff ff       	call   801037e0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105110:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105114:	85 d2                	test   %edx,%edx
80105116:	74 18                	je     80105130 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105118:	83 c3 01             	add    $0x1,%ebx
8010511b:	83 fb 10             	cmp    $0x10,%ebx
8010511e:	75 f0                	jne    80105110 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80105120:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80105123:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80105128:	5b                   	pop    %ebx
80105129:	5e                   	pop    %esi
8010512a:	5d                   	pop    %ebp
8010512b:	c3                   	ret    
8010512c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105130:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80105134:	83 ec 0c             	sub    $0xc,%esp
80105137:	ff 75 f4             	pushl  -0xc(%ebp)
8010513a:	e8 a1 bc ff ff       	call   80100de0 <filedup>
  return fd;
8010513f:	83 c4 10             	add    $0x10,%esp
}
80105142:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80105145:	89 d8                	mov    %ebx,%eax
}
80105147:	5b                   	pop    %ebx
80105148:	5e                   	pop    %esi
80105149:	5d                   	pop    %ebp
8010514a:	c3                   	ret    
8010514b:	90                   	nop
8010514c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105150 <sys_read>:

int
sys_read(void)
{
80105150:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105151:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80105153:	89 e5                	mov    %esp,%ebp
80105155:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105158:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010515b:	e8 20 ff ff ff       	call   80105080 <argfd.constprop.0>
80105160:	85 c0                	test   %eax,%eax
80105162:	78 4c                	js     801051b0 <sys_read+0x60>
80105164:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105167:	83 ec 08             	sub    $0x8,%esp
8010516a:	50                   	push   %eax
8010516b:	6a 02                	push   $0x2
8010516d:	e8 ee fb ff ff       	call   80104d60 <argint>
80105172:	83 c4 10             	add    $0x10,%esp
80105175:	85 c0                	test   %eax,%eax
80105177:	78 37                	js     801051b0 <sys_read+0x60>
80105179:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010517c:	83 ec 04             	sub    $0x4,%esp
8010517f:	ff 75 f0             	pushl  -0x10(%ebp)
80105182:	50                   	push   %eax
80105183:	6a 01                	push   $0x1
80105185:	e8 26 fc ff ff       	call   80104db0 <argptr>
8010518a:	83 c4 10             	add    $0x10,%esp
8010518d:	85 c0                	test   %eax,%eax
8010518f:	78 1f                	js     801051b0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105191:	83 ec 04             	sub    $0x4,%esp
80105194:	ff 75 f0             	pushl  -0x10(%ebp)
80105197:	ff 75 f4             	pushl  -0xc(%ebp)
8010519a:	ff 75 ec             	pushl  -0x14(%ebp)
8010519d:	e8 ae bd ff ff       	call   80100f50 <fileread>
801051a2:	83 c4 10             	add    $0x10,%esp
}
801051a5:	c9                   	leave  
801051a6:	c3                   	ret    
801051a7:	89 f6                	mov    %esi,%esi
801051a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801051b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
801051b5:	c9                   	leave  
801051b6:	c3                   	ret    
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051c0 <sys_write>:

int
sys_write(void)
{
801051c0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051c1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
801051c3:	89 e5                	mov    %esp,%ebp
801051c5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801051c8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801051cb:	e8 b0 fe ff ff       	call   80105080 <argfd.constprop.0>
801051d0:	85 c0                	test   %eax,%eax
801051d2:	78 4c                	js     80105220 <sys_write+0x60>
801051d4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051d7:	83 ec 08             	sub    $0x8,%esp
801051da:	50                   	push   %eax
801051db:	6a 02                	push   $0x2
801051dd:	e8 7e fb ff ff       	call   80104d60 <argint>
801051e2:	83 c4 10             	add    $0x10,%esp
801051e5:	85 c0                	test   %eax,%eax
801051e7:	78 37                	js     80105220 <sys_write+0x60>
801051e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051ec:	83 ec 04             	sub    $0x4,%esp
801051ef:	ff 75 f0             	pushl  -0x10(%ebp)
801051f2:	50                   	push   %eax
801051f3:	6a 01                	push   $0x1
801051f5:	e8 b6 fb ff ff       	call   80104db0 <argptr>
801051fa:	83 c4 10             	add    $0x10,%esp
801051fd:	85 c0                	test   %eax,%eax
801051ff:	78 1f                	js     80105220 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105201:	83 ec 04             	sub    $0x4,%esp
80105204:	ff 75 f0             	pushl  -0x10(%ebp)
80105207:	ff 75 f4             	pushl  -0xc(%ebp)
8010520a:	ff 75 ec             	pushl  -0x14(%ebp)
8010520d:	e8 ce bd ff ff       	call   80100fe0 <filewrite>
80105212:	83 c4 10             	add    $0x10,%esp
}
80105215:	c9                   	leave  
80105216:	c3                   	ret    
80105217:	89 f6                	mov    %esi,%esi
80105219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80105225:	c9                   	leave  
80105226:	c3                   	ret    
80105227:	89 f6                	mov    %esi,%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105230 <sys_close>:

int
sys_close(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105236:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105239:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010523c:	e8 3f fe ff ff       	call   80105080 <argfd.constprop.0>
80105241:	85 c0                	test   %eax,%eax
80105243:	78 2b                	js     80105270 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105245:	e8 96 e5 ff ff       	call   801037e0 <myproc>
8010524a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010524d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80105250:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105257:	00 
  fileclose(f);
80105258:	ff 75 f4             	pushl  -0xc(%ebp)
8010525b:	e8 d0 bb ff ff       	call   80100e30 <fileclose>
  return 0;
80105260:	83 c4 10             	add    $0x10,%esp
80105263:	31 c0                	xor    %eax,%eax
}
80105265:	c9                   	leave  
80105266:	c3                   	ret    
80105267:	89 f6                	mov    %esi,%esi
80105269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80105270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80105275:	c9                   	leave  
80105276:	c3                   	ret    
80105277:	89 f6                	mov    %esi,%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105280 <sys_fstat>:

int
sys_fstat(void)
{
80105280:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105281:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80105283:	89 e5                	mov    %esp,%ebp
80105285:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105288:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010528b:	e8 f0 fd ff ff       	call   80105080 <argfd.constprop.0>
80105290:	85 c0                	test   %eax,%eax
80105292:	78 2c                	js     801052c0 <sys_fstat+0x40>
80105294:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105297:	83 ec 04             	sub    $0x4,%esp
8010529a:	6a 14                	push   $0x14
8010529c:	50                   	push   %eax
8010529d:	6a 01                	push   $0x1
8010529f:	e8 0c fb ff ff       	call   80104db0 <argptr>
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
801052a9:	78 15                	js     801052c0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
801052ab:	83 ec 08             	sub    $0x8,%esp
801052ae:	ff 75 f4             	pushl  -0xc(%ebp)
801052b1:	ff 75 f0             	pushl  -0x10(%ebp)
801052b4:	e8 47 bc ff ff       	call   80100f00 <filestat>
801052b9:	83 c4 10             	add    $0x10,%esp
}
801052bc:	c9                   	leave  
801052bd:	c3                   	ret    
801052be:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
801052c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
801052c5:	c9                   	leave  
801052c6:	c3                   	ret    
801052c7:	89 f6                	mov    %esi,%esi
801052c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052d0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	57                   	push   %edi
801052d4:	56                   	push   %esi
801052d5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801052d6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801052d9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801052dc:	50                   	push   %eax
801052dd:	6a 00                	push   $0x0
801052df:	e8 2c fb ff ff       	call   80104e10 <argstr>
801052e4:	83 c4 10             	add    $0x10,%esp
801052e7:	85 c0                	test   %eax,%eax
801052e9:	0f 88 fb 00 00 00    	js     801053ea <sys_link+0x11a>
801052ef:	8d 45 d0             	lea    -0x30(%ebp),%eax
801052f2:	83 ec 08             	sub    $0x8,%esp
801052f5:	50                   	push   %eax
801052f6:	6a 01                	push   $0x1
801052f8:	e8 13 fb ff ff       	call   80104e10 <argstr>
801052fd:	83 c4 10             	add    $0x10,%esp
80105300:	85 c0                	test   %eax,%eax
80105302:	0f 88 e2 00 00 00    	js     801053ea <sys_link+0x11a>
    return -1;

  begin_op();
80105308:	e8 33 d8 ff ff       	call   80102b40 <begin_op>
  if((ip = namei(old)) == 0){
8010530d:	83 ec 0c             	sub    $0xc,%esp
80105310:	ff 75 d4             	pushl  -0x2c(%ebp)
80105313:	e8 98 cb ff ff       	call   80101eb0 <namei>
80105318:	83 c4 10             	add    $0x10,%esp
8010531b:	85 c0                	test   %eax,%eax
8010531d:	89 c3                	mov    %eax,%ebx
8010531f:	0f 84 f3 00 00 00    	je     80105418 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80105325:	83 ec 0c             	sub    $0xc,%esp
80105328:	50                   	push   %eax
80105329:	e8 32 c3 ff ff       	call   80101660 <ilock>
  if(ip->type == T_DIR){
8010532e:	83 c4 10             	add    $0x10,%esp
80105331:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105336:	0f 84 c4 00 00 00    	je     80105400 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010533c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105341:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105344:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105347:	53                   	push   %ebx
80105348:	e8 63 c2 ff ff       	call   801015b0 <iupdate>
  iunlock(ip);
8010534d:	89 1c 24             	mov    %ebx,(%esp)
80105350:	e8 eb c3 ff ff       	call   80101740 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105355:	58                   	pop    %eax
80105356:	5a                   	pop    %edx
80105357:	57                   	push   %edi
80105358:	ff 75 d0             	pushl  -0x30(%ebp)
8010535b:	e8 70 cb ff ff       	call   80101ed0 <nameiparent>
80105360:	83 c4 10             	add    $0x10,%esp
80105363:	85 c0                	test   %eax,%eax
80105365:	89 c6                	mov    %eax,%esi
80105367:	74 5b                	je     801053c4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105369:	83 ec 0c             	sub    $0xc,%esp
8010536c:	50                   	push   %eax
8010536d:	e8 ee c2 ff ff       	call   80101660 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105372:	83 c4 10             	add    $0x10,%esp
80105375:	8b 03                	mov    (%ebx),%eax
80105377:	39 06                	cmp    %eax,(%esi)
80105379:	75 3d                	jne    801053b8 <sys_link+0xe8>
8010537b:	83 ec 04             	sub    $0x4,%esp
8010537e:	ff 73 04             	pushl  0x4(%ebx)
80105381:	57                   	push   %edi
80105382:	56                   	push   %esi
80105383:	e8 68 ca ff ff       	call   80101df0 <dirlink>
80105388:	83 c4 10             	add    $0x10,%esp
8010538b:	85 c0                	test   %eax,%eax
8010538d:	78 29                	js     801053b8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010538f:	83 ec 0c             	sub    $0xc,%esp
80105392:	56                   	push   %esi
80105393:	e8 58 c5 ff ff       	call   801018f0 <iunlockput>
  iput(ip);
80105398:	89 1c 24             	mov    %ebx,(%esp)
8010539b:	e8 f0 c3 ff ff       	call   80101790 <iput>

  end_op();
801053a0:	e8 0b d8 ff ff       	call   80102bb0 <end_op>

  return 0;
801053a5:	83 c4 10             	add    $0x10,%esp
801053a8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801053aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053ad:	5b                   	pop    %ebx
801053ae:	5e                   	pop    %esi
801053af:	5f                   	pop    %edi
801053b0:	5d                   	pop    %ebp
801053b1:	c3                   	ret    
801053b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
801053b8:	83 ec 0c             	sub    $0xc,%esp
801053bb:	56                   	push   %esi
801053bc:	e8 2f c5 ff ff       	call   801018f0 <iunlockput>
    goto bad;
801053c1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
801053c4:	83 ec 0c             	sub    $0xc,%esp
801053c7:	53                   	push   %ebx
801053c8:	e8 93 c2 ff ff       	call   80101660 <ilock>
  ip->nlink--;
801053cd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801053d2:	89 1c 24             	mov    %ebx,(%esp)
801053d5:	e8 d6 c1 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
801053da:	89 1c 24             	mov    %ebx,(%esp)
801053dd:	e8 0e c5 ff ff       	call   801018f0 <iunlockput>
  end_op();
801053e2:	e8 c9 d7 ff ff       	call   80102bb0 <end_op>
  return -1;
801053e7:	83 c4 10             	add    $0x10,%esp
}
801053ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801053ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053f2:	5b                   	pop    %ebx
801053f3:	5e                   	pop    %esi
801053f4:	5f                   	pop    %edi
801053f5:	5d                   	pop    %ebp
801053f6:	c3                   	ret    
801053f7:	89 f6                	mov    %esi,%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	53                   	push   %ebx
80105404:	e8 e7 c4 ff ff       	call   801018f0 <iunlockput>
    end_op();
80105409:	e8 a2 d7 ff ff       	call   80102bb0 <end_op>
    return -1;
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105416:	eb 92                	jmp    801053aa <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105418:	e8 93 d7 ff ff       	call   80102bb0 <end_op>
    return -1;
8010541d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105422:	eb 86                	jmp    801053aa <sys_link+0xda>
80105424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010542a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105430 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105436:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105439:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
8010543c:	50                   	push   %eax
8010543d:	6a 00                	push   $0x0
8010543f:	e8 cc f9 ff ff       	call   80104e10 <argstr>
80105444:	83 c4 10             	add    $0x10,%esp
80105447:	85 c0                	test   %eax,%eax
80105449:	0f 88 82 01 00 00    	js     801055d1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010544f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105452:	e8 e9 d6 ff ff       	call   80102b40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105457:	83 ec 08             	sub    $0x8,%esp
8010545a:	53                   	push   %ebx
8010545b:	ff 75 c0             	pushl  -0x40(%ebp)
8010545e:	e8 6d ca ff ff       	call   80101ed0 <nameiparent>
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	85 c0                	test   %eax,%eax
80105468:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010546b:	0f 84 6a 01 00 00    	je     801055db <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105471:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105474:	83 ec 0c             	sub    $0xc,%esp
80105477:	56                   	push   %esi
80105478:	e8 e3 c1 ff ff       	call   80101660 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010547d:	58                   	pop    %eax
8010547e:	5a                   	pop    %edx
8010547f:	68 8c 7e 10 80       	push   $0x80107e8c
80105484:	53                   	push   %ebx
80105485:	e8 e6 c6 ff ff       	call   80101b70 <namecmp>
8010548a:	83 c4 10             	add    $0x10,%esp
8010548d:	85 c0                	test   %eax,%eax
8010548f:	0f 84 fc 00 00 00    	je     80105591 <sys_unlink+0x161>
80105495:	83 ec 08             	sub    $0x8,%esp
80105498:	68 8b 7e 10 80       	push   $0x80107e8b
8010549d:	53                   	push   %ebx
8010549e:	e8 cd c6 ff ff       	call   80101b70 <namecmp>
801054a3:	83 c4 10             	add    $0x10,%esp
801054a6:	85 c0                	test   %eax,%eax
801054a8:	0f 84 e3 00 00 00    	je     80105591 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801054ae:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801054b1:	83 ec 04             	sub    $0x4,%esp
801054b4:	50                   	push   %eax
801054b5:	53                   	push   %ebx
801054b6:	56                   	push   %esi
801054b7:	e8 d4 c6 ff ff       	call   80101b90 <dirlookup>
801054bc:	83 c4 10             	add    $0x10,%esp
801054bf:	85 c0                	test   %eax,%eax
801054c1:	89 c3                	mov    %eax,%ebx
801054c3:	0f 84 c8 00 00 00    	je     80105591 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
801054c9:	83 ec 0c             	sub    $0xc,%esp
801054cc:	50                   	push   %eax
801054cd:	e8 8e c1 ff ff       	call   80101660 <ilock>

  if(ip->nlink < 1)
801054d2:	83 c4 10             	add    $0x10,%esp
801054d5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801054da:	0f 8e 24 01 00 00    	jle    80105604 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801054e0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054e5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801054e8:	74 66                	je     80105550 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801054ea:	83 ec 04             	sub    $0x4,%esp
801054ed:	6a 10                	push   $0x10
801054ef:	6a 00                	push   $0x0
801054f1:	56                   	push   %esi
801054f2:	e8 59 f5 ff ff       	call   80104a50 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054f7:	6a 10                	push   $0x10
801054f9:	ff 75 c4             	pushl  -0x3c(%ebp)
801054fc:	56                   	push   %esi
801054fd:	ff 75 b4             	pushl  -0x4c(%ebp)
80105500:	e8 3b c5 ff ff       	call   80101a40 <writei>
80105505:	83 c4 20             	add    $0x20,%esp
80105508:	83 f8 10             	cmp    $0x10,%eax
8010550b:	0f 85 e6 00 00 00    	jne    801055f7 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105511:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105516:	0f 84 9c 00 00 00    	je     801055b8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010551c:	83 ec 0c             	sub    $0xc,%esp
8010551f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105522:	e8 c9 c3 ff ff       	call   801018f0 <iunlockput>

  ip->nlink--;
80105527:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010552c:	89 1c 24             	mov    %ebx,(%esp)
8010552f:	e8 7c c0 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80105534:	89 1c 24             	mov    %ebx,(%esp)
80105537:	e8 b4 c3 ff ff       	call   801018f0 <iunlockput>

  end_op();
8010553c:	e8 6f d6 ff ff       	call   80102bb0 <end_op>

  return 0;
80105541:	83 c4 10             	add    $0x10,%esp
80105544:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105546:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105549:	5b                   	pop    %ebx
8010554a:	5e                   	pop    %esi
8010554b:	5f                   	pop    %edi
8010554c:	5d                   	pop    %ebp
8010554d:	c3                   	ret    
8010554e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105550:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105554:	76 94                	jbe    801054ea <sys_unlink+0xba>
80105556:	bf 20 00 00 00       	mov    $0x20,%edi
8010555b:	eb 0f                	jmp    8010556c <sys_unlink+0x13c>
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
80105560:	83 c7 10             	add    $0x10,%edi
80105563:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105566:	0f 83 7e ff ff ff    	jae    801054ea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010556c:	6a 10                	push   $0x10
8010556e:	57                   	push   %edi
8010556f:	56                   	push   %esi
80105570:	53                   	push   %ebx
80105571:	e8 ca c3 ff ff       	call   80101940 <readi>
80105576:	83 c4 10             	add    $0x10,%esp
80105579:	83 f8 10             	cmp    $0x10,%eax
8010557c:	75 6c                	jne    801055ea <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010557e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105583:	74 db                	je     80105560 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105585:	83 ec 0c             	sub    $0xc,%esp
80105588:	53                   	push   %ebx
80105589:	e8 62 c3 ff ff       	call   801018f0 <iunlockput>
    goto bad;
8010558e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105591:	83 ec 0c             	sub    $0xc,%esp
80105594:	ff 75 b4             	pushl  -0x4c(%ebp)
80105597:	e8 54 c3 ff ff       	call   801018f0 <iunlockput>
  end_op();
8010559c:	e8 0f d6 ff ff       	call   80102bb0 <end_op>
  return -1;
801055a1:	83 c4 10             	add    $0x10,%esp
}
801055a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801055a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055ac:	5b                   	pop    %ebx
801055ad:	5e                   	pop    %esi
801055ae:	5f                   	pop    %edi
801055af:	5d                   	pop    %ebp
801055b0:	c3                   	ret    
801055b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801055b8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801055bb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801055be:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801055c3:	50                   	push   %eax
801055c4:	e8 e7 bf ff ff       	call   801015b0 <iupdate>
801055c9:	83 c4 10             	add    $0x10,%esp
801055cc:	e9 4b ff ff ff       	jmp    8010551c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
801055d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055d6:	e9 6b ff ff ff       	jmp    80105546 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
801055db:	e8 d0 d5 ff ff       	call   80102bb0 <end_op>
    return -1;
801055e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e5:	e9 5c ff ff ff       	jmp    80105546 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801055ea:	83 ec 0c             	sub    $0xc,%esp
801055ed:	68 b0 7e 10 80       	push   $0x80107eb0
801055f2:	e8 79 ad ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801055f7:	83 ec 0c             	sub    $0xc,%esp
801055fa:	68 c2 7e 10 80       	push   $0x80107ec2
801055ff:	e8 6c ad ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105604:	83 ec 0c             	sub    $0xc,%esp
80105607:	68 9e 7e 10 80       	push   $0x80107e9e
8010560c:	e8 5f ad ff ff       	call   80100370 <panic>
80105611:	eb 0d                	jmp    80105620 <sys_open>
80105613:	90                   	nop
80105614:	90                   	nop
80105615:	90                   	nop
80105616:	90                   	nop
80105617:	90                   	nop
80105618:	90                   	nop
80105619:	90                   	nop
8010561a:	90                   	nop
8010561b:	90                   	nop
8010561c:	90                   	nop
8010561d:	90                   	nop
8010561e:	90                   	nop
8010561f:	90                   	nop

80105620 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	57                   	push   %edi
80105624:	56                   	push   %esi
80105625:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105626:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105629:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010562c:	50                   	push   %eax
8010562d:	6a 00                	push   $0x0
8010562f:	e8 dc f7 ff ff       	call   80104e10 <argstr>
80105634:	83 c4 10             	add    $0x10,%esp
80105637:	85 c0                	test   %eax,%eax
80105639:	0f 88 9e 00 00 00    	js     801056dd <sys_open+0xbd>
8010563f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105642:	83 ec 08             	sub    $0x8,%esp
80105645:	50                   	push   %eax
80105646:	6a 01                	push   $0x1
80105648:	e8 13 f7 ff ff       	call   80104d60 <argint>
8010564d:	83 c4 10             	add    $0x10,%esp
80105650:	85 c0                	test   %eax,%eax
80105652:	0f 88 85 00 00 00    	js     801056dd <sys_open+0xbd>
    return -1;

  begin_op();
80105658:	e8 e3 d4 ff ff       	call   80102b40 <begin_op>

  if(omode & O_CREATE){
8010565d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105661:	0f 85 89 00 00 00    	jne    801056f0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105667:	83 ec 0c             	sub    $0xc,%esp
8010566a:	ff 75 e0             	pushl  -0x20(%ebp)
8010566d:	e8 3e c8 ff ff       	call   80101eb0 <namei>
80105672:	83 c4 10             	add    $0x10,%esp
80105675:	85 c0                	test   %eax,%eax
80105677:	89 c6                	mov    %eax,%esi
80105679:	0f 84 8e 00 00 00    	je     8010570d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010567f:	83 ec 0c             	sub    $0xc,%esp
80105682:	50                   	push   %eax
80105683:	e8 d8 bf ff ff       	call   80101660 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105688:	83 c4 10             	add    $0x10,%esp
8010568b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105690:	0f 84 d2 00 00 00    	je     80105768 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105696:	e8 d5 b6 ff ff       	call   80100d70 <filealloc>
8010569b:	85 c0                	test   %eax,%eax
8010569d:	89 c7                	mov    %eax,%edi
8010569f:	74 2b                	je     801056cc <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056a1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801056a3:	e8 38 e1 ff ff       	call   801037e0 <myproc>
801056a8:	90                   	nop
801056a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801056b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801056b4:	85 d2                	test   %edx,%edx
801056b6:	74 68                	je     80105720 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801056b8:	83 c3 01             	add    $0x1,%ebx
801056bb:	83 fb 10             	cmp    $0x10,%ebx
801056be:	75 f0                	jne    801056b0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	57                   	push   %edi
801056c4:	e8 67 b7 ff ff       	call   80100e30 <fileclose>
801056c9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801056cc:	83 ec 0c             	sub    $0xc,%esp
801056cf:	56                   	push   %esi
801056d0:	e8 1b c2 ff ff       	call   801018f0 <iunlockput>
    end_op();
801056d5:	e8 d6 d4 ff ff       	call   80102bb0 <end_op>
    return -1;
801056da:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801056dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801056e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801056e5:	5b                   	pop    %ebx
801056e6:	5e                   	pop    %esi
801056e7:	5f                   	pop    %edi
801056e8:	5d                   	pop    %ebp
801056e9:	c3                   	ret    
801056ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801056f0:	83 ec 0c             	sub    $0xc,%esp
801056f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801056f6:	31 c9                	xor    %ecx,%ecx
801056f8:	6a 00                	push   $0x0
801056fa:	ba 02 00 00 00       	mov    $0x2,%edx
801056ff:	e8 dc f7 ff ff       	call   80104ee0 <create>
    if(ip == 0){
80105704:	83 c4 10             	add    $0x10,%esp
80105707:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105709:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010570b:	75 89                	jne    80105696 <sys_open+0x76>
      end_op();
8010570d:	e8 9e d4 ff ff       	call   80102bb0 <end_op>
      return -1;
80105712:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105717:	eb 43                	jmp    8010575c <sys_open+0x13c>
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105720:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105723:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105727:	56                   	push   %esi
80105728:	e8 13 c0 ff ff       	call   80101740 <iunlock>
  end_op();
8010572d:	e8 7e d4 ff ff       	call   80102bb0 <end_op>

  f->type = FD_INODE;
80105732:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105738:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010573b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010573e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105741:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105748:	89 d0                	mov    %edx,%eax
8010574a:	83 e0 01             	and    $0x1,%eax
8010574d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105750:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105753:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105756:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010575a:	89 d8                	mov    %ebx,%eax
}
8010575c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010575f:	5b                   	pop    %ebx
80105760:	5e                   	pop    %esi
80105761:	5f                   	pop    %edi
80105762:	5d                   	pop    %ebp
80105763:	c3                   	ret    
80105764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105768:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010576b:	85 c9                	test   %ecx,%ecx
8010576d:	0f 84 23 ff ff ff    	je     80105696 <sys_open+0x76>
80105773:	e9 54 ff ff ff       	jmp    801056cc <sys_open+0xac>
80105778:	90                   	nop
80105779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105780 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105786:	e8 b5 d3 ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010578b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010578e:	83 ec 08             	sub    $0x8,%esp
80105791:	50                   	push   %eax
80105792:	6a 00                	push   $0x0
80105794:	e8 77 f6 ff ff       	call   80104e10 <argstr>
80105799:	83 c4 10             	add    $0x10,%esp
8010579c:	85 c0                	test   %eax,%eax
8010579e:	78 30                	js     801057d0 <sys_mkdir+0x50>
801057a0:	83 ec 0c             	sub    $0xc,%esp
801057a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057a6:	31 c9                	xor    %ecx,%ecx
801057a8:	6a 00                	push   $0x0
801057aa:	ba 01 00 00 00       	mov    $0x1,%edx
801057af:	e8 2c f7 ff ff       	call   80104ee0 <create>
801057b4:	83 c4 10             	add    $0x10,%esp
801057b7:	85 c0                	test   %eax,%eax
801057b9:	74 15                	je     801057d0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057bb:	83 ec 0c             	sub    $0xc,%esp
801057be:	50                   	push   %eax
801057bf:	e8 2c c1 ff ff       	call   801018f0 <iunlockput>
  end_op();
801057c4:	e8 e7 d3 ff ff       	call   80102bb0 <end_op>
  return 0;
801057c9:	83 c4 10             	add    $0x10,%esp
801057cc:	31 c0                	xor    %eax,%eax
}
801057ce:	c9                   	leave  
801057cf:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801057d0:	e8 db d3 ff ff       	call   80102bb0 <end_op>
    return -1;
801057d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801057da:	c9                   	leave  
801057db:	c3                   	ret    
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <sys_mknod>:

int
sys_mknod(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801057e6:	e8 55 d3 ff ff       	call   80102b40 <begin_op>
  if((argstr(0, &path)) < 0 ||
801057eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057ee:	83 ec 08             	sub    $0x8,%esp
801057f1:	50                   	push   %eax
801057f2:	6a 00                	push   $0x0
801057f4:	e8 17 f6 ff ff       	call   80104e10 <argstr>
801057f9:	83 c4 10             	add    $0x10,%esp
801057fc:	85 c0                	test   %eax,%eax
801057fe:	78 60                	js     80105860 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105800:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105803:	83 ec 08             	sub    $0x8,%esp
80105806:	50                   	push   %eax
80105807:	6a 01                	push   $0x1
80105809:	e8 52 f5 ff ff       	call   80104d60 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010580e:	83 c4 10             	add    $0x10,%esp
80105811:	85 c0                	test   %eax,%eax
80105813:	78 4b                	js     80105860 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105815:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105818:	83 ec 08             	sub    $0x8,%esp
8010581b:	50                   	push   %eax
8010581c:	6a 02                	push   $0x2
8010581e:	e8 3d f5 ff ff       	call   80104d60 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105823:	83 c4 10             	add    $0x10,%esp
80105826:	85 c0                	test   %eax,%eax
80105828:	78 36                	js     80105860 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010582a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010582e:	83 ec 0c             	sub    $0xc,%esp
80105831:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105835:	ba 03 00 00 00       	mov    $0x3,%edx
8010583a:	50                   	push   %eax
8010583b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010583e:	e8 9d f6 ff ff       	call   80104ee0 <create>
80105843:	83 c4 10             	add    $0x10,%esp
80105846:	85 c0                	test   %eax,%eax
80105848:	74 16                	je     80105860 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010584a:	83 ec 0c             	sub    $0xc,%esp
8010584d:	50                   	push   %eax
8010584e:	e8 9d c0 ff ff       	call   801018f0 <iunlockput>
  end_op();
80105853:	e8 58 d3 ff ff       	call   80102bb0 <end_op>
  return 0;
80105858:	83 c4 10             	add    $0x10,%esp
8010585b:	31 c0                	xor    %eax,%eax
}
8010585d:	c9                   	leave  
8010585e:	c3                   	ret    
8010585f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105860:	e8 4b d3 ff ff       	call   80102bb0 <end_op>
    return -1;
80105865:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010586a:	c9                   	leave  
8010586b:	c3                   	ret    
8010586c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105870 <sys_chdir>:

int
sys_chdir(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	56                   	push   %esi
80105874:	53                   	push   %ebx
80105875:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105878:	e8 63 df ff ff       	call   801037e0 <myproc>
8010587d:	89 c6                	mov    %eax,%esi

  begin_op();
8010587f:	e8 bc d2 ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105884:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105887:	83 ec 08             	sub    $0x8,%esp
8010588a:	50                   	push   %eax
8010588b:	6a 00                	push   $0x0
8010588d:	e8 7e f5 ff ff       	call   80104e10 <argstr>
80105892:	83 c4 10             	add    $0x10,%esp
80105895:	85 c0                	test   %eax,%eax
80105897:	78 77                	js     80105910 <sys_chdir+0xa0>
80105899:	83 ec 0c             	sub    $0xc,%esp
8010589c:	ff 75 f4             	pushl  -0xc(%ebp)
8010589f:	e8 0c c6 ff ff       	call   80101eb0 <namei>
801058a4:	83 c4 10             	add    $0x10,%esp
801058a7:	85 c0                	test   %eax,%eax
801058a9:	89 c3                	mov    %eax,%ebx
801058ab:	74 63                	je     80105910 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801058ad:	83 ec 0c             	sub    $0xc,%esp
801058b0:	50                   	push   %eax
801058b1:	e8 aa bd ff ff       	call   80101660 <ilock>
  if(ip->type != T_DIR){
801058b6:	83 c4 10             	add    $0x10,%esp
801058b9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058be:	75 30                	jne    801058f0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	53                   	push   %ebx
801058c4:	e8 77 be ff ff       	call   80101740 <iunlock>
  iput(curproc->cwd);
801058c9:	58                   	pop    %eax
801058ca:	ff 76 68             	pushl  0x68(%esi)
801058cd:	e8 be be ff ff       	call   80101790 <iput>
  end_op();
801058d2:	e8 d9 d2 ff ff       	call   80102bb0 <end_op>
  curproc->cwd = ip;
801058d7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801058da:	83 c4 10             	add    $0x10,%esp
801058dd:	31 c0                	xor    %eax,%eax
}
801058df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058e2:	5b                   	pop    %ebx
801058e3:	5e                   	pop    %esi
801058e4:	5d                   	pop    %ebp
801058e5:	c3                   	ret    
801058e6:	8d 76 00             	lea    0x0(%esi),%esi
801058e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801058f0:	83 ec 0c             	sub    $0xc,%esp
801058f3:	53                   	push   %ebx
801058f4:	e8 f7 bf ff ff       	call   801018f0 <iunlockput>
    end_op();
801058f9:	e8 b2 d2 ff ff       	call   80102bb0 <end_op>
    return -1;
801058fe:	83 c4 10             	add    $0x10,%esp
80105901:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105906:	eb d7                	jmp    801058df <sys_chdir+0x6f>
80105908:	90                   	nop
80105909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105910:	e8 9b d2 ff ff       	call   80102bb0 <end_op>
    return -1;
80105915:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010591a:	eb c3                	jmp    801058df <sys_chdir+0x6f>
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105920 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	57                   	push   %edi
80105924:	56                   	push   %esi
80105925:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105926:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010592c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105932:	50                   	push   %eax
80105933:	6a 00                	push   $0x0
80105935:	e8 d6 f4 ff ff       	call   80104e10 <argstr>
8010593a:	83 c4 10             	add    $0x10,%esp
8010593d:	85 c0                	test   %eax,%eax
8010593f:	78 7f                	js     801059c0 <sys_exec+0xa0>
80105941:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105947:	83 ec 08             	sub    $0x8,%esp
8010594a:	50                   	push   %eax
8010594b:	6a 01                	push   $0x1
8010594d:	e8 0e f4 ff ff       	call   80104d60 <argint>
80105952:	83 c4 10             	add    $0x10,%esp
80105955:	85 c0                	test   %eax,%eax
80105957:	78 67                	js     801059c0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105959:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010595f:	83 ec 04             	sub    $0x4,%esp
80105962:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105968:	68 80 00 00 00       	push   $0x80
8010596d:	6a 00                	push   $0x0
8010596f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105975:	50                   	push   %eax
80105976:	31 db                	xor    %ebx,%ebx
80105978:	e8 d3 f0 ff ff       	call   80104a50 <memset>
8010597d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105980:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105986:	83 ec 08             	sub    $0x8,%esp
80105989:	57                   	push   %edi
8010598a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010598d:	50                   	push   %eax
8010598e:	e8 2d f3 ff ff       	call   80104cc0 <fetchint>
80105993:	83 c4 10             	add    $0x10,%esp
80105996:	85 c0                	test   %eax,%eax
80105998:	78 26                	js     801059c0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010599a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801059a0:	85 c0                	test   %eax,%eax
801059a2:	74 2c                	je     801059d0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801059a4:	83 ec 08             	sub    $0x8,%esp
801059a7:	56                   	push   %esi
801059a8:	50                   	push   %eax
801059a9:	e8 52 f3 ff ff       	call   80104d00 <fetchstr>
801059ae:	83 c4 10             	add    $0x10,%esp
801059b1:	85 c0                	test   %eax,%eax
801059b3:	78 0b                	js     801059c0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801059b5:	83 c3 01             	add    $0x1,%ebx
801059b8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801059bb:	83 fb 20             	cmp    $0x20,%ebx
801059be:	75 c0                	jne    80105980 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801059c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801059c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801059c8:	5b                   	pop    %ebx
801059c9:	5e                   	pop    %esi
801059ca:	5f                   	pop    %edi
801059cb:	5d                   	pop    %ebp
801059cc:	c3                   	ret    
801059cd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801059d0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801059d6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801059d9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801059e0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801059e4:	50                   	push   %eax
801059e5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801059eb:	e8 00 b0 ff ff       	call   801009f0 <exec>
801059f0:	83 c4 10             	add    $0x10,%esp
}
801059f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059f6:	5b                   	pop    %ebx
801059f7:	5e                   	pop    %esi
801059f8:	5f                   	pop    %edi
801059f9:	5d                   	pop    %ebp
801059fa:	c3                   	ret    
801059fb:	90                   	nop
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a00 <sys_pipe>:

int
sys_pipe(void)
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	57                   	push   %edi
80105a04:	56                   	push   %esi
80105a05:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a06:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105a09:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a0c:	6a 08                	push   $0x8
80105a0e:	50                   	push   %eax
80105a0f:	6a 00                	push   $0x0
80105a11:	e8 9a f3 ff ff       	call   80104db0 <argptr>
80105a16:	83 c4 10             	add    $0x10,%esp
80105a19:	85 c0                	test   %eax,%eax
80105a1b:	78 4a                	js     80105a67 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105a1d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a20:	83 ec 08             	sub    $0x8,%esp
80105a23:	50                   	push   %eax
80105a24:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a27:	50                   	push   %eax
80105a28:	e8 b3 d7 ff ff       	call   801031e0 <pipealloc>
80105a2d:	83 c4 10             	add    $0x10,%esp
80105a30:	85 c0                	test   %eax,%eax
80105a32:	78 33                	js     80105a67 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105a34:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a36:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105a39:	e8 a2 dd ff ff       	call   801037e0 <myproc>
80105a3e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105a40:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105a44:	85 f6                	test   %esi,%esi
80105a46:	74 30                	je     80105a78 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105a48:	83 c3 01             	add    $0x1,%ebx
80105a4b:	83 fb 10             	cmp    $0x10,%ebx
80105a4e:	75 f0                	jne    80105a40 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105a50:	83 ec 0c             	sub    $0xc,%esp
80105a53:	ff 75 e0             	pushl  -0x20(%ebp)
80105a56:	e8 d5 b3 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
80105a5b:	58                   	pop    %eax
80105a5c:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a5f:	e8 cc b3 ff ff       	call   80100e30 <fileclose>
    return -1;
80105a64:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105a67:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80105a6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105a6f:	5b                   	pop    %ebx
80105a70:	5e                   	pop    %esi
80105a71:	5f                   	pop    %edi
80105a72:	5d                   	pop    %ebp
80105a73:	c3                   	ret    
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105a78:	8d 73 08             	lea    0x8(%ebx),%esi
80105a7b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a7f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105a82:	e8 59 dd ff ff       	call   801037e0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105a87:	31 d2                	xor    %edx,%edx
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105a90:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105a94:	85 c9                	test   %ecx,%ecx
80105a96:	74 18                	je     80105ab0 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105a98:	83 c2 01             	add    $0x1,%edx
80105a9b:	83 fa 10             	cmp    $0x10,%edx
80105a9e:	75 f0                	jne    80105a90 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105aa0:	e8 3b dd ff ff       	call   801037e0 <myproc>
80105aa5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105aac:	00 
80105aad:	eb a1                	jmp    80105a50 <sys_pipe+0x50>
80105aaf:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105ab0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105ab4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105ab7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105ab9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105abc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
80105abf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105ac2:	31 c0                	xor    %eax,%eax
}
80105ac4:	5b                   	pop    %ebx
80105ac5:	5e                   	pop    %esi
80105ac6:	5f                   	pop    %edi
80105ac7:	5d                   	pop    %ebp
80105ac8:	c3                   	ret    
80105ac9:	66 90                	xchg   %ax,%ax
80105acb:	66 90                	xchg   %ax,%ax
80105acd:	66 90                	xchg   %ax,%ax
80105acf:	90                   	nop

80105ad0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105ad3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105ad4:	e9 57 df ff ff       	jmp    80103a30 <fork>
80105ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <sys_exit>:
}

int
sys_exit(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ae6:	e8 95 e3 ff ff       	call   80103e80 <exit>
  return 0;  // not reached
}
80105aeb:	31 c0                	xor    %eax,%eax
80105aed:	c9                   	leave  
80105aee:	c3                   	ret    
80105aef:	90                   	nop

80105af0 <sys_wait>:

int
sys_wait(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105af3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105af4:	e9 e7 e5 ff ff       	jmp    801040e0 <wait>
80105af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b00 <sys_kill>:
}

int
sys_kill(void)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105b06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b09:	50                   	push   %eax
80105b0a:	6a 00                	push   $0x0
80105b0c:	e8 4f f2 ff ff       	call   80104d60 <argint>
80105b11:	83 c4 10             	add    $0x10,%esp
80105b14:	85 c0                	test   %eax,%eax
80105b16:	78 18                	js     80105b30 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105b18:	83 ec 0c             	sub    $0xc,%esp
80105b1b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1e:	e8 7d e8 ff ff       	call   801043a0 <kill>
80105b23:	83 c4 10             	add    $0x10,%esp
}
80105b26:	c9                   	leave  
80105b27:	c3                   	ret    
80105b28:	90                   	nop
80105b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105b35:	c9                   	leave  
80105b36:	c3                   	ret    
80105b37:	89 f6                	mov    %esi,%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b40 <sys_wait2>:

int
sys_wait2(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	83 ec 1c             	sub    $0x1c,%esp
  int *retime;
  int *rutime;
  int *stime;

  if(argptr(0, (void*)&retime, sizeof(retime)) < 0 ||  argptr(1, (void*)&rutime, sizeof(rutime)) < 0 || argptr(2, (void*)&stime, sizeof(stime)) < 0)
80105b46:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105b49:	6a 04                	push   $0x4
80105b4b:	50                   	push   %eax
80105b4c:	6a 00                	push   $0x0
80105b4e:	e8 5d f2 ff ff       	call   80104db0 <argptr>
80105b53:	83 c4 10             	add    $0x10,%esp
80105b56:	85 c0                	test   %eax,%eax
80105b58:	78 46                	js     80105ba0 <sys_wait2+0x60>
80105b5a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b5d:	83 ec 04             	sub    $0x4,%esp
80105b60:	6a 04                	push   $0x4
80105b62:	50                   	push   %eax
80105b63:	6a 01                	push   $0x1
80105b65:	e8 46 f2 ff ff       	call   80104db0 <argptr>
80105b6a:	83 c4 10             	add    $0x10,%esp
80105b6d:	85 c0                	test   %eax,%eax
80105b6f:	78 2f                	js     80105ba0 <sys_wait2+0x60>
80105b71:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b74:	83 ec 04             	sub    $0x4,%esp
80105b77:	6a 04                	push   $0x4
80105b79:	50                   	push   %eax
80105b7a:	6a 02                	push   $0x2
80105b7c:	e8 2f f2 ff ff       	call   80104db0 <argptr>
80105b81:	83 c4 10             	add    $0x10,%esp
80105b84:	85 c0                	test   %eax,%eax
80105b86:	78 18                	js     80105ba0 <sys_wait2+0x60>
    return -1;

  return wait2(retime, rutime, stime);
80105b88:	83 ec 04             	sub    $0x4,%esp
80105b8b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8e:	ff 75 f0             	pushl  -0x10(%ebp)
80105b91:	ff 75 ec             	pushl  -0x14(%ebp)
80105b94:	e8 57 e6 ff ff       	call   801041f0 <wait2>
80105b99:	83 c4 10             	add    $0x10,%esp
}
80105b9c:	c9                   	leave  
80105b9d:	c3                   	ret    
80105b9e:	66 90                	xchg   %ax,%ax
  int *retime;
  int *rutime;
  int *stime;

  if(argptr(0, (void*)&retime, sizeof(retime)) < 0 ||  argptr(1, (void*)&rutime, sizeof(rutime)) < 0 || argptr(2, (void*)&stime, sizeof(stime)) < 0)
    return -1;
80105ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  return wait2(retime, rutime, stime);
}
80105ba5:	c9                   	leave  
80105ba6:	c3                   	ret    
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bb0 <sys_getpid>:

int
sys_getpid(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105bb6:	e8 25 dc ff ff       	call   801037e0 <myproc>
80105bbb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105bbe:	c9                   	leave  
80105bbf:	c3                   	ret    

80105bc0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105bc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105bc7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105bca:	50                   	push   %eax
80105bcb:	6a 00                	push   $0x0
80105bcd:	e8 8e f1 ff ff       	call   80104d60 <argint>
80105bd2:	83 c4 10             	add    $0x10,%esp
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	78 27                	js     80105c00 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105bd9:	e8 02 dc ff ff       	call   801037e0 <myproc>
  if(growproc(n) < 0)
80105bde:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105be1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105be3:	ff 75 f4             	pushl  -0xc(%ebp)
80105be6:	e8 c5 dd ff ff       	call   801039b0 <growproc>
80105beb:	83 c4 10             	add    $0x10,%esp
80105bee:	85 c0                	test   %eax,%eax
80105bf0:	78 0e                	js     80105c00 <sys_sbrk+0x40>
    return -1;
  return addr;
80105bf2:	89 d8                	mov    %ebx,%eax
}
80105bf4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bf7:	c9                   	leave  
80105bf8:	c3                   	ret    
80105bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c05:	eb ed                	jmp    80105bf4 <sys_sbrk+0x34>
80105c07:	89 f6                	mov    %esi,%esi
80105c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c10 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105c14:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105c17:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105c1a:	50                   	push   %eax
80105c1b:	6a 00                	push   $0x0
80105c1d:	e8 3e f1 ff ff       	call   80104d60 <argint>
80105c22:	83 c4 10             	add    $0x10,%esp
80105c25:	85 c0                	test   %eax,%eax
80105c27:	0f 88 8a 00 00 00    	js     80105cb7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105c2d:	83 ec 0c             	sub    $0xc,%esp
80105c30:	68 e0 72 11 80       	push   $0x801172e0
80105c35:	e8 16 ed ff ff       	call   80104950 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c3d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105c40:	8b 1d 20 7b 11 80    	mov    0x80117b20,%ebx
  while(ticks - ticks0 < n){
80105c46:	85 d2                	test   %edx,%edx
80105c48:	75 27                	jne    80105c71 <sys_sleep+0x61>
80105c4a:	eb 54                	jmp    80105ca0 <sys_sleep+0x90>
80105c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105c50:	83 ec 08             	sub    $0x8,%esp
80105c53:	68 e0 72 11 80       	push   $0x801172e0
80105c58:	68 20 7b 11 80       	push   $0x80117b20
80105c5d:	e8 be e3 ff ff       	call   80104020 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c62:	a1 20 7b 11 80       	mov    0x80117b20,%eax
80105c67:	83 c4 10             	add    $0x10,%esp
80105c6a:	29 d8                	sub    %ebx,%eax
80105c6c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c6f:	73 2f                	jae    80105ca0 <sys_sleep+0x90>
    if(myproc()->killed){
80105c71:	e8 6a db ff ff       	call   801037e0 <myproc>
80105c76:	8b 40 24             	mov    0x24(%eax),%eax
80105c79:	85 c0                	test   %eax,%eax
80105c7b:	74 d3                	je     80105c50 <sys_sleep+0x40>
      release(&tickslock);
80105c7d:	83 ec 0c             	sub    $0xc,%esp
80105c80:	68 e0 72 11 80       	push   $0x801172e0
80105c85:	e8 76 ed ff ff       	call   80104a00 <release>
      return -1;
80105c8a:	83 c4 10             	add    $0x10,%esp
80105c8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c95:	c9                   	leave  
80105c96:	c3                   	ret    
80105c97:	89 f6                	mov    %esi,%esi
80105c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
80105ca3:	68 e0 72 11 80       	push   $0x801172e0
80105ca8:	e8 53 ed ff ff       	call   80104a00 <release>
  return 0;
80105cad:	83 c4 10             	add    $0x10,%esp
80105cb0:	31 c0                	xor    %eax,%eax
}
80105cb2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cb5:	c9                   	leave  
80105cb6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105cb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cbc:	eb d4                	jmp    80105c92 <sys_sleep+0x82>
80105cbe:	66 90                	xchg   %ax,%ax

80105cc0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	53                   	push   %ebx
80105cc4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105cc7:	68 e0 72 11 80       	push   $0x801172e0
80105ccc:	e8 7f ec ff ff       	call   80104950 <acquire>
  xticks = ticks;
80105cd1:	8b 1d 20 7b 11 80    	mov    0x80117b20,%ebx
  release(&tickslock);
80105cd7:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
80105cde:	e8 1d ed ff ff       	call   80104a00 <release>
  return xticks;
}
80105ce3:	89 d8                	mov    %ebx,%eax
80105ce5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ce8:	c9                   	leave  
80105ce9:	c3                   	ret    
80105cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cf0 <sys_trace>:

int
sys_trace(void)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	83 ec 08             	sub    $0x8,%esp
  if (argint(0, &myproc()->traceflag) < 0)
80105cf6:	e8 e5 da ff ff       	call   801037e0 <myproc>
80105cfb:	83 ec 08             	sub    $0x8,%esp
80105cfe:	83 c0 7c             	add    $0x7c,%eax
80105d01:	50                   	push   %eax
80105d02:	6a 00                	push   $0x0
80105d04:	e8 57 f0 ff ff       	call   80104d60 <argint>
    return -1;

  return 0;
}
80105d09:	c9                   	leave  
80105d0a:	c1 f8 1f             	sar    $0x1f,%eax
80105d0d:	c3                   	ret    
80105d0e:	66 90                	xchg   %ax,%ax

80105d10 <sys_cs>:

int
sys_cs(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	83 ec 08             	sub    $0x8,%esp
  int aux;
  aux = myproc()->counter;
80105d16:	e8 c5 da ff ff       	call   801037e0 <myproc>
  return aux;
80105d1b:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
}
80105d21:	c9                   	leave  
80105d22:	c3                   	ret    
80105d23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d30 <sys_set_tickets>:

int
sys_set_tickets(void)
{
80105d30:	55                   	push   %ebp
80105d31:	89 e5                	mov    %esp,%ebp
80105d33:	83 ec 20             	sub    $0x20,%esp
  int n;

  if (argint(0, &n) < 0)
80105d36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d39:	50                   	push   %eax
80105d3a:	6a 00                	push   $0x0
80105d3c:	e8 1f f0 ff ff       	call   80104d60 <argint>
80105d41:	83 c4 10             	add    $0x10,%esp
80105d44:	85 c0                	test   %eax,%eax
80105d46:	78 18                	js     80105d60 <sys_set_tickets+0x30>
    return -1;

  myproc()->tickets = n;
80105d48:	e8 93 da ff ff       	call   801037e0 <myproc>
80105d4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d50:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)

  return n;
}
80105d56:	89 d0                	mov    %edx,%eax
80105d58:	c9                   	leave  
80105d59:	c3                   	ret    
80105d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_set_tickets(void)
{
  int n;

  if (argint(0, &n) < 0)
    return -1;
80105d60:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80105d65:	eb ef                	jmp    80105d56 <sys_set_tickets+0x26>
80105d67:	89 f6                	mov    %esi,%esi
80105d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d70 <sys_set_priority>:
  return n;
}

int
sys_set_priority(void)
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;

  if(argint(0, &pid) < 0)
80105d76:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d79:	50                   	push   %eax
80105d7a:	6a 00                	push   $0x0
80105d7c:	e8 df ef ff ff       	call   80104d60 <argint>
80105d81:	83 c4 10             	add    $0x10,%esp
80105d84:	85 c0                	test   %eax,%eax
80105d86:	78 28                	js     80105db0 <sys_set_priority+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105d88:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d8b:	83 ec 08             	sub    $0x8,%esp
80105d8e:	50                   	push   %eax
80105d8f:	6a 01                	push   $0x1
80105d91:	e8 ca ef ff ff       	call   80104d60 <argint>
80105d96:	83 c4 10             	add    $0x10,%esp
80105d99:	85 c0                	test   %eax,%eax
80105d9b:	78 13                	js     80105db0 <sys_set_priority+0x40>
    return -1;

  return set_priority(pid, pr);
80105d9d:	83 ec 08             	sub    $0x8,%esp
80105da0:	ff 75 f4             	pushl  -0xc(%ebp)
80105da3:	ff 75 f0             	pushl  -0x10(%ebp)
80105da6:	e8 25 de ff ff       	call   80103bd0 <set_priority>
80105dab:	83 c4 10             	add    $0x10,%esp
}
80105dae:	c9                   	leave  
80105daf:	c3                   	ret    
sys_set_priority(void)
{
  int pid, pr;

  if(argint(0, &pid) < 0)
    return -1;
80105db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(argint(1, &pr) < 0)
    return -1;

  return set_priority(pid, pr);
}
80105db5:	c9                   	leave  
80105db6:	c3                   	ret    

80105db7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105db7:	1e                   	push   %ds
  pushl %es
80105db8:	06                   	push   %es
  pushl %fs
80105db9:	0f a0                	push   %fs
  pushl %gs
80105dbb:	0f a8                	push   %gs
  pushal
80105dbd:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105dbe:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105dc2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105dc4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105dc6:	54                   	push   %esp
  call trap
80105dc7:	e8 e4 00 00 00       	call   80105eb0 <trap>
  addl $4, %esp
80105dcc:	83 c4 04             	add    $0x4,%esp

80105dcf <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105dcf:	61                   	popa   
  popl %gs
80105dd0:	0f a9                	pop    %gs
  popl %fs
80105dd2:	0f a1                	pop    %fs
  popl %es
80105dd4:	07                   	pop    %es
  popl %ds
80105dd5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105dd6:	83 c4 08             	add    $0x8,%esp
  iret
80105dd9:	cf                   	iret   
80105dda:	66 90                	xchg   %ax,%ax
80105ddc:	66 90                	xchg   %ax,%ax
80105dde:	66 90                	xchg   %ax,%ax

80105de0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105de0:	31 c0                	xor    %eax,%eax
80105de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105de8:	8b 14 85 90 b0 10 80 	mov    -0x7fef4f70(,%eax,4),%edx
80105def:	b9 08 00 00 00       	mov    $0x8,%ecx
80105df4:	c6 04 c5 24 73 11 80 	movb   $0x0,-0x7fee8cdc(,%eax,8)
80105dfb:	00 
80105dfc:	66 89 0c c5 22 73 11 	mov    %cx,-0x7fee8cde(,%eax,8)
80105e03:	80 
80105e04:	c6 04 c5 25 73 11 80 	movb   $0x8e,-0x7fee8cdb(,%eax,8)
80105e0b:	8e 
80105e0c:	66 89 14 c5 20 73 11 	mov    %dx,-0x7fee8ce0(,%eax,8)
80105e13:	80 
80105e14:	c1 ea 10             	shr    $0x10,%edx
80105e17:	66 89 14 c5 26 73 11 	mov    %dx,-0x7fee8cda(,%eax,8)
80105e1e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105e1f:	83 c0 01             	add    $0x1,%eax
80105e22:	3d 00 01 00 00       	cmp    $0x100,%eax
80105e27:	75 bf                	jne    80105de8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105e29:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e2a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105e2f:	89 e5                	mov    %esp,%ebp
80105e31:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e34:	a1 90 b1 10 80       	mov    0x8010b190,%eax

  initlock(&tickslock, "time");
80105e39:	68 83 7d 10 80       	push   $0x80107d83
80105e3e:	68 e0 72 11 80       	push   $0x801172e0
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e43:	66 89 15 22 75 11 80 	mov    %dx,0x80117522
80105e4a:	c6 05 24 75 11 80 00 	movb   $0x0,0x80117524
80105e51:	66 a3 20 75 11 80    	mov    %ax,0x80117520
80105e57:	c1 e8 10             	shr    $0x10,%eax
80105e5a:	c6 05 25 75 11 80 ef 	movb   $0xef,0x80117525
80105e61:	66 a3 26 75 11 80    	mov    %ax,0x80117526

  initlock(&tickslock, "time");
80105e67:	e8 84 e9 ff ff       	call   801047f0 <initlock>
}
80105e6c:	83 c4 10             	add    $0x10,%esp
80105e6f:	c9                   	leave  
80105e70:	c3                   	ret    
80105e71:	eb 0d                	jmp    80105e80 <idtinit>
80105e73:	90                   	nop
80105e74:	90                   	nop
80105e75:	90                   	nop
80105e76:	90                   	nop
80105e77:	90                   	nop
80105e78:	90                   	nop
80105e79:	90                   	nop
80105e7a:	90                   	nop
80105e7b:	90                   	nop
80105e7c:	90                   	nop
80105e7d:	90                   	nop
80105e7e:	90                   	nop
80105e7f:	90                   	nop

80105e80 <idtinit>:

void
idtinit(void)
{
80105e80:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105e81:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105e86:	89 e5                	mov    %esp,%ebp
80105e88:	83 ec 10             	sub    $0x10,%esp
80105e8b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105e8f:	b8 20 73 11 80       	mov    $0x80117320,%eax
80105e94:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105e98:	c1 e8 10             	shr    $0x10,%eax
80105e9b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105e9f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ea2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ea5:	c9                   	leave  
80105ea6:	c3                   	ret    
80105ea7:	89 f6                	mov    %esi,%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105eb0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	57                   	push   %edi
80105eb4:	56                   	push   %esi
80105eb5:	53                   	push   %ebx
80105eb6:	83 ec 1c             	sub    $0x1c,%esp
80105eb9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105ebc:	8b 47 30             	mov    0x30(%edi),%eax
80105ebf:	83 f8 40             	cmp    $0x40,%eax
80105ec2:	0f 84 88 01 00 00    	je     80106050 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ec8:	83 e8 20             	sub    $0x20,%eax
80105ecb:	83 f8 1f             	cmp    $0x1f,%eax
80105ece:	77 10                	ja     80105ee0 <trap+0x30>
80105ed0:	ff 24 85 74 7f 10 80 	jmp    *-0x7fef808c(,%eax,4)
80105ed7:	89 f6                	mov    %esi,%esi
80105ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ee0:	e8 fb d8 ff ff       	call   801037e0 <myproc>
80105ee5:	85 c0                	test   %eax,%eax
80105ee7:	0f 84 dc 01 00 00    	je     801060c9 <trap+0x219>
80105eed:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105ef1:	0f 84 d2 01 00 00    	je     801060c9 <trap+0x219>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105ef7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105efa:	8b 57 38             	mov    0x38(%edi),%edx
80105efd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105f00:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105f03:	e8 b8 d8 ff ff       	call   801037c0 <cpuid>
80105f08:	8b 77 34             	mov    0x34(%edi),%esi
80105f0b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105f0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f11:	e8 ca d8 ff ff       	call   801037e0 <myproc>
80105f16:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105f19:	e8 c2 d8 ff ff       	call   801037e0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f1e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105f21:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105f24:	51                   	push   %ecx
80105f25:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f26:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f29:	ff 75 e4             	pushl  -0x1c(%ebp)
80105f2c:	56                   	push   %esi
80105f2d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f2e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f31:	52                   	push   %edx
80105f32:	ff 70 10             	pushl  0x10(%eax)
80105f35:	68 30 7f 10 80       	push   $0x80107f30
80105f3a:	e8 21 a7 ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105f3f:	83 c4 20             	add    $0x20,%esp
80105f42:	e8 99 d8 ff ff       	call   801037e0 <myproc>
80105f47:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105f4e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f50:	e8 8b d8 ff ff       	call   801037e0 <myproc>
80105f55:	85 c0                	test   %eax,%eax
80105f57:	74 0c                	je     80105f65 <trap+0xb5>
80105f59:	e8 82 d8 ff ff       	call   801037e0 <myproc>
80105f5e:	8b 50 24             	mov    0x24(%eax),%edx
80105f61:	85 d2                	test   %edx,%edx
80105f63:	75 4b                	jne    80105fb0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105f65:	e8 76 d8 ff ff       	call   801037e0 <myproc>
80105f6a:	85 c0                	test   %eax,%eax
80105f6c:	74 0b                	je     80105f79 <trap+0xc9>
80105f6e:	e8 6d d8 ff ff       	call   801037e0 <myproc>
80105f73:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105f77:	74 4f                	je     80105fc8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f79:	e8 62 d8 ff ff       	call   801037e0 <myproc>
80105f7e:	85 c0                	test   %eax,%eax
80105f80:	74 1d                	je     80105f9f <trap+0xef>
80105f82:	e8 59 d8 ff ff       	call   801037e0 <myproc>
80105f87:	8b 40 24             	mov    0x24(%eax),%eax
80105f8a:	85 c0                	test   %eax,%eax
80105f8c:	74 11                	je     80105f9f <trap+0xef>
80105f8e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105f92:	83 e0 03             	and    $0x3,%eax
80105f95:	66 83 f8 03          	cmp    $0x3,%ax
80105f99:	0f 84 da 00 00 00    	je     80106079 <trap+0x1c9>
    exit();
}
80105f9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fa2:	5b                   	pop    %ebx
80105fa3:	5e                   	pop    %esi
80105fa4:	5f                   	pop    %edi
80105fa5:	5d                   	pop    %ebp
80105fa6:	c3                   	ret    
80105fa7:	89 f6                	mov    %esi,%esi
80105fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fb0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105fb4:	83 e0 03             	and    $0x3,%eax
80105fb7:	66 83 f8 03          	cmp    $0x3,%ax
80105fbb:	75 a8                	jne    80105f65 <trap+0xb5>
    exit();
80105fbd:	e8 be de ff ff       	call   80103e80 <exit>
80105fc2:	eb a1                	jmp    80105f65 <trap+0xb5>
80105fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105fc8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105fcc:	75 ab                	jne    80105f79 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105fce:	e8 dd df ff ff       	call   80103fb0 <yield>
80105fd3:	eb a4                	jmp    80105f79 <trap+0xc9>
80105fd5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105fd8:	e8 e3 d7 ff ff       	call   801037c0 <cpuid>
80105fdd:	85 c0                	test   %eax,%eax
80105fdf:	0f 84 ab 00 00 00    	je     80106090 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105fe5:	e8 16 c7 ff ff       	call   80102700 <lapiceoi>
    break;
80105fea:	e9 61 ff ff ff       	jmp    80105f50 <trap+0xa0>
80105fef:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105ff0:	e8 cb c5 ff ff       	call   801025c0 <kbdintr>
    lapiceoi();
80105ff5:	e8 06 c7 ff ff       	call   80102700 <lapiceoi>
    break;
80105ffa:	e9 51 ff ff ff       	jmp    80105f50 <trap+0xa0>
80105fff:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106000:	e8 6b 02 00 00       	call   80106270 <uartintr>
    lapiceoi();
80106005:	e8 f6 c6 ff ff       	call   80102700 <lapiceoi>
    break;
8010600a:	e9 41 ff ff ff       	jmp    80105f50 <trap+0xa0>
8010600f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106010:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106014:	8b 77 38             	mov    0x38(%edi),%esi
80106017:	e8 a4 d7 ff ff       	call   801037c0 <cpuid>
8010601c:	56                   	push   %esi
8010601d:	53                   	push   %ebx
8010601e:	50                   	push   %eax
8010601f:	68 d8 7e 10 80       	push   $0x80107ed8
80106024:	e8 37 a6 ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106029:	e8 d2 c6 ff ff       	call   80102700 <lapiceoi>
    break;
8010602e:	83 c4 10             	add    $0x10,%esp
80106031:	e9 1a ff ff ff       	jmp    80105f50 <trap+0xa0>
80106036:	8d 76 00             	lea    0x0(%esi),%esi
80106039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106040:	e8 fb bf ff ff       	call   80102040 <ideintr>
80106045:	eb 9e                	jmp    80105fe5 <trap+0x135>
80106047:	89 f6                	mov    %esi,%esi
80106049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80106050:	e8 8b d7 ff ff       	call   801037e0 <myproc>
80106055:	8b 58 24             	mov    0x24(%eax),%ebx
80106058:	85 db                	test   %ebx,%ebx
8010605a:	75 2c                	jne    80106088 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
8010605c:	e8 7f d7 ff ff       	call   801037e0 <myproc>
80106061:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106064:	e8 e7 ed ff ff       	call   80104e50 <syscall>
    if(myproc()->killed)
80106069:	e8 72 d7 ff ff       	call   801037e0 <myproc>
8010606e:	8b 48 24             	mov    0x24(%eax),%ecx
80106071:	85 c9                	test   %ecx,%ecx
80106073:	0f 84 26 ff ff ff    	je     80105f9f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106079:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010607c:	5b                   	pop    %ebx
8010607d:	5e                   	pop    %esi
8010607e:	5f                   	pop    %edi
8010607f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80106080:	e9 fb dd ff ff       	jmp    80103e80 <exit>
80106085:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80106088:	e8 f3 dd ff ff       	call   80103e80 <exit>
8010608d:	eb cd                	jmp    8010605c <trap+0x1ac>
8010608f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80106090:	83 ec 0c             	sub    $0xc,%esp
80106093:	68 e0 72 11 80       	push   $0x801172e0
80106098:	e8 b3 e8 ff ff       	call   80104950 <acquire>
      ticks++;
8010609d:	83 05 20 7b 11 80 01 	addl   $0x1,0x80117b20
      countprocs(); 
801060a4:	e8 a7 da ff ff       	call   80103b50 <countprocs>
      wakeup(&ticks);
801060a9:	c7 04 24 20 7b 11 80 	movl   $0x80117b20,(%esp)
801060b0:	e8 8b e2 ff ff       	call   80104340 <wakeup>
      release(&tickslock);
801060b5:	c7 04 24 e0 72 11 80 	movl   $0x801172e0,(%esp)
801060bc:	e8 3f e9 ff ff       	call   80104a00 <release>
801060c1:	83 c4 10             	add    $0x10,%esp
801060c4:	e9 1c ff ff ff       	jmp    80105fe5 <trap+0x135>
801060c9:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801060cc:	8b 5f 38             	mov    0x38(%edi),%ebx
801060cf:	e8 ec d6 ff ff       	call   801037c0 <cpuid>
801060d4:	83 ec 0c             	sub    $0xc,%esp
801060d7:	56                   	push   %esi
801060d8:	53                   	push   %ebx
801060d9:	50                   	push   %eax
801060da:	ff 77 30             	pushl  0x30(%edi)
801060dd:	68 fc 7e 10 80       	push   $0x80107efc
801060e2:	e8 79 a5 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
801060e7:	83 c4 14             	add    $0x14,%esp
801060ea:	68 d1 7e 10 80       	push   $0x80107ed1
801060ef:	e8 7c a2 ff ff       	call   80100370 <panic>
801060f4:	66 90                	xchg   %ax,%ax
801060f6:	66 90                	xchg   %ax,%ax
801060f8:	66 90                	xchg   %ax,%ax
801060fa:	66 90                	xchg   %ax,%ax
801060fc:	66 90                	xchg   %ax,%ax
801060fe:	66 90                	xchg   %ax,%ax

80106100 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106100:	a1 00 c0 10 80       	mov    0x8010c000,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106105:	55                   	push   %ebp
80106106:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106108:	85 c0                	test   %eax,%eax
8010610a:	74 1c                	je     80106128 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010610c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106111:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106112:	a8 01                	test   $0x1,%al
80106114:	74 12                	je     80106128 <uartgetc+0x28>
80106116:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010611b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010611c:	0f b6 c0             	movzbl %al,%eax
}
8010611f:	5d                   	pop    %ebp
80106120:	c3                   	ret    
80106121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106128:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010612d:	5d                   	pop    %ebp
8010612e:	c3                   	ret    
8010612f:	90                   	nop

80106130 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	57                   	push   %edi
80106134:	56                   	push   %esi
80106135:	53                   	push   %ebx
80106136:	89 c7                	mov    %eax,%edi
80106138:	bb 80 00 00 00       	mov    $0x80,%ebx
8010613d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106142:	83 ec 0c             	sub    $0xc,%esp
80106145:	eb 1b                	jmp    80106162 <uartputc.part.0+0x32>
80106147:	89 f6                	mov    %esi,%esi
80106149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80106150:	83 ec 0c             	sub    $0xc,%esp
80106153:	6a 0a                	push   $0xa
80106155:	e8 c6 c5 ff ff       	call   80102720 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010615a:	83 c4 10             	add    $0x10,%esp
8010615d:	83 eb 01             	sub    $0x1,%ebx
80106160:	74 07                	je     80106169 <uartputc.part.0+0x39>
80106162:	89 f2                	mov    %esi,%edx
80106164:	ec                   	in     (%dx),%al
80106165:	a8 20                	test   $0x20,%al
80106167:	74 e7                	je     80106150 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106169:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010616e:	89 f8                	mov    %edi,%eax
80106170:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80106171:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106174:	5b                   	pop    %ebx
80106175:	5e                   	pop    %esi
80106176:	5f                   	pop    %edi
80106177:	5d                   	pop    %ebp
80106178:	c3                   	ret    
80106179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106180 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106180:	55                   	push   %ebp
80106181:	31 c9                	xor    %ecx,%ecx
80106183:	89 c8                	mov    %ecx,%eax
80106185:	89 e5                	mov    %esp,%ebp
80106187:	57                   	push   %edi
80106188:	56                   	push   %esi
80106189:	53                   	push   %ebx
8010618a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010618f:	89 da                	mov    %ebx,%edx
80106191:	83 ec 0c             	sub    $0xc,%esp
80106194:	ee                   	out    %al,(%dx)
80106195:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010619a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010619f:	89 fa                	mov    %edi,%edx
801061a1:	ee                   	out    %al,(%dx)
801061a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801061a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061ac:	ee                   	out    %al,(%dx)
801061ad:	be f9 03 00 00       	mov    $0x3f9,%esi
801061b2:	89 c8                	mov    %ecx,%eax
801061b4:	89 f2                	mov    %esi,%edx
801061b6:	ee                   	out    %al,(%dx)
801061b7:	b8 03 00 00 00       	mov    $0x3,%eax
801061bc:	89 fa                	mov    %edi,%edx
801061be:	ee                   	out    %al,(%dx)
801061bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801061c4:	89 c8                	mov    %ecx,%eax
801061c6:	ee                   	out    %al,(%dx)
801061c7:	b8 01 00 00 00       	mov    $0x1,%eax
801061cc:	89 f2                	mov    %esi,%edx
801061ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061d4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801061d5:	3c ff                	cmp    $0xff,%al
801061d7:	74 5a                	je     80106233 <uartinit+0xb3>
    return;
  uart = 1;
801061d9:	c7 05 00 c0 10 80 01 	movl   $0x1,0x8010c000
801061e0:	00 00 00 
801061e3:	89 da                	mov    %ebx,%edx
801061e5:	ec                   	in     (%dx),%al
801061e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061eb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801061ec:	83 ec 08             	sub    $0x8,%esp
801061ef:	bb f4 7f 10 80       	mov    $0x80107ff4,%ebx
801061f4:	6a 00                	push   $0x0
801061f6:	6a 04                	push   $0x4
801061f8:	e8 93 c0 ff ff       	call   80102290 <ioapicenable>
801061fd:	83 c4 10             	add    $0x10,%esp
80106200:	b8 78 00 00 00       	mov    $0x78,%eax
80106205:	eb 13                	jmp    8010621a <uartinit+0x9a>
80106207:	89 f6                	mov    %esi,%esi
80106209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106210:	83 c3 01             	add    $0x1,%ebx
80106213:	0f be 03             	movsbl (%ebx),%eax
80106216:	84 c0                	test   %al,%al
80106218:	74 19                	je     80106233 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010621a:	8b 15 00 c0 10 80    	mov    0x8010c000,%edx
80106220:	85 d2                	test   %edx,%edx
80106222:	74 ec                	je     80106210 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106224:	83 c3 01             	add    $0x1,%ebx
80106227:	e8 04 ff ff ff       	call   80106130 <uartputc.part.0>
8010622c:	0f be 03             	movsbl (%ebx),%eax
8010622f:	84 c0                	test   %al,%al
80106231:	75 e7                	jne    8010621a <uartinit+0x9a>
    uartputc(*p);
}
80106233:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106236:	5b                   	pop    %ebx
80106237:	5e                   	pop    %esi
80106238:	5f                   	pop    %edi
80106239:	5d                   	pop    %ebp
8010623a:	c3                   	ret    
8010623b:	90                   	nop
8010623c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106240 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106240:	8b 15 00 c0 10 80    	mov    0x8010c000,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106246:	55                   	push   %ebp
80106247:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106249:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
8010624b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010624e:	74 10                	je     80106260 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106250:	5d                   	pop    %ebp
80106251:	e9 da fe ff ff       	jmp    80106130 <uartputc.part.0>
80106256:	8d 76 00             	lea    0x0(%esi),%esi
80106259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106260:	5d                   	pop    %ebp
80106261:	c3                   	ret    
80106262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106270 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106276:	68 00 61 10 80       	push   $0x80106100
8010627b:	e8 70 a5 ff ff       	call   801007f0 <consoleintr>
}
80106280:	83 c4 10             	add    $0x10,%esp
80106283:	c9                   	leave  
80106284:	c3                   	ret    

80106285 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106285:	6a 00                	push   $0x0
  pushl $0
80106287:	6a 00                	push   $0x0
  jmp alltraps
80106289:	e9 29 fb ff ff       	jmp    80105db7 <alltraps>

8010628e <vector1>:
.globl vector1
vector1:
  pushl $0
8010628e:	6a 00                	push   $0x0
  pushl $1
80106290:	6a 01                	push   $0x1
  jmp alltraps
80106292:	e9 20 fb ff ff       	jmp    80105db7 <alltraps>

80106297 <vector2>:
.globl vector2
vector2:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $2
80106299:	6a 02                	push   $0x2
  jmp alltraps
8010629b:	e9 17 fb ff ff       	jmp    80105db7 <alltraps>

801062a0 <vector3>:
.globl vector3
vector3:
  pushl $0
801062a0:	6a 00                	push   $0x0
  pushl $3
801062a2:	6a 03                	push   $0x3
  jmp alltraps
801062a4:	e9 0e fb ff ff       	jmp    80105db7 <alltraps>

801062a9 <vector4>:
.globl vector4
vector4:
  pushl $0
801062a9:	6a 00                	push   $0x0
  pushl $4
801062ab:	6a 04                	push   $0x4
  jmp alltraps
801062ad:	e9 05 fb ff ff       	jmp    80105db7 <alltraps>

801062b2 <vector5>:
.globl vector5
vector5:
  pushl $0
801062b2:	6a 00                	push   $0x0
  pushl $5
801062b4:	6a 05                	push   $0x5
  jmp alltraps
801062b6:	e9 fc fa ff ff       	jmp    80105db7 <alltraps>

801062bb <vector6>:
.globl vector6
vector6:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $6
801062bd:	6a 06                	push   $0x6
  jmp alltraps
801062bf:	e9 f3 fa ff ff       	jmp    80105db7 <alltraps>

801062c4 <vector7>:
.globl vector7
vector7:
  pushl $0
801062c4:	6a 00                	push   $0x0
  pushl $7
801062c6:	6a 07                	push   $0x7
  jmp alltraps
801062c8:	e9 ea fa ff ff       	jmp    80105db7 <alltraps>

801062cd <vector8>:
.globl vector8
vector8:
  pushl $8
801062cd:	6a 08                	push   $0x8
  jmp alltraps
801062cf:	e9 e3 fa ff ff       	jmp    80105db7 <alltraps>

801062d4 <vector9>:
.globl vector9
vector9:
  pushl $0
801062d4:	6a 00                	push   $0x0
  pushl $9
801062d6:	6a 09                	push   $0x9
  jmp alltraps
801062d8:	e9 da fa ff ff       	jmp    80105db7 <alltraps>

801062dd <vector10>:
.globl vector10
vector10:
  pushl $10
801062dd:	6a 0a                	push   $0xa
  jmp alltraps
801062df:	e9 d3 fa ff ff       	jmp    80105db7 <alltraps>

801062e4 <vector11>:
.globl vector11
vector11:
  pushl $11
801062e4:	6a 0b                	push   $0xb
  jmp alltraps
801062e6:	e9 cc fa ff ff       	jmp    80105db7 <alltraps>

801062eb <vector12>:
.globl vector12
vector12:
  pushl $12
801062eb:	6a 0c                	push   $0xc
  jmp alltraps
801062ed:	e9 c5 fa ff ff       	jmp    80105db7 <alltraps>

801062f2 <vector13>:
.globl vector13
vector13:
  pushl $13
801062f2:	6a 0d                	push   $0xd
  jmp alltraps
801062f4:	e9 be fa ff ff       	jmp    80105db7 <alltraps>

801062f9 <vector14>:
.globl vector14
vector14:
  pushl $14
801062f9:	6a 0e                	push   $0xe
  jmp alltraps
801062fb:	e9 b7 fa ff ff       	jmp    80105db7 <alltraps>

80106300 <vector15>:
.globl vector15
vector15:
  pushl $0
80106300:	6a 00                	push   $0x0
  pushl $15
80106302:	6a 0f                	push   $0xf
  jmp alltraps
80106304:	e9 ae fa ff ff       	jmp    80105db7 <alltraps>

80106309 <vector16>:
.globl vector16
vector16:
  pushl $0
80106309:	6a 00                	push   $0x0
  pushl $16
8010630b:	6a 10                	push   $0x10
  jmp alltraps
8010630d:	e9 a5 fa ff ff       	jmp    80105db7 <alltraps>

80106312 <vector17>:
.globl vector17
vector17:
  pushl $17
80106312:	6a 11                	push   $0x11
  jmp alltraps
80106314:	e9 9e fa ff ff       	jmp    80105db7 <alltraps>

80106319 <vector18>:
.globl vector18
vector18:
  pushl $0
80106319:	6a 00                	push   $0x0
  pushl $18
8010631b:	6a 12                	push   $0x12
  jmp alltraps
8010631d:	e9 95 fa ff ff       	jmp    80105db7 <alltraps>

80106322 <vector19>:
.globl vector19
vector19:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $19
80106324:	6a 13                	push   $0x13
  jmp alltraps
80106326:	e9 8c fa ff ff       	jmp    80105db7 <alltraps>

8010632b <vector20>:
.globl vector20
vector20:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $20
8010632d:	6a 14                	push   $0x14
  jmp alltraps
8010632f:	e9 83 fa ff ff       	jmp    80105db7 <alltraps>

80106334 <vector21>:
.globl vector21
vector21:
  pushl $0
80106334:	6a 00                	push   $0x0
  pushl $21
80106336:	6a 15                	push   $0x15
  jmp alltraps
80106338:	e9 7a fa ff ff       	jmp    80105db7 <alltraps>

8010633d <vector22>:
.globl vector22
vector22:
  pushl $0
8010633d:	6a 00                	push   $0x0
  pushl $22
8010633f:	6a 16                	push   $0x16
  jmp alltraps
80106341:	e9 71 fa ff ff       	jmp    80105db7 <alltraps>

80106346 <vector23>:
.globl vector23
vector23:
  pushl $0
80106346:	6a 00                	push   $0x0
  pushl $23
80106348:	6a 17                	push   $0x17
  jmp alltraps
8010634a:	e9 68 fa ff ff       	jmp    80105db7 <alltraps>

8010634f <vector24>:
.globl vector24
vector24:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $24
80106351:	6a 18                	push   $0x18
  jmp alltraps
80106353:	e9 5f fa ff ff       	jmp    80105db7 <alltraps>

80106358 <vector25>:
.globl vector25
vector25:
  pushl $0
80106358:	6a 00                	push   $0x0
  pushl $25
8010635a:	6a 19                	push   $0x19
  jmp alltraps
8010635c:	e9 56 fa ff ff       	jmp    80105db7 <alltraps>

80106361 <vector26>:
.globl vector26
vector26:
  pushl $0
80106361:	6a 00                	push   $0x0
  pushl $26
80106363:	6a 1a                	push   $0x1a
  jmp alltraps
80106365:	e9 4d fa ff ff       	jmp    80105db7 <alltraps>

8010636a <vector27>:
.globl vector27
vector27:
  pushl $0
8010636a:	6a 00                	push   $0x0
  pushl $27
8010636c:	6a 1b                	push   $0x1b
  jmp alltraps
8010636e:	e9 44 fa ff ff       	jmp    80105db7 <alltraps>

80106373 <vector28>:
.globl vector28
vector28:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $28
80106375:	6a 1c                	push   $0x1c
  jmp alltraps
80106377:	e9 3b fa ff ff       	jmp    80105db7 <alltraps>

8010637c <vector29>:
.globl vector29
vector29:
  pushl $0
8010637c:	6a 00                	push   $0x0
  pushl $29
8010637e:	6a 1d                	push   $0x1d
  jmp alltraps
80106380:	e9 32 fa ff ff       	jmp    80105db7 <alltraps>

80106385 <vector30>:
.globl vector30
vector30:
  pushl $0
80106385:	6a 00                	push   $0x0
  pushl $30
80106387:	6a 1e                	push   $0x1e
  jmp alltraps
80106389:	e9 29 fa ff ff       	jmp    80105db7 <alltraps>

8010638e <vector31>:
.globl vector31
vector31:
  pushl $0
8010638e:	6a 00                	push   $0x0
  pushl $31
80106390:	6a 1f                	push   $0x1f
  jmp alltraps
80106392:	e9 20 fa ff ff       	jmp    80105db7 <alltraps>

80106397 <vector32>:
.globl vector32
vector32:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $32
80106399:	6a 20                	push   $0x20
  jmp alltraps
8010639b:	e9 17 fa ff ff       	jmp    80105db7 <alltraps>

801063a0 <vector33>:
.globl vector33
vector33:
  pushl $0
801063a0:	6a 00                	push   $0x0
  pushl $33
801063a2:	6a 21                	push   $0x21
  jmp alltraps
801063a4:	e9 0e fa ff ff       	jmp    80105db7 <alltraps>

801063a9 <vector34>:
.globl vector34
vector34:
  pushl $0
801063a9:	6a 00                	push   $0x0
  pushl $34
801063ab:	6a 22                	push   $0x22
  jmp alltraps
801063ad:	e9 05 fa ff ff       	jmp    80105db7 <alltraps>

801063b2 <vector35>:
.globl vector35
vector35:
  pushl $0
801063b2:	6a 00                	push   $0x0
  pushl $35
801063b4:	6a 23                	push   $0x23
  jmp alltraps
801063b6:	e9 fc f9 ff ff       	jmp    80105db7 <alltraps>

801063bb <vector36>:
.globl vector36
vector36:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $36
801063bd:	6a 24                	push   $0x24
  jmp alltraps
801063bf:	e9 f3 f9 ff ff       	jmp    80105db7 <alltraps>

801063c4 <vector37>:
.globl vector37
vector37:
  pushl $0
801063c4:	6a 00                	push   $0x0
  pushl $37
801063c6:	6a 25                	push   $0x25
  jmp alltraps
801063c8:	e9 ea f9 ff ff       	jmp    80105db7 <alltraps>

801063cd <vector38>:
.globl vector38
vector38:
  pushl $0
801063cd:	6a 00                	push   $0x0
  pushl $38
801063cf:	6a 26                	push   $0x26
  jmp alltraps
801063d1:	e9 e1 f9 ff ff       	jmp    80105db7 <alltraps>

801063d6 <vector39>:
.globl vector39
vector39:
  pushl $0
801063d6:	6a 00                	push   $0x0
  pushl $39
801063d8:	6a 27                	push   $0x27
  jmp alltraps
801063da:	e9 d8 f9 ff ff       	jmp    80105db7 <alltraps>

801063df <vector40>:
.globl vector40
vector40:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $40
801063e1:	6a 28                	push   $0x28
  jmp alltraps
801063e3:	e9 cf f9 ff ff       	jmp    80105db7 <alltraps>

801063e8 <vector41>:
.globl vector41
vector41:
  pushl $0
801063e8:	6a 00                	push   $0x0
  pushl $41
801063ea:	6a 29                	push   $0x29
  jmp alltraps
801063ec:	e9 c6 f9 ff ff       	jmp    80105db7 <alltraps>

801063f1 <vector42>:
.globl vector42
vector42:
  pushl $0
801063f1:	6a 00                	push   $0x0
  pushl $42
801063f3:	6a 2a                	push   $0x2a
  jmp alltraps
801063f5:	e9 bd f9 ff ff       	jmp    80105db7 <alltraps>

801063fa <vector43>:
.globl vector43
vector43:
  pushl $0
801063fa:	6a 00                	push   $0x0
  pushl $43
801063fc:	6a 2b                	push   $0x2b
  jmp alltraps
801063fe:	e9 b4 f9 ff ff       	jmp    80105db7 <alltraps>

80106403 <vector44>:
.globl vector44
vector44:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $44
80106405:	6a 2c                	push   $0x2c
  jmp alltraps
80106407:	e9 ab f9 ff ff       	jmp    80105db7 <alltraps>

8010640c <vector45>:
.globl vector45
vector45:
  pushl $0
8010640c:	6a 00                	push   $0x0
  pushl $45
8010640e:	6a 2d                	push   $0x2d
  jmp alltraps
80106410:	e9 a2 f9 ff ff       	jmp    80105db7 <alltraps>

80106415 <vector46>:
.globl vector46
vector46:
  pushl $0
80106415:	6a 00                	push   $0x0
  pushl $46
80106417:	6a 2e                	push   $0x2e
  jmp alltraps
80106419:	e9 99 f9 ff ff       	jmp    80105db7 <alltraps>

8010641e <vector47>:
.globl vector47
vector47:
  pushl $0
8010641e:	6a 00                	push   $0x0
  pushl $47
80106420:	6a 2f                	push   $0x2f
  jmp alltraps
80106422:	e9 90 f9 ff ff       	jmp    80105db7 <alltraps>

80106427 <vector48>:
.globl vector48
vector48:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $48
80106429:	6a 30                	push   $0x30
  jmp alltraps
8010642b:	e9 87 f9 ff ff       	jmp    80105db7 <alltraps>

80106430 <vector49>:
.globl vector49
vector49:
  pushl $0
80106430:	6a 00                	push   $0x0
  pushl $49
80106432:	6a 31                	push   $0x31
  jmp alltraps
80106434:	e9 7e f9 ff ff       	jmp    80105db7 <alltraps>

80106439 <vector50>:
.globl vector50
vector50:
  pushl $0
80106439:	6a 00                	push   $0x0
  pushl $50
8010643b:	6a 32                	push   $0x32
  jmp alltraps
8010643d:	e9 75 f9 ff ff       	jmp    80105db7 <alltraps>

80106442 <vector51>:
.globl vector51
vector51:
  pushl $0
80106442:	6a 00                	push   $0x0
  pushl $51
80106444:	6a 33                	push   $0x33
  jmp alltraps
80106446:	e9 6c f9 ff ff       	jmp    80105db7 <alltraps>

8010644b <vector52>:
.globl vector52
vector52:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $52
8010644d:	6a 34                	push   $0x34
  jmp alltraps
8010644f:	e9 63 f9 ff ff       	jmp    80105db7 <alltraps>

80106454 <vector53>:
.globl vector53
vector53:
  pushl $0
80106454:	6a 00                	push   $0x0
  pushl $53
80106456:	6a 35                	push   $0x35
  jmp alltraps
80106458:	e9 5a f9 ff ff       	jmp    80105db7 <alltraps>

8010645d <vector54>:
.globl vector54
vector54:
  pushl $0
8010645d:	6a 00                	push   $0x0
  pushl $54
8010645f:	6a 36                	push   $0x36
  jmp alltraps
80106461:	e9 51 f9 ff ff       	jmp    80105db7 <alltraps>

80106466 <vector55>:
.globl vector55
vector55:
  pushl $0
80106466:	6a 00                	push   $0x0
  pushl $55
80106468:	6a 37                	push   $0x37
  jmp alltraps
8010646a:	e9 48 f9 ff ff       	jmp    80105db7 <alltraps>

8010646f <vector56>:
.globl vector56
vector56:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $56
80106471:	6a 38                	push   $0x38
  jmp alltraps
80106473:	e9 3f f9 ff ff       	jmp    80105db7 <alltraps>

80106478 <vector57>:
.globl vector57
vector57:
  pushl $0
80106478:	6a 00                	push   $0x0
  pushl $57
8010647a:	6a 39                	push   $0x39
  jmp alltraps
8010647c:	e9 36 f9 ff ff       	jmp    80105db7 <alltraps>

80106481 <vector58>:
.globl vector58
vector58:
  pushl $0
80106481:	6a 00                	push   $0x0
  pushl $58
80106483:	6a 3a                	push   $0x3a
  jmp alltraps
80106485:	e9 2d f9 ff ff       	jmp    80105db7 <alltraps>

8010648a <vector59>:
.globl vector59
vector59:
  pushl $0
8010648a:	6a 00                	push   $0x0
  pushl $59
8010648c:	6a 3b                	push   $0x3b
  jmp alltraps
8010648e:	e9 24 f9 ff ff       	jmp    80105db7 <alltraps>

80106493 <vector60>:
.globl vector60
vector60:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $60
80106495:	6a 3c                	push   $0x3c
  jmp alltraps
80106497:	e9 1b f9 ff ff       	jmp    80105db7 <alltraps>

8010649c <vector61>:
.globl vector61
vector61:
  pushl $0
8010649c:	6a 00                	push   $0x0
  pushl $61
8010649e:	6a 3d                	push   $0x3d
  jmp alltraps
801064a0:	e9 12 f9 ff ff       	jmp    80105db7 <alltraps>

801064a5 <vector62>:
.globl vector62
vector62:
  pushl $0
801064a5:	6a 00                	push   $0x0
  pushl $62
801064a7:	6a 3e                	push   $0x3e
  jmp alltraps
801064a9:	e9 09 f9 ff ff       	jmp    80105db7 <alltraps>

801064ae <vector63>:
.globl vector63
vector63:
  pushl $0
801064ae:	6a 00                	push   $0x0
  pushl $63
801064b0:	6a 3f                	push   $0x3f
  jmp alltraps
801064b2:	e9 00 f9 ff ff       	jmp    80105db7 <alltraps>

801064b7 <vector64>:
.globl vector64
vector64:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $64
801064b9:	6a 40                	push   $0x40
  jmp alltraps
801064bb:	e9 f7 f8 ff ff       	jmp    80105db7 <alltraps>

801064c0 <vector65>:
.globl vector65
vector65:
  pushl $0
801064c0:	6a 00                	push   $0x0
  pushl $65
801064c2:	6a 41                	push   $0x41
  jmp alltraps
801064c4:	e9 ee f8 ff ff       	jmp    80105db7 <alltraps>

801064c9 <vector66>:
.globl vector66
vector66:
  pushl $0
801064c9:	6a 00                	push   $0x0
  pushl $66
801064cb:	6a 42                	push   $0x42
  jmp alltraps
801064cd:	e9 e5 f8 ff ff       	jmp    80105db7 <alltraps>

801064d2 <vector67>:
.globl vector67
vector67:
  pushl $0
801064d2:	6a 00                	push   $0x0
  pushl $67
801064d4:	6a 43                	push   $0x43
  jmp alltraps
801064d6:	e9 dc f8 ff ff       	jmp    80105db7 <alltraps>

801064db <vector68>:
.globl vector68
vector68:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $68
801064dd:	6a 44                	push   $0x44
  jmp alltraps
801064df:	e9 d3 f8 ff ff       	jmp    80105db7 <alltraps>

801064e4 <vector69>:
.globl vector69
vector69:
  pushl $0
801064e4:	6a 00                	push   $0x0
  pushl $69
801064e6:	6a 45                	push   $0x45
  jmp alltraps
801064e8:	e9 ca f8 ff ff       	jmp    80105db7 <alltraps>

801064ed <vector70>:
.globl vector70
vector70:
  pushl $0
801064ed:	6a 00                	push   $0x0
  pushl $70
801064ef:	6a 46                	push   $0x46
  jmp alltraps
801064f1:	e9 c1 f8 ff ff       	jmp    80105db7 <alltraps>

801064f6 <vector71>:
.globl vector71
vector71:
  pushl $0
801064f6:	6a 00                	push   $0x0
  pushl $71
801064f8:	6a 47                	push   $0x47
  jmp alltraps
801064fa:	e9 b8 f8 ff ff       	jmp    80105db7 <alltraps>

801064ff <vector72>:
.globl vector72
vector72:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $72
80106501:	6a 48                	push   $0x48
  jmp alltraps
80106503:	e9 af f8 ff ff       	jmp    80105db7 <alltraps>

80106508 <vector73>:
.globl vector73
vector73:
  pushl $0
80106508:	6a 00                	push   $0x0
  pushl $73
8010650a:	6a 49                	push   $0x49
  jmp alltraps
8010650c:	e9 a6 f8 ff ff       	jmp    80105db7 <alltraps>

80106511 <vector74>:
.globl vector74
vector74:
  pushl $0
80106511:	6a 00                	push   $0x0
  pushl $74
80106513:	6a 4a                	push   $0x4a
  jmp alltraps
80106515:	e9 9d f8 ff ff       	jmp    80105db7 <alltraps>

8010651a <vector75>:
.globl vector75
vector75:
  pushl $0
8010651a:	6a 00                	push   $0x0
  pushl $75
8010651c:	6a 4b                	push   $0x4b
  jmp alltraps
8010651e:	e9 94 f8 ff ff       	jmp    80105db7 <alltraps>

80106523 <vector76>:
.globl vector76
vector76:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $76
80106525:	6a 4c                	push   $0x4c
  jmp alltraps
80106527:	e9 8b f8 ff ff       	jmp    80105db7 <alltraps>

8010652c <vector77>:
.globl vector77
vector77:
  pushl $0
8010652c:	6a 00                	push   $0x0
  pushl $77
8010652e:	6a 4d                	push   $0x4d
  jmp alltraps
80106530:	e9 82 f8 ff ff       	jmp    80105db7 <alltraps>

80106535 <vector78>:
.globl vector78
vector78:
  pushl $0
80106535:	6a 00                	push   $0x0
  pushl $78
80106537:	6a 4e                	push   $0x4e
  jmp alltraps
80106539:	e9 79 f8 ff ff       	jmp    80105db7 <alltraps>

8010653e <vector79>:
.globl vector79
vector79:
  pushl $0
8010653e:	6a 00                	push   $0x0
  pushl $79
80106540:	6a 4f                	push   $0x4f
  jmp alltraps
80106542:	e9 70 f8 ff ff       	jmp    80105db7 <alltraps>

80106547 <vector80>:
.globl vector80
vector80:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $80
80106549:	6a 50                	push   $0x50
  jmp alltraps
8010654b:	e9 67 f8 ff ff       	jmp    80105db7 <alltraps>

80106550 <vector81>:
.globl vector81
vector81:
  pushl $0
80106550:	6a 00                	push   $0x0
  pushl $81
80106552:	6a 51                	push   $0x51
  jmp alltraps
80106554:	e9 5e f8 ff ff       	jmp    80105db7 <alltraps>

80106559 <vector82>:
.globl vector82
vector82:
  pushl $0
80106559:	6a 00                	push   $0x0
  pushl $82
8010655b:	6a 52                	push   $0x52
  jmp alltraps
8010655d:	e9 55 f8 ff ff       	jmp    80105db7 <alltraps>

80106562 <vector83>:
.globl vector83
vector83:
  pushl $0
80106562:	6a 00                	push   $0x0
  pushl $83
80106564:	6a 53                	push   $0x53
  jmp alltraps
80106566:	e9 4c f8 ff ff       	jmp    80105db7 <alltraps>

8010656b <vector84>:
.globl vector84
vector84:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $84
8010656d:	6a 54                	push   $0x54
  jmp alltraps
8010656f:	e9 43 f8 ff ff       	jmp    80105db7 <alltraps>

80106574 <vector85>:
.globl vector85
vector85:
  pushl $0
80106574:	6a 00                	push   $0x0
  pushl $85
80106576:	6a 55                	push   $0x55
  jmp alltraps
80106578:	e9 3a f8 ff ff       	jmp    80105db7 <alltraps>

8010657d <vector86>:
.globl vector86
vector86:
  pushl $0
8010657d:	6a 00                	push   $0x0
  pushl $86
8010657f:	6a 56                	push   $0x56
  jmp alltraps
80106581:	e9 31 f8 ff ff       	jmp    80105db7 <alltraps>

80106586 <vector87>:
.globl vector87
vector87:
  pushl $0
80106586:	6a 00                	push   $0x0
  pushl $87
80106588:	6a 57                	push   $0x57
  jmp alltraps
8010658a:	e9 28 f8 ff ff       	jmp    80105db7 <alltraps>

8010658f <vector88>:
.globl vector88
vector88:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $88
80106591:	6a 58                	push   $0x58
  jmp alltraps
80106593:	e9 1f f8 ff ff       	jmp    80105db7 <alltraps>

80106598 <vector89>:
.globl vector89
vector89:
  pushl $0
80106598:	6a 00                	push   $0x0
  pushl $89
8010659a:	6a 59                	push   $0x59
  jmp alltraps
8010659c:	e9 16 f8 ff ff       	jmp    80105db7 <alltraps>

801065a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801065a1:	6a 00                	push   $0x0
  pushl $90
801065a3:	6a 5a                	push   $0x5a
  jmp alltraps
801065a5:	e9 0d f8 ff ff       	jmp    80105db7 <alltraps>

801065aa <vector91>:
.globl vector91
vector91:
  pushl $0
801065aa:	6a 00                	push   $0x0
  pushl $91
801065ac:	6a 5b                	push   $0x5b
  jmp alltraps
801065ae:	e9 04 f8 ff ff       	jmp    80105db7 <alltraps>

801065b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $92
801065b5:	6a 5c                	push   $0x5c
  jmp alltraps
801065b7:	e9 fb f7 ff ff       	jmp    80105db7 <alltraps>

801065bc <vector93>:
.globl vector93
vector93:
  pushl $0
801065bc:	6a 00                	push   $0x0
  pushl $93
801065be:	6a 5d                	push   $0x5d
  jmp alltraps
801065c0:	e9 f2 f7 ff ff       	jmp    80105db7 <alltraps>

801065c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801065c5:	6a 00                	push   $0x0
  pushl $94
801065c7:	6a 5e                	push   $0x5e
  jmp alltraps
801065c9:	e9 e9 f7 ff ff       	jmp    80105db7 <alltraps>

801065ce <vector95>:
.globl vector95
vector95:
  pushl $0
801065ce:	6a 00                	push   $0x0
  pushl $95
801065d0:	6a 5f                	push   $0x5f
  jmp alltraps
801065d2:	e9 e0 f7 ff ff       	jmp    80105db7 <alltraps>

801065d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $96
801065d9:	6a 60                	push   $0x60
  jmp alltraps
801065db:	e9 d7 f7 ff ff       	jmp    80105db7 <alltraps>

801065e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801065e0:	6a 00                	push   $0x0
  pushl $97
801065e2:	6a 61                	push   $0x61
  jmp alltraps
801065e4:	e9 ce f7 ff ff       	jmp    80105db7 <alltraps>

801065e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801065e9:	6a 00                	push   $0x0
  pushl $98
801065eb:	6a 62                	push   $0x62
  jmp alltraps
801065ed:	e9 c5 f7 ff ff       	jmp    80105db7 <alltraps>

801065f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801065f2:	6a 00                	push   $0x0
  pushl $99
801065f4:	6a 63                	push   $0x63
  jmp alltraps
801065f6:	e9 bc f7 ff ff       	jmp    80105db7 <alltraps>

801065fb <vector100>:
.globl vector100
vector100:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $100
801065fd:	6a 64                	push   $0x64
  jmp alltraps
801065ff:	e9 b3 f7 ff ff       	jmp    80105db7 <alltraps>

80106604 <vector101>:
.globl vector101
vector101:
  pushl $0
80106604:	6a 00                	push   $0x0
  pushl $101
80106606:	6a 65                	push   $0x65
  jmp alltraps
80106608:	e9 aa f7 ff ff       	jmp    80105db7 <alltraps>

8010660d <vector102>:
.globl vector102
vector102:
  pushl $0
8010660d:	6a 00                	push   $0x0
  pushl $102
8010660f:	6a 66                	push   $0x66
  jmp alltraps
80106611:	e9 a1 f7 ff ff       	jmp    80105db7 <alltraps>

80106616 <vector103>:
.globl vector103
vector103:
  pushl $0
80106616:	6a 00                	push   $0x0
  pushl $103
80106618:	6a 67                	push   $0x67
  jmp alltraps
8010661a:	e9 98 f7 ff ff       	jmp    80105db7 <alltraps>

8010661f <vector104>:
.globl vector104
vector104:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $104
80106621:	6a 68                	push   $0x68
  jmp alltraps
80106623:	e9 8f f7 ff ff       	jmp    80105db7 <alltraps>

80106628 <vector105>:
.globl vector105
vector105:
  pushl $0
80106628:	6a 00                	push   $0x0
  pushl $105
8010662a:	6a 69                	push   $0x69
  jmp alltraps
8010662c:	e9 86 f7 ff ff       	jmp    80105db7 <alltraps>

80106631 <vector106>:
.globl vector106
vector106:
  pushl $0
80106631:	6a 00                	push   $0x0
  pushl $106
80106633:	6a 6a                	push   $0x6a
  jmp alltraps
80106635:	e9 7d f7 ff ff       	jmp    80105db7 <alltraps>

8010663a <vector107>:
.globl vector107
vector107:
  pushl $0
8010663a:	6a 00                	push   $0x0
  pushl $107
8010663c:	6a 6b                	push   $0x6b
  jmp alltraps
8010663e:	e9 74 f7 ff ff       	jmp    80105db7 <alltraps>

80106643 <vector108>:
.globl vector108
vector108:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $108
80106645:	6a 6c                	push   $0x6c
  jmp alltraps
80106647:	e9 6b f7 ff ff       	jmp    80105db7 <alltraps>

8010664c <vector109>:
.globl vector109
vector109:
  pushl $0
8010664c:	6a 00                	push   $0x0
  pushl $109
8010664e:	6a 6d                	push   $0x6d
  jmp alltraps
80106650:	e9 62 f7 ff ff       	jmp    80105db7 <alltraps>

80106655 <vector110>:
.globl vector110
vector110:
  pushl $0
80106655:	6a 00                	push   $0x0
  pushl $110
80106657:	6a 6e                	push   $0x6e
  jmp alltraps
80106659:	e9 59 f7 ff ff       	jmp    80105db7 <alltraps>

8010665e <vector111>:
.globl vector111
vector111:
  pushl $0
8010665e:	6a 00                	push   $0x0
  pushl $111
80106660:	6a 6f                	push   $0x6f
  jmp alltraps
80106662:	e9 50 f7 ff ff       	jmp    80105db7 <alltraps>

80106667 <vector112>:
.globl vector112
vector112:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $112
80106669:	6a 70                	push   $0x70
  jmp alltraps
8010666b:	e9 47 f7 ff ff       	jmp    80105db7 <alltraps>

80106670 <vector113>:
.globl vector113
vector113:
  pushl $0
80106670:	6a 00                	push   $0x0
  pushl $113
80106672:	6a 71                	push   $0x71
  jmp alltraps
80106674:	e9 3e f7 ff ff       	jmp    80105db7 <alltraps>

80106679 <vector114>:
.globl vector114
vector114:
  pushl $0
80106679:	6a 00                	push   $0x0
  pushl $114
8010667b:	6a 72                	push   $0x72
  jmp alltraps
8010667d:	e9 35 f7 ff ff       	jmp    80105db7 <alltraps>

80106682 <vector115>:
.globl vector115
vector115:
  pushl $0
80106682:	6a 00                	push   $0x0
  pushl $115
80106684:	6a 73                	push   $0x73
  jmp alltraps
80106686:	e9 2c f7 ff ff       	jmp    80105db7 <alltraps>

8010668b <vector116>:
.globl vector116
vector116:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $116
8010668d:	6a 74                	push   $0x74
  jmp alltraps
8010668f:	e9 23 f7 ff ff       	jmp    80105db7 <alltraps>

80106694 <vector117>:
.globl vector117
vector117:
  pushl $0
80106694:	6a 00                	push   $0x0
  pushl $117
80106696:	6a 75                	push   $0x75
  jmp alltraps
80106698:	e9 1a f7 ff ff       	jmp    80105db7 <alltraps>

8010669d <vector118>:
.globl vector118
vector118:
  pushl $0
8010669d:	6a 00                	push   $0x0
  pushl $118
8010669f:	6a 76                	push   $0x76
  jmp alltraps
801066a1:	e9 11 f7 ff ff       	jmp    80105db7 <alltraps>

801066a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801066a6:	6a 00                	push   $0x0
  pushl $119
801066a8:	6a 77                	push   $0x77
  jmp alltraps
801066aa:	e9 08 f7 ff ff       	jmp    80105db7 <alltraps>

801066af <vector120>:
.globl vector120
vector120:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $120
801066b1:	6a 78                	push   $0x78
  jmp alltraps
801066b3:	e9 ff f6 ff ff       	jmp    80105db7 <alltraps>

801066b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801066b8:	6a 00                	push   $0x0
  pushl $121
801066ba:	6a 79                	push   $0x79
  jmp alltraps
801066bc:	e9 f6 f6 ff ff       	jmp    80105db7 <alltraps>

801066c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801066c1:	6a 00                	push   $0x0
  pushl $122
801066c3:	6a 7a                	push   $0x7a
  jmp alltraps
801066c5:	e9 ed f6 ff ff       	jmp    80105db7 <alltraps>

801066ca <vector123>:
.globl vector123
vector123:
  pushl $0
801066ca:	6a 00                	push   $0x0
  pushl $123
801066cc:	6a 7b                	push   $0x7b
  jmp alltraps
801066ce:	e9 e4 f6 ff ff       	jmp    80105db7 <alltraps>

801066d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $124
801066d5:	6a 7c                	push   $0x7c
  jmp alltraps
801066d7:	e9 db f6 ff ff       	jmp    80105db7 <alltraps>

801066dc <vector125>:
.globl vector125
vector125:
  pushl $0
801066dc:	6a 00                	push   $0x0
  pushl $125
801066de:	6a 7d                	push   $0x7d
  jmp alltraps
801066e0:	e9 d2 f6 ff ff       	jmp    80105db7 <alltraps>

801066e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801066e5:	6a 00                	push   $0x0
  pushl $126
801066e7:	6a 7e                	push   $0x7e
  jmp alltraps
801066e9:	e9 c9 f6 ff ff       	jmp    80105db7 <alltraps>

801066ee <vector127>:
.globl vector127
vector127:
  pushl $0
801066ee:	6a 00                	push   $0x0
  pushl $127
801066f0:	6a 7f                	push   $0x7f
  jmp alltraps
801066f2:	e9 c0 f6 ff ff       	jmp    80105db7 <alltraps>

801066f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $128
801066f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801066fe:	e9 b4 f6 ff ff       	jmp    80105db7 <alltraps>

80106703 <vector129>:
.globl vector129
vector129:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $129
80106705:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010670a:	e9 a8 f6 ff ff       	jmp    80105db7 <alltraps>

8010670f <vector130>:
.globl vector130
vector130:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $130
80106711:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106716:	e9 9c f6 ff ff       	jmp    80105db7 <alltraps>

8010671b <vector131>:
.globl vector131
vector131:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $131
8010671d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106722:	e9 90 f6 ff ff       	jmp    80105db7 <alltraps>

80106727 <vector132>:
.globl vector132
vector132:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $132
80106729:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010672e:	e9 84 f6 ff ff       	jmp    80105db7 <alltraps>

80106733 <vector133>:
.globl vector133
vector133:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $133
80106735:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010673a:	e9 78 f6 ff ff       	jmp    80105db7 <alltraps>

8010673f <vector134>:
.globl vector134
vector134:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $134
80106741:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106746:	e9 6c f6 ff ff       	jmp    80105db7 <alltraps>

8010674b <vector135>:
.globl vector135
vector135:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $135
8010674d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106752:	e9 60 f6 ff ff       	jmp    80105db7 <alltraps>

80106757 <vector136>:
.globl vector136
vector136:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $136
80106759:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010675e:	e9 54 f6 ff ff       	jmp    80105db7 <alltraps>

80106763 <vector137>:
.globl vector137
vector137:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $137
80106765:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010676a:	e9 48 f6 ff ff       	jmp    80105db7 <alltraps>

8010676f <vector138>:
.globl vector138
vector138:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $138
80106771:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106776:	e9 3c f6 ff ff       	jmp    80105db7 <alltraps>

8010677b <vector139>:
.globl vector139
vector139:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $139
8010677d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106782:	e9 30 f6 ff ff       	jmp    80105db7 <alltraps>

80106787 <vector140>:
.globl vector140
vector140:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $140
80106789:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010678e:	e9 24 f6 ff ff       	jmp    80105db7 <alltraps>

80106793 <vector141>:
.globl vector141
vector141:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $141
80106795:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010679a:	e9 18 f6 ff ff       	jmp    80105db7 <alltraps>

8010679f <vector142>:
.globl vector142
vector142:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $142
801067a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801067a6:	e9 0c f6 ff ff       	jmp    80105db7 <alltraps>

801067ab <vector143>:
.globl vector143
vector143:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $143
801067ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801067b2:	e9 00 f6 ff ff       	jmp    80105db7 <alltraps>

801067b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $144
801067b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801067be:	e9 f4 f5 ff ff       	jmp    80105db7 <alltraps>

801067c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $145
801067c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801067ca:	e9 e8 f5 ff ff       	jmp    80105db7 <alltraps>

801067cf <vector146>:
.globl vector146
vector146:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $146
801067d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801067d6:	e9 dc f5 ff ff       	jmp    80105db7 <alltraps>

801067db <vector147>:
.globl vector147
vector147:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $147
801067dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801067e2:	e9 d0 f5 ff ff       	jmp    80105db7 <alltraps>

801067e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $148
801067e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801067ee:	e9 c4 f5 ff ff       	jmp    80105db7 <alltraps>

801067f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $149
801067f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801067fa:	e9 b8 f5 ff ff       	jmp    80105db7 <alltraps>

801067ff <vector150>:
.globl vector150
vector150:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $150
80106801:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106806:	e9 ac f5 ff ff       	jmp    80105db7 <alltraps>

8010680b <vector151>:
.globl vector151
vector151:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $151
8010680d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106812:	e9 a0 f5 ff ff       	jmp    80105db7 <alltraps>

80106817 <vector152>:
.globl vector152
vector152:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $152
80106819:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010681e:	e9 94 f5 ff ff       	jmp    80105db7 <alltraps>

80106823 <vector153>:
.globl vector153
vector153:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $153
80106825:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010682a:	e9 88 f5 ff ff       	jmp    80105db7 <alltraps>

8010682f <vector154>:
.globl vector154
vector154:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $154
80106831:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106836:	e9 7c f5 ff ff       	jmp    80105db7 <alltraps>

8010683b <vector155>:
.globl vector155
vector155:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $155
8010683d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106842:	e9 70 f5 ff ff       	jmp    80105db7 <alltraps>

80106847 <vector156>:
.globl vector156
vector156:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $156
80106849:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010684e:	e9 64 f5 ff ff       	jmp    80105db7 <alltraps>

80106853 <vector157>:
.globl vector157
vector157:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $157
80106855:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010685a:	e9 58 f5 ff ff       	jmp    80105db7 <alltraps>

8010685f <vector158>:
.globl vector158
vector158:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $158
80106861:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106866:	e9 4c f5 ff ff       	jmp    80105db7 <alltraps>

8010686b <vector159>:
.globl vector159
vector159:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $159
8010686d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106872:	e9 40 f5 ff ff       	jmp    80105db7 <alltraps>

80106877 <vector160>:
.globl vector160
vector160:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $160
80106879:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010687e:	e9 34 f5 ff ff       	jmp    80105db7 <alltraps>

80106883 <vector161>:
.globl vector161
vector161:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $161
80106885:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010688a:	e9 28 f5 ff ff       	jmp    80105db7 <alltraps>

8010688f <vector162>:
.globl vector162
vector162:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $162
80106891:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106896:	e9 1c f5 ff ff       	jmp    80105db7 <alltraps>

8010689b <vector163>:
.globl vector163
vector163:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $163
8010689d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801068a2:	e9 10 f5 ff ff       	jmp    80105db7 <alltraps>

801068a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $164
801068a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801068ae:	e9 04 f5 ff ff       	jmp    80105db7 <alltraps>

801068b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $165
801068b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801068ba:	e9 f8 f4 ff ff       	jmp    80105db7 <alltraps>

801068bf <vector166>:
.globl vector166
vector166:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $166
801068c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801068c6:	e9 ec f4 ff ff       	jmp    80105db7 <alltraps>

801068cb <vector167>:
.globl vector167
vector167:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $167
801068cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801068d2:	e9 e0 f4 ff ff       	jmp    80105db7 <alltraps>

801068d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $168
801068d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801068de:	e9 d4 f4 ff ff       	jmp    80105db7 <alltraps>

801068e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $169
801068e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801068ea:	e9 c8 f4 ff ff       	jmp    80105db7 <alltraps>

801068ef <vector170>:
.globl vector170
vector170:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $170
801068f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801068f6:	e9 bc f4 ff ff       	jmp    80105db7 <alltraps>

801068fb <vector171>:
.globl vector171
vector171:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $171
801068fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106902:	e9 b0 f4 ff ff       	jmp    80105db7 <alltraps>

80106907 <vector172>:
.globl vector172
vector172:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $172
80106909:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010690e:	e9 a4 f4 ff ff       	jmp    80105db7 <alltraps>

80106913 <vector173>:
.globl vector173
vector173:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $173
80106915:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010691a:	e9 98 f4 ff ff       	jmp    80105db7 <alltraps>

8010691f <vector174>:
.globl vector174
vector174:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $174
80106921:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106926:	e9 8c f4 ff ff       	jmp    80105db7 <alltraps>

8010692b <vector175>:
.globl vector175
vector175:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $175
8010692d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106932:	e9 80 f4 ff ff       	jmp    80105db7 <alltraps>

80106937 <vector176>:
.globl vector176
vector176:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $176
80106939:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010693e:	e9 74 f4 ff ff       	jmp    80105db7 <alltraps>

80106943 <vector177>:
.globl vector177
vector177:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $177
80106945:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010694a:	e9 68 f4 ff ff       	jmp    80105db7 <alltraps>

8010694f <vector178>:
.globl vector178
vector178:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $178
80106951:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106956:	e9 5c f4 ff ff       	jmp    80105db7 <alltraps>

8010695b <vector179>:
.globl vector179
vector179:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $179
8010695d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106962:	e9 50 f4 ff ff       	jmp    80105db7 <alltraps>

80106967 <vector180>:
.globl vector180
vector180:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $180
80106969:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010696e:	e9 44 f4 ff ff       	jmp    80105db7 <alltraps>

80106973 <vector181>:
.globl vector181
vector181:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $181
80106975:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010697a:	e9 38 f4 ff ff       	jmp    80105db7 <alltraps>

8010697f <vector182>:
.globl vector182
vector182:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $182
80106981:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106986:	e9 2c f4 ff ff       	jmp    80105db7 <alltraps>

8010698b <vector183>:
.globl vector183
vector183:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $183
8010698d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106992:	e9 20 f4 ff ff       	jmp    80105db7 <alltraps>

80106997 <vector184>:
.globl vector184
vector184:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $184
80106999:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010699e:	e9 14 f4 ff ff       	jmp    80105db7 <alltraps>

801069a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $185
801069a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801069aa:	e9 08 f4 ff ff       	jmp    80105db7 <alltraps>

801069af <vector186>:
.globl vector186
vector186:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $186
801069b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801069b6:	e9 fc f3 ff ff       	jmp    80105db7 <alltraps>

801069bb <vector187>:
.globl vector187
vector187:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $187
801069bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801069c2:	e9 f0 f3 ff ff       	jmp    80105db7 <alltraps>

801069c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $188
801069c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801069ce:	e9 e4 f3 ff ff       	jmp    80105db7 <alltraps>

801069d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $189
801069d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801069da:	e9 d8 f3 ff ff       	jmp    80105db7 <alltraps>

801069df <vector190>:
.globl vector190
vector190:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $190
801069e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801069e6:	e9 cc f3 ff ff       	jmp    80105db7 <alltraps>

801069eb <vector191>:
.globl vector191
vector191:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $191
801069ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801069f2:	e9 c0 f3 ff ff       	jmp    80105db7 <alltraps>

801069f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $192
801069f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801069fe:	e9 b4 f3 ff ff       	jmp    80105db7 <alltraps>

80106a03 <vector193>:
.globl vector193
vector193:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $193
80106a05:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106a0a:	e9 a8 f3 ff ff       	jmp    80105db7 <alltraps>

80106a0f <vector194>:
.globl vector194
vector194:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $194
80106a11:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106a16:	e9 9c f3 ff ff       	jmp    80105db7 <alltraps>

80106a1b <vector195>:
.globl vector195
vector195:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $195
80106a1d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106a22:	e9 90 f3 ff ff       	jmp    80105db7 <alltraps>

80106a27 <vector196>:
.globl vector196
vector196:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $196
80106a29:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106a2e:	e9 84 f3 ff ff       	jmp    80105db7 <alltraps>

80106a33 <vector197>:
.globl vector197
vector197:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $197
80106a35:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106a3a:	e9 78 f3 ff ff       	jmp    80105db7 <alltraps>

80106a3f <vector198>:
.globl vector198
vector198:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $198
80106a41:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106a46:	e9 6c f3 ff ff       	jmp    80105db7 <alltraps>

80106a4b <vector199>:
.globl vector199
vector199:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $199
80106a4d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106a52:	e9 60 f3 ff ff       	jmp    80105db7 <alltraps>

80106a57 <vector200>:
.globl vector200
vector200:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $200
80106a59:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106a5e:	e9 54 f3 ff ff       	jmp    80105db7 <alltraps>

80106a63 <vector201>:
.globl vector201
vector201:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $201
80106a65:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106a6a:	e9 48 f3 ff ff       	jmp    80105db7 <alltraps>

80106a6f <vector202>:
.globl vector202
vector202:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $202
80106a71:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106a76:	e9 3c f3 ff ff       	jmp    80105db7 <alltraps>

80106a7b <vector203>:
.globl vector203
vector203:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $203
80106a7d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106a82:	e9 30 f3 ff ff       	jmp    80105db7 <alltraps>

80106a87 <vector204>:
.globl vector204
vector204:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $204
80106a89:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106a8e:	e9 24 f3 ff ff       	jmp    80105db7 <alltraps>

80106a93 <vector205>:
.globl vector205
vector205:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $205
80106a95:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106a9a:	e9 18 f3 ff ff       	jmp    80105db7 <alltraps>

80106a9f <vector206>:
.globl vector206
vector206:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $206
80106aa1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106aa6:	e9 0c f3 ff ff       	jmp    80105db7 <alltraps>

80106aab <vector207>:
.globl vector207
vector207:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $207
80106aad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106ab2:	e9 00 f3 ff ff       	jmp    80105db7 <alltraps>

80106ab7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $208
80106ab9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106abe:	e9 f4 f2 ff ff       	jmp    80105db7 <alltraps>

80106ac3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $209
80106ac5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106aca:	e9 e8 f2 ff ff       	jmp    80105db7 <alltraps>

80106acf <vector210>:
.globl vector210
vector210:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $210
80106ad1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106ad6:	e9 dc f2 ff ff       	jmp    80105db7 <alltraps>

80106adb <vector211>:
.globl vector211
vector211:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $211
80106add:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106ae2:	e9 d0 f2 ff ff       	jmp    80105db7 <alltraps>

80106ae7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $212
80106ae9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106aee:	e9 c4 f2 ff ff       	jmp    80105db7 <alltraps>

80106af3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $213
80106af5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106afa:	e9 b8 f2 ff ff       	jmp    80105db7 <alltraps>

80106aff <vector214>:
.globl vector214
vector214:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $214
80106b01:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106b06:	e9 ac f2 ff ff       	jmp    80105db7 <alltraps>

80106b0b <vector215>:
.globl vector215
vector215:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $215
80106b0d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106b12:	e9 a0 f2 ff ff       	jmp    80105db7 <alltraps>

80106b17 <vector216>:
.globl vector216
vector216:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $216
80106b19:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106b1e:	e9 94 f2 ff ff       	jmp    80105db7 <alltraps>

80106b23 <vector217>:
.globl vector217
vector217:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $217
80106b25:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106b2a:	e9 88 f2 ff ff       	jmp    80105db7 <alltraps>

80106b2f <vector218>:
.globl vector218
vector218:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $218
80106b31:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106b36:	e9 7c f2 ff ff       	jmp    80105db7 <alltraps>

80106b3b <vector219>:
.globl vector219
vector219:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $219
80106b3d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106b42:	e9 70 f2 ff ff       	jmp    80105db7 <alltraps>

80106b47 <vector220>:
.globl vector220
vector220:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $220
80106b49:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106b4e:	e9 64 f2 ff ff       	jmp    80105db7 <alltraps>

80106b53 <vector221>:
.globl vector221
vector221:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $221
80106b55:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106b5a:	e9 58 f2 ff ff       	jmp    80105db7 <alltraps>

80106b5f <vector222>:
.globl vector222
vector222:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $222
80106b61:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106b66:	e9 4c f2 ff ff       	jmp    80105db7 <alltraps>

80106b6b <vector223>:
.globl vector223
vector223:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $223
80106b6d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106b72:	e9 40 f2 ff ff       	jmp    80105db7 <alltraps>

80106b77 <vector224>:
.globl vector224
vector224:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $224
80106b79:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106b7e:	e9 34 f2 ff ff       	jmp    80105db7 <alltraps>

80106b83 <vector225>:
.globl vector225
vector225:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $225
80106b85:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106b8a:	e9 28 f2 ff ff       	jmp    80105db7 <alltraps>

80106b8f <vector226>:
.globl vector226
vector226:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $226
80106b91:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106b96:	e9 1c f2 ff ff       	jmp    80105db7 <alltraps>

80106b9b <vector227>:
.globl vector227
vector227:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $227
80106b9d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106ba2:	e9 10 f2 ff ff       	jmp    80105db7 <alltraps>

80106ba7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $228
80106ba9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106bae:	e9 04 f2 ff ff       	jmp    80105db7 <alltraps>

80106bb3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $229
80106bb5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106bba:	e9 f8 f1 ff ff       	jmp    80105db7 <alltraps>

80106bbf <vector230>:
.globl vector230
vector230:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $230
80106bc1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106bc6:	e9 ec f1 ff ff       	jmp    80105db7 <alltraps>

80106bcb <vector231>:
.globl vector231
vector231:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $231
80106bcd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106bd2:	e9 e0 f1 ff ff       	jmp    80105db7 <alltraps>

80106bd7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $232
80106bd9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106bde:	e9 d4 f1 ff ff       	jmp    80105db7 <alltraps>

80106be3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $233
80106be5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106bea:	e9 c8 f1 ff ff       	jmp    80105db7 <alltraps>

80106bef <vector234>:
.globl vector234
vector234:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $234
80106bf1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106bf6:	e9 bc f1 ff ff       	jmp    80105db7 <alltraps>

80106bfb <vector235>:
.globl vector235
vector235:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $235
80106bfd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106c02:	e9 b0 f1 ff ff       	jmp    80105db7 <alltraps>

80106c07 <vector236>:
.globl vector236
vector236:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $236
80106c09:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106c0e:	e9 a4 f1 ff ff       	jmp    80105db7 <alltraps>

80106c13 <vector237>:
.globl vector237
vector237:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $237
80106c15:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106c1a:	e9 98 f1 ff ff       	jmp    80105db7 <alltraps>

80106c1f <vector238>:
.globl vector238
vector238:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $238
80106c21:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106c26:	e9 8c f1 ff ff       	jmp    80105db7 <alltraps>

80106c2b <vector239>:
.globl vector239
vector239:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $239
80106c2d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106c32:	e9 80 f1 ff ff       	jmp    80105db7 <alltraps>

80106c37 <vector240>:
.globl vector240
vector240:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $240
80106c39:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106c3e:	e9 74 f1 ff ff       	jmp    80105db7 <alltraps>

80106c43 <vector241>:
.globl vector241
vector241:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $241
80106c45:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106c4a:	e9 68 f1 ff ff       	jmp    80105db7 <alltraps>

80106c4f <vector242>:
.globl vector242
vector242:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $242
80106c51:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106c56:	e9 5c f1 ff ff       	jmp    80105db7 <alltraps>

80106c5b <vector243>:
.globl vector243
vector243:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $243
80106c5d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106c62:	e9 50 f1 ff ff       	jmp    80105db7 <alltraps>

80106c67 <vector244>:
.globl vector244
vector244:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $244
80106c69:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106c6e:	e9 44 f1 ff ff       	jmp    80105db7 <alltraps>

80106c73 <vector245>:
.globl vector245
vector245:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $245
80106c75:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106c7a:	e9 38 f1 ff ff       	jmp    80105db7 <alltraps>

80106c7f <vector246>:
.globl vector246
vector246:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $246
80106c81:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106c86:	e9 2c f1 ff ff       	jmp    80105db7 <alltraps>

80106c8b <vector247>:
.globl vector247
vector247:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $247
80106c8d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106c92:	e9 20 f1 ff ff       	jmp    80105db7 <alltraps>

80106c97 <vector248>:
.globl vector248
vector248:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $248
80106c99:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106c9e:	e9 14 f1 ff ff       	jmp    80105db7 <alltraps>

80106ca3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $249
80106ca5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106caa:	e9 08 f1 ff ff       	jmp    80105db7 <alltraps>

80106caf <vector250>:
.globl vector250
vector250:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $250
80106cb1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106cb6:	e9 fc f0 ff ff       	jmp    80105db7 <alltraps>

80106cbb <vector251>:
.globl vector251
vector251:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $251
80106cbd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106cc2:	e9 f0 f0 ff ff       	jmp    80105db7 <alltraps>

80106cc7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $252
80106cc9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106cce:	e9 e4 f0 ff ff       	jmp    80105db7 <alltraps>

80106cd3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $253
80106cd5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106cda:	e9 d8 f0 ff ff       	jmp    80105db7 <alltraps>

80106cdf <vector254>:
.globl vector254
vector254:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $254
80106ce1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ce6:	e9 cc f0 ff ff       	jmp    80105db7 <alltraps>

80106ceb <vector255>:
.globl vector255
vector255:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $255
80106ced:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106cf2:	e9 c0 f0 ff ff       	jmp    80105db7 <alltraps>
80106cf7:	66 90                	xchg   %ax,%ax
80106cf9:	66 90                	xchg   %ax,%ax
80106cfb:	66 90                	xchg   %ax,%ax
80106cfd:	66 90                	xchg   %ax,%ax
80106cff:	90                   	nop

80106d00 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106d08:	c1 ea 16             	shr    $0x16,%edx
80106d0b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106d0e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106d11:	8b 07                	mov    (%edi),%eax
80106d13:	a8 01                	test   $0x1,%al
80106d15:	74 29                	je     80106d40 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d17:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d1c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106d22:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106d25:	c1 eb 0a             	shr    $0xa,%ebx
80106d28:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80106d2e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106d31:	5b                   	pop    %ebx
80106d32:	5e                   	pop    %esi
80106d33:	5f                   	pop    %edi
80106d34:	5d                   	pop    %ebp
80106d35:	c3                   	ret    
80106d36:	8d 76 00             	lea    0x0(%esi),%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106d40:	85 c9                	test   %ecx,%ecx
80106d42:	74 2c                	je     80106d70 <walkpgdir+0x70>
80106d44:	e8 37 b7 ff ff       	call   80102480 <kalloc>
80106d49:	85 c0                	test   %eax,%eax
80106d4b:	89 c6                	mov    %eax,%esi
80106d4d:	74 21                	je     80106d70 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80106d4f:	83 ec 04             	sub    $0x4,%esp
80106d52:	68 00 10 00 00       	push   $0x1000
80106d57:	6a 00                	push   $0x0
80106d59:	50                   	push   %eax
80106d5a:	e8 f1 dc ff ff       	call   80104a50 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106d5f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106d65:	83 c4 10             	add    $0x10,%esp
80106d68:	83 c8 07             	or     $0x7,%eax
80106d6b:	89 07                	mov    %eax,(%edi)
80106d6d:	eb b3                	jmp    80106d22 <walkpgdir+0x22>
80106d6f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106d73:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106d75:	5b                   	pop    %ebx
80106d76:	5e                   	pop    %esi
80106d77:	5f                   	pop    %edi
80106d78:	5d                   	pop    %ebp
80106d79:	c3                   	ret    
80106d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d80 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	57                   	push   %edi
80106d84:	56                   	push   %esi
80106d85:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106d86:	89 d3                	mov    %edx,%ebx
80106d88:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106d8e:	83 ec 1c             	sub    $0x1c,%esp
80106d91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106d94:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106d98:	8b 7d 08             	mov    0x8(%ebp),%edi
80106d9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106da0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106da3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106da6:	29 df                	sub    %ebx,%edi
80106da8:	83 c8 01             	or     $0x1,%eax
80106dab:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106dae:	eb 15                	jmp    80106dc5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106db0:	f6 00 01             	testb  $0x1,(%eax)
80106db3:	75 45                	jne    80106dfa <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106db5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106db8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106dbb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106dbd:	74 31                	je     80106df0 <mappages+0x70>
      break;
    a += PGSIZE;
80106dbf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106dc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dc8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106dcd:	89 da                	mov    %ebx,%edx
80106dcf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106dd2:	e8 29 ff ff ff       	call   80106d00 <walkpgdir>
80106dd7:	85 c0                	test   %eax,%eax
80106dd9:	75 d5                	jne    80106db0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106ddb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80106dde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106de3:	5b                   	pop    %ebx
80106de4:	5e                   	pop    %esi
80106de5:	5f                   	pop    %edi
80106de6:	5d                   	pop    %ebp
80106de7:	c3                   	ret    
80106de8:	90                   	nop
80106de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106df0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106df3:	31 c0                	xor    %eax,%eax
}
80106df5:	5b                   	pop    %ebx
80106df6:	5e                   	pop    %esi
80106df7:	5f                   	pop    %edi
80106df8:	5d                   	pop    %ebp
80106df9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106dfa:	83 ec 0c             	sub    $0xc,%esp
80106dfd:	68 fc 7f 10 80       	push   $0x80107ffc
80106e02:	e8 69 95 ff ff       	call   80100370 <panic>
80106e07:	89 f6                	mov    %esi,%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106e16:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e1c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106e1e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e24:	83 ec 1c             	sub    $0x1c,%esp
80106e27:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106e2a:	39 d3                	cmp    %edx,%ebx
80106e2c:	73 66                	jae    80106e94 <deallocuvm.part.0+0x84>
80106e2e:	89 d6                	mov    %edx,%esi
80106e30:	eb 3d                	jmp    80106e6f <deallocuvm.part.0+0x5f>
80106e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106e38:	8b 10                	mov    (%eax),%edx
80106e3a:	f6 c2 01             	test   $0x1,%dl
80106e3d:	74 26                	je     80106e65 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106e3f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106e45:	74 58                	je     80106e9f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106e47:	83 ec 0c             	sub    $0xc,%esp
80106e4a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106e50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e53:	52                   	push   %edx
80106e54:	e8 77 b4 ff ff       	call   801022d0 <kfree>
      *pte = 0;
80106e59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e5c:	83 c4 10             	add    $0x10,%esp
80106e5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106e65:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e6b:	39 f3                	cmp    %esi,%ebx
80106e6d:	73 25                	jae    80106e94 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106e6f:	31 c9                	xor    %ecx,%ecx
80106e71:	89 da                	mov    %ebx,%edx
80106e73:	89 f8                	mov    %edi,%eax
80106e75:	e8 86 fe ff ff       	call   80106d00 <walkpgdir>
    if(!pte)
80106e7a:	85 c0                	test   %eax,%eax
80106e7c:	75 ba                	jne    80106e38 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106e7e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106e84:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106e8a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e90:	39 f3                	cmp    %esi,%ebx
80106e92:	72 db                	jb     80106e6f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106e94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e9a:	5b                   	pop    %ebx
80106e9b:	5e                   	pop    %esi
80106e9c:	5f                   	pop    %edi
80106e9d:	5d                   	pop    %ebp
80106e9e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106e9f:	83 ec 0c             	sub    $0xc,%esp
80106ea2:	68 e6 78 10 80       	push   $0x801078e6
80106ea7:	e8 c4 94 ff ff       	call   80100370 <panic>
80106eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106eb0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106eb6:	e8 05 c9 ff ff       	call   801037c0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106ebb:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
80106ec1:	31 c9                	xor    %ecx,%ecx
80106ec3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ec8:	66 89 90 58 42 11 80 	mov    %dx,-0x7feebda8(%eax)
80106ecf:	66 89 88 5a 42 11 80 	mov    %cx,-0x7feebda6(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ed6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106edb:	31 c9                	xor    %ecx,%ecx
80106edd:	66 89 90 60 42 11 80 	mov    %dx,-0x7feebda0(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ee4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ee9:	66 89 88 62 42 11 80 	mov    %cx,-0x7feebd9e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ef0:	31 c9                	xor    %ecx,%ecx
80106ef2:	66 89 90 68 42 11 80 	mov    %dx,-0x7feebd98(%eax)
80106ef9:	66 89 88 6a 42 11 80 	mov    %cx,-0x7feebd96(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f00:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106f05:	31 c9                	xor    %ecx,%ecx
80106f07:	66 89 90 70 42 11 80 	mov    %dx,-0x7feebd90(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f0e:	c6 80 5c 42 11 80 00 	movb   $0x0,-0x7feebda4(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106f15:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106f1a:	c6 80 5d 42 11 80 9a 	movb   $0x9a,-0x7feebda3(%eax)
80106f21:	c6 80 5e 42 11 80 cf 	movb   $0xcf,-0x7feebda2(%eax)
80106f28:	c6 80 5f 42 11 80 00 	movb   $0x0,-0x7feebda1(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f2f:	c6 80 64 42 11 80 00 	movb   $0x0,-0x7feebd9c(%eax)
80106f36:	c6 80 65 42 11 80 92 	movb   $0x92,-0x7feebd9b(%eax)
80106f3d:	c6 80 66 42 11 80 cf 	movb   $0xcf,-0x7feebd9a(%eax)
80106f44:	c6 80 67 42 11 80 00 	movb   $0x0,-0x7feebd99(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f4b:	c6 80 6c 42 11 80 00 	movb   $0x0,-0x7feebd94(%eax)
80106f52:	c6 80 6d 42 11 80 fa 	movb   $0xfa,-0x7feebd93(%eax)
80106f59:	c6 80 6e 42 11 80 cf 	movb   $0xcf,-0x7feebd92(%eax)
80106f60:	c6 80 6f 42 11 80 00 	movb   $0x0,-0x7feebd91(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f67:	66 89 88 72 42 11 80 	mov    %cx,-0x7feebd8e(%eax)
80106f6e:	c6 80 74 42 11 80 00 	movb   $0x0,-0x7feebd8c(%eax)
80106f75:	c6 80 75 42 11 80 f2 	movb   $0xf2,-0x7feebd8b(%eax)
80106f7c:	c6 80 76 42 11 80 cf 	movb   $0xcf,-0x7feebd8a(%eax)
80106f83:	c6 80 77 42 11 80 00 	movb   $0x0,-0x7feebd89(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106f8a:	05 50 42 11 80       	add    $0x80114250,%eax
80106f8f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106f93:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106f97:	c1 e8 10             	shr    $0x10,%eax
80106f9a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106f9e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106fa1:	0f 01 10             	lgdtl  (%eax)
}
80106fa4:	c9                   	leave  
80106fa5:	c3                   	ret    
80106fa6:	8d 76 00             	lea    0x0(%esi),%esi
80106fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fb0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fb0:	a1 24 7b 11 80       	mov    0x80117b24,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106fb5:	55                   	push   %ebp
80106fb6:	89 e5                	mov    %esp,%ebp
80106fb8:	05 00 00 00 80       	add    $0x80000000,%eax
80106fbd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106fc0:	5d                   	pop    %ebp
80106fc1:	c3                   	ret    
80106fc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fd0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	57                   	push   %edi
80106fd4:	56                   	push   %esi
80106fd5:	53                   	push   %ebx
80106fd6:	83 ec 1c             	sub    $0x1c,%esp
80106fd9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106fdc:	85 f6                	test   %esi,%esi
80106fde:	0f 84 cd 00 00 00    	je     801070b1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106fe4:	8b 46 08             	mov    0x8(%esi),%eax
80106fe7:	85 c0                	test   %eax,%eax
80106fe9:	0f 84 dc 00 00 00    	je     801070cb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106fef:	8b 7e 04             	mov    0x4(%esi),%edi
80106ff2:	85 ff                	test   %edi,%edi
80106ff4:	0f 84 c4 00 00 00    	je     801070be <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106ffa:	e8 71 d8 ff ff       	call   80104870 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106fff:	e8 3c c7 ff ff       	call   80103740 <mycpu>
80107004:	89 c3                	mov    %eax,%ebx
80107006:	e8 35 c7 ff ff       	call   80103740 <mycpu>
8010700b:	89 c7                	mov    %eax,%edi
8010700d:	e8 2e c7 ff ff       	call   80103740 <mycpu>
80107012:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107015:	83 c7 08             	add    $0x8,%edi
80107018:	e8 23 c7 ff ff       	call   80103740 <mycpu>
8010701d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107020:	83 c0 08             	add    $0x8,%eax
80107023:	ba 67 00 00 00       	mov    $0x67,%edx
80107028:	c1 e8 18             	shr    $0x18,%eax
8010702b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107032:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107039:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107040:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80107047:	83 c1 08             	add    $0x8,%ecx
8010704a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107050:	c1 e9 10             	shr    $0x10,%ecx
80107053:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107059:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010705e:	e8 dd c6 ff ff       	call   80103740 <mycpu>
80107063:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010706a:	e8 d1 c6 ff ff       	call   80103740 <mycpu>
8010706f:	b9 10 00 00 00       	mov    $0x10,%ecx
80107074:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107078:	e8 c3 c6 ff ff       	call   80103740 <mycpu>
8010707d:	8b 56 08             	mov    0x8(%esi),%edx
80107080:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80107086:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107089:	e8 b2 c6 ff ff       	call   80103740 <mycpu>
8010708e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80107092:	b8 28 00 00 00       	mov    $0x28,%eax
80107097:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010709a:	8b 46 04             	mov    0x4(%esi),%eax
8010709d:	05 00 00 00 80       	add    $0x80000000,%eax
801070a2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801070a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070a8:	5b                   	pop    %ebx
801070a9:	5e                   	pop    %esi
801070aa:	5f                   	pop    %edi
801070ab:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801070ac:	e9 ff d7 ff ff       	jmp    801048b0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
801070b1:	83 ec 0c             	sub    $0xc,%esp
801070b4:	68 02 80 10 80       	push   $0x80108002
801070b9:	e8 b2 92 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801070be:	83 ec 0c             	sub    $0xc,%esp
801070c1:	68 2d 80 10 80       	push   $0x8010802d
801070c6:	e8 a5 92 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
801070cb:	83 ec 0c             	sub    $0xc,%esp
801070ce:	68 18 80 10 80       	push   $0x80108018
801070d3:	e8 98 92 ff ff       	call   80100370 <panic>
801070d8:	90                   	nop
801070d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070e0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801070e0:	55                   	push   %ebp
801070e1:	89 e5                	mov    %esp,%ebp
801070e3:	57                   	push   %edi
801070e4:	56                   	push   %esi
801070e5:	53                   	push   %ebx
801070e6:	83 ec 1c             	sub    $0x1c,%esp
801070e9:	8b 75 10             	mov    0x10(%ebp),%esi
801070ec:	8b 45 08             	mov    0x8(%ebp),%eax
801070ef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
801070f2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801070f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801070fb:	77 49                	ja     80107146 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
801070fd:	e8 7e b3 ff ff       	call   80102480 <kalloc>
  memset(mem, 0, PGSIZE);
80107102:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107105:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107107:	68 00 10 00 00       	push   $0x1000
8010710c:	6a 00                	push   $0x0
8010710e:	50                   	push   %eax
8010710f:	e8 3c d9 ff ff       	call   80104a50 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107114:	58                   	pop    %eax
80107115:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010711b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107120:	5a                   	pop    %edx
80107121:	6a 06                	push   $0x6
80107123:	50                   	push   %eax
80107124:	31 d2                	xor    %edx,%edx
80107126:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107129:	e8 52 fc ff ff       	call   80106d80 <mappages>
  memmove(mem, init, sz);
8010712e:	89 75 10             	mov    %esi,0x10(%ebp)
80107131:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107134:	83 c4 10             	add    $0x10,%esp
80107137:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010713a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010713d:	5b                   	pop    %ebx
8010713e:	5e                   	pop    %esi
8010713f:	5f                   	pop    %edi
80107140:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107141:	e9 ba d9 ff ff       	jmp    80104b00 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80107146:	83 ec 0c             	sub    $0xc,%esp
80107149:	68 41 80 10 80       	push   $0x80108041
8010714e:	e8 1d 92 ff ff       	call   80100370 <panic>
80107153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107160 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107169:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107170:	0f 85 91 00 00 00    	jne    80107207 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107176:	8b 75 18             	mov    0x18(%ebp),%esi
80107179:	31 db                	xor    %ebx,%ebx
8010717b:	85 f6                	test   %esi,%esi
8010717d:	75 1a                	jne    80107199 <loaduvm+0x39>
8010717f:	eb 6f                	jmp    801071f0 <loaduvm+0x90>
80107181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107188:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010718e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107194:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107197:	76 57                	jbe    801071f0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107199:	8b 55 0c             	mov    0xc(%ebp),%edx
8010719c:	8b 45 08             	mov    0x8(%ebp),%eax
8010719f:	31 c9                	xor    %ecx,%ecx
801071a1:	01 da                	add    %ebx,%edx
801071a3:	e8 58 fb ff ff       	call   80106d00 <walkpgdir>
801071a8:	85 c0                	test   %eax,%eax
801071aa:	74 4e                	je     801071fa <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801071ac:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071ae:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
801071b1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801071b6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801071bb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801071c1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071c4:	01 d9                	add    %ebx,%ecx
801071c6:	05 00 00 00 80       	add    $0x80000000,%eax
801071cb:	57                   	push   %edi
801071cc:	51                   	push   %ecx
801071cd:	50                   	push   %eax
801071ce:	ff 75 10             	pushl  0x10(%ebp)
801071d1:	e8 6a a7 ff ff       	call   80101940 <readi>
801071d6:	83 c4 10             	add    $0x10,%esp
801071d9:	39 c7                	cmp    %eax,%edi
801071db:	74 ab                	je     80107188 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801071dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801071e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801071e5:	5b                   	pop    %ebx
801071e6:	5e                   	pop    %esi
801071e7:	5f                   	pop    %edi
801071e8:	5d                   	pop    %ebp
801071e9:	c3                   	ret    
801071ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801071f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801071f3:	31 c0                	xor    %eax,%eax
}
801071f5:	5b                   	pop    %ebx
801071f6:	5e                   	pop    %esi
801071f7:	5f                   	pop    %edi
801071f8:	5d                   	pop    %ebp
801071f9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801071fa:	83 ec 0c             	sub    $0xc,%esp
801071fd:	68 5b 80 10 80       	push   $0x8010805b
80107202:	e8 69 91 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80107207:	83 ec 0c             	sub    $0xc,%esp
8010720a:	68 fc 80 10 80       	push   $0x801080fc
8010720f:	e8 5c 91 ff ff       	call   80100370 <panic>
80107214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010721a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107220 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	57                   	push   %edi
80107224:	56                   	push   %esi
80107225:	53                   	push   %ebx
80107226:	83 ec 0c             	sub    $0xc,%esp
80107229:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010722c:	85 ff                	test   %edi,%edi
8010722e:	0f 88 ca 00 00 00    	js     801072fe <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80107234:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107237:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010723a:	0f 82 82 00 00 00    	jb     801072c2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107240:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107246:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010724c:	39 df                	cmp    %ebx,%edi
8010724e:	77 43                	ja     80107293 <allocuvm+0x73>
80107250:	e9 bb 00 00 00       	jmp    80107310 <allocuvm+0xf0>
80107255:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80107258:	83 ec 04             	sub    $0x4,%esp
8010725b:	68 00 10 00 00       	push   $0x1000
80107260:	6a 00                	push   $0x0
80107262:	50                   	push   %eax
80107263:	e8 e8 d7 ff ff       	call   80104a50 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107268:	58                   	pop    %eax
80107269:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010726f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107274:	5a                   	pop    %edx
80107275:	6a 06                	push   $0x6
80107277:	50                   	push   %eax
80107278:	89 da                	mov    %ebx,%edx
8010727a:	8b 45 08             	mov    0x8(%ebp),%eax
8010727d:	e8 fe fa ff ff       	call   80106d80 <mappages>
80107282:	83 c4 10             	add    $0x10,%esp
80107285:	85 c0                	test   %eax,%eax
80107287:	78 47                	js     801072d0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107289:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010728f:	39 df                	cmp    %ebx,%edi
80107291:	76 7d                	jbe    80107310 <allocuvm+0xf0>
    mem = kalloc();
80107293:	e8 e8 b1 ff ff       	call   80102480 <kalloc>
    if(mem == 0){
80107298:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
8010729a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010729c:	75 ba                	jne    80107258 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
8010729e:	83 ec 0c             	sub    $0xc,%esp
801072a1:	68 79 80 10 80       	push   $0x80108079
801072a6:	e8 b5 93 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801072ab:	83 c4 10             	add    $0x10,%esp
801072ae:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801072b1:	76 4b                	jbe    801072fe <allocuvm+0xde>
801072b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072b6:	8b 45 08             	mov    0x8(%ebp),%eax
801072b9:	89 fa                	mov    %edi,%edx
801072bb:	e8 50 fb ff ff       	call   80106e10 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
801072c0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801072c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072c5:	5b                   	pop    %ebx
801072c6:	5e                   	pop    %esi
801072c7:	5f                   	pop    %edi
801072c8:	5d                   	pop    %ebp
801072c9:	c3                   	ret    
801072ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
801072d0:	83 ec 0c             	sub    $0xc,%esp
801072d3:	68 91 80 10 80       	push   $0x80108091
801072d8:	e8 83 93 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801072dd:	83 c4 10             	add    $0x10,%esp
801072e0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801072e3:	76 0d                	jbe    801072f2 <allocuvm+0xd2>
801072e5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072e8:	8b 45 08             	mov    0x8(%ebp),%eax
801072eb:	89 fa                	mov    %edi,%edx
801072ed:	e8 1e fb ff ff       	call   80106e10 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
801072f2:	83 ec 0c             	sub    $0xc,%esp
801072f5:	56                   	push   %esi
801072f6:	e8 d5 af ff ff       	call   801022d0 <kfree>
      return 0;
801072fb:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
801072fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107301:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80107303:	5b                   	pop    %ebx
80107304:	5e                   	pop    %esi
80107305:	5f                   	pop    %edi
80107306:	5d                   	pop    %ebp
80107307:	c3                   	ret    
80107308:	90                   	nop
80107309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107310:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107313:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107315:	5b                   	pop    %ebx
80107316:	5e                   	pop    %esi
80107317:	5f                   	pop    %edi
80107318:	5d                   	pop    %ebp
80107319:	c3                   	ret    
8010731a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107320 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	8b 55 0c             	mov    0xc(%ebp),%edx
80107326:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107329:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010732c:	39 d1                	cmp    %edx,%ecx
8010732e:	73 10                	jae    80107340 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107330:	5d                   	pop    %ebp
80107331:	e9 da fa ff ff       	jmp    80106e10 <deallocuvm.part.0>
80107336:	8d 76 00             	lea    0x0(%esi),%esi
80107339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107340:	89 d0                	mov    %edx,%eax
80107342:	5d                   	pop    %ebp
80107343:	c3                   	ret    
80107344:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010734a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107350 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107350:	55                   	push   %ebp
80107351:	89 e5                	mov    %esp,%ebp
80107353:	57                   	push   %edi
80107354:	56                   	push   %esi
80107355:	53                   	push   %ebx
80107356:	83 ec 0c             	sub    $0xc,%esp
80107359:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010735c:	85 f6                	test   %esi,%esi
8010735e:	74 59                	je     801073b9 <freevm+0x69>
80107360:	31 c9                	xor    %ecx,%ecx
80107362:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107367:	89 f0                	mov    %esi,%eax
80107369:	e8 a2 fa ff ff       	call   80106e10 <deallocuvm.part.0>
8010736e:	89 f3                	mov    %esi,%ebx
80107370:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107376:	eb 0f                	jmp    80107387 <freevm+0x37>
80107378:	90                   	nop
80107379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107380:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107383:	39 fb                	cmp    %edi,%ebx
80107385:	74 23                	je     801073aa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107387:	8b 03                	mov    (%ebx),%eax
80107389:	a8 01                	test   $0x1,%al
8010738b:	74 f3                	je     80107380 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010738d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107392:	83 ec 0c             	sub    $0xc,%esp
80107395:	83 c3 04             	add    $0x4,%ebx
80107398:	05 00 00 00 80       	add    $0x80000000,%eax
8010739d:	50                   	push   %eax
8010739e:	e8 2d af ff ff       	call   801022d0 <kfree>
801073a3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801073a6:	39 fb                	cmp    %edi,%ebx
801073a8:	75 dd                	jne    80107387 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801073aa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801073ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073b0:	5b                   	pop    %ebx
801073b1:	5e                   	pop    %esi
801073b2:	5f                   	pop    %edi
801073b3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801073b4:	e9 17 af ff ff       	jmp    801022d0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801073b9:	83 ec 0c             	sub    $0xc,%esp
801073bc:	68 ad 80 10 80       	push   $0x801080ad
801073c1:	e8 aa 8f ff ff       	call   80100370 <panic>
801073c6:	8d 76 00             	lea    0x0(%esi),%esi
801073c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073d0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	56                   	push   %esi
801073d4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801073d5:	e8 a6 b0 ff ff       	call   80102480 <kalloc>
801073da:	85 c0                	test   %eax,%eax
801073dc:	74 6a                	je     80107448 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
801073de:	83 ec 04             	sub    $0x4,%esp
801073e1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073e3:	bb a0 b4 10 80       	mov    $0x8010b4a0,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
801073e8:	68 00 10 00 00       	push   $0x1000
801073ed:	6a 00                	push   $0x0
801073ef:	50                   	push   %eax
801073f0:	e8 5b d6 ff ff       	call   80104a50 <memset>
801073f5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801073f8:	8b 43 04             	mov    0x4(%ebx),%eax
801073fb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801073fe:	83 ec 08             	sub    $0x8,%esp
80107401:	8b 13                	mov    (%ebx),%edx
80107403:	ff 73 0c             	pushl  0xc(%ebx)
80107406:	50                   	push   %eax
80107407:	29 c1                	sub    %eax,%ecx
80107409:	89 f0                	mov    %esi,%eax
8010740b:	e8 70 f9 ff ff       	call   80106d80 <mappages>
80107410:	83 c4 10             	add    $0x10,%esp
80107413:	85 c0                	test   %eax,%eax
80107415:	78 19                	js     80107430 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107417:	83 c3 10             	add    $0x10,%ebx
8010741a:	81 fb e0 b4 10 80    	cmp    $0x8010b4e0,%ebx
80107420:	75 d6                	jne    801073f8 <setupkvm+0x28>
80107422:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107424:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107427:	5b                   	pop    %ebx
80107428:	5e                   	pop    %esi
80107429:	5d                   	pop    %ebp
8010742a:	c3                   	ret    
8010742b:	90                   	nop
8010742c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107430:	83 ec 0c             	sub    $0xc,%esp
80107433:	56                   	push   %esi
80107434:	e8 17 ff ff ff       	call   80107350 <freevm>
      return 0;
80107439:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010743c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010743f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107441:	5b                   	pop    %ebx
80107442:	5e                   	pop    %esi
80107443:	5d                   	pop    %ebp
80107444:	c3                   	ret    
80107445:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107448:	31 c0                	xor    %eax,%eax
8010744a:	eb d8                	jmp    80107424 <setupkvm+0x54>
8010744c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107450 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107450:	55                   	push   %ebp
80107451:	89 e5                	mov    %esp,%ebp
80107453:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107456:	e8 75 ff ff ff       	call   801073d0 <setupkvm>
8010745b:	a3 24 7b 11 80       	mov    %eax,0x80117b24
80107460:	05 00 00 00 80       	add    $0x80000000,%eax
80107465:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107468:	c9                   	leave  
80107469:	c3                   	ret    
8010746a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107470 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107470:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107471:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107473:	89 e5                	mov    %esp,%ebp
80107475:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107478:	8b 55 0c             	mov    0xc(%ebp),%edx
8010747b:	8b 45 08             	mov    0x8(%ebp),%eax
8010747e:	e8 7d f8 ff ff       	call   80106d00 <walkpgdir>
  if(pte == 0)
80107483:	85 c0                	test   %eax,%eax
80107485:	74 05                	je     8010748c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107487:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010748a:	c9                   	leave  
8010748b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010748c:	83 ec 0c             	sub    $0xc,%esp
8010748f:	68 be 80 10 80       	push   $0x801080be
80107494:	e8 d7 8e ff ff       	call   80100370 <panic>
80107499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801074a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801074a0:	55                   	push   %ebp
801074a1:	89 e5                	mov    %esp,%ebp
801074a3:	57                   	push   %edi
801074a4:	56                   	push   %esi
801074a5:	53                   	push   %ebx
801074a6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801074a9:	e8 22 ff ff ff       	call   801073d0 <setupkvm>
801074ae:	85 c0                	test   %eax,%eax
801074b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801074b3:	0f 84 c5 00 00 00    	je     8010757e <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801074b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074bc:	85 c9                	test   %ecx,%ecx
801074be:	0f 84 9c 00 00 00    	je     80107560 <copyuvm+0xc0>
801074c4:	31 ff                	xor    %edi,%edi
801074c6:	eb 4a                	jmp    80107512 <copyuvm+0x72>
801074c8:	90                   	nop
801074c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801074d0:	83 ec 04             	sub    $0x4,%esp
801074d3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801074d9:	68 00 10 00 00       	push   $0x1000
801074de:	53                   	push   %ebx
801074df:	50                   	push   %eax
801074e0:	e8 1b d6 ff ff       	call   80104b00 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801074e5:	58                   	pop    %eax
801074e6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801074ec:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074f1:	5a                   	pop    %edx
801074f2:	ff 75 e4             	pushl  -0x1c(%ebp)
801074f5:	50                   	push   %eax
801074f6:	89 fa                	mov    %edi,%edx
801074f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074fb:	e8 80 f8 ff ff       	call   80106d80 <mappages>
80107500:	83 c4 10             	add    $0x10,%esp
80107503:	85 c0                	test   %eax,%eax
80107505:	78 69                	js     80107570 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107507:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010750d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107510:	76 4e                	jbe    80107560 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107512:	8b 45 08             	mov    0x8(%ebp),%eax
80107515:	31 c9                	xor    %ecx,%ecx
80107517:	89 fa                	mov    %edi,%edx
80107519:	e8 e2 f7 ff ff       	call   80106d00 <walkpgdir>
8010751e:	85 c0                	test   %eax,%eax
80107520:	74 6d                	je     8010758f <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107522:	8b 00                	mov    (%eax),%eax
80107524:	a8 01                	test   $0x1,%al
80107526:	74 5a                	je     80107582 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107528:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010752a:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010752f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107535:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107538:	e8 43 af ff ff       	call   80102480 <kalloc>
8010753d:	85 c0                	test   %eax,%eax
8010753f:	89 c6                	mov    %eax,%esi
80107541:	75 8d                	jne    801074d0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107543:	83 ec 0c             	sub    $0xc,%esp
80107546:	ff 75 e0             	pushl  -0x20(%ebp)
80107549:	e8 02 fe ff ff       	call   80107350 <freevm>
  return 0;
8010754e:	83 c4 10             	add    $0x10,%esp
80107551:	31 c0                	xor    %eax,%eax
}
80107553:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107556:	5b                   	pop    %ebx
80107557:	5e                   	pop    %esi
80107558:	5f                   	pop    %edi
80107559:	5d                   	pop    %ebp
8010755a:	c3                   	ret    
8010755b:	90                   	nop
8010755c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107560:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107563:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107566:	5b                   	pop    %ebx
80107567:	5e                   	pop    %esi
80107568:	5f                   	pop    %edi
80107569:	5d                   	pop    %ebp
8010756a:	c3                   	ret    
8010756b:	90                   	nop
8010756c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80107570:	83 ec 0c             	sub    $0xc,%esp
80107573:	56                   	push   %esi
80107574:	e8 57 ad ff ff       	call   801022d0 <kfree>
      goto bad;
80107579:	83 c4 10             	add    $0x10,%esp
8010757c:	eb c5                	jmp    80107543 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010757e:	31 c0                	xor    %eax,%eax
80107580:	eb d1                	jmp    80107553 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107582:	83 ec 0c             	sub    $0xc,%esp
80107585:	68 e2 80 10 80       	push   $0x801080e2
8010758a:	e8 e1 8d ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010758f:	83 ec 0c             	sub    $0xc,%esp
80107592:	68 c8 80 10 80       	push   $0x801080c8
80107597:	e8 d4 8d ff ff       	call   80100370 <panic>
8010759c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801075a0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075a0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801075a1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075a3:	89 e5                	mov    %esp,%ebp
801075a5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801075a8:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ab:	8b 45 08             	mov    0x8(%ebp),%eax
801075ae:	e8 4d f7 ff ff       	call   80106d00 <walkpgdir>
  if((*pte & PTE_P) == 0)
801075b3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801075b5:	89 c2                	mov    %eax,%edx
801075b7:	83 e2 05             	and    $0x5,%edx
801075ba:	83 fa 05             	cmp    $0x5,%edx
801075bd:	75 11                	jne    801075d0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801075bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801075c4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801075c5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801075ca:	c3                   	ret    
801075cb:	90                   	nop
801075cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801075d0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801075d2:	c9                   	leave  
801075d3:	c3                   	ret    
801075d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801075e0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801075e0:	55                   	push   %ebp
801075e1:	89 e5                	mov    %esp,%ebp
801075e3:	57                   	push   %edi
801075e4:	56                   	push   %esi
801075e5:	53                   	push   %ebx
801075e6:	83 ec 1c             	sub    $0x1c,%esp
801075e9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801075ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ef:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801075f2:	85 db                	test   %ebx,%ebx
801075f4:	75 40                	jne    80107636 <copyout+0x56>
801075f6:	eb 70                	jmp    80107668 <copyout+0x88>
801075f8:	90                   	nop
801075f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107600:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107603:	89 f1                	mov    %esi,%ecx
80107605:	29 d1                	sub    %edx,%ecx
80107607:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010760d:	39 d9                	cmp    %ebx,%ecx
8010760f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107612:	29 f2                	sub    %esi,%edx
80107614:	83 ec 04             	sub    $0x4,%esp
80107617:	01 d0                	add    %edx,%eax
80107619:	51                   	push   %ecx
8010761a:	57                   	push   %edi
8010761b:	50                   	push   %eax
8010761c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010761f:	e8 dc d4 ff ff       	call   80104b00 <memmove>
    len -= n;
    buf += n;
80107624:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107627:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010762a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107630:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107632:	29 cb                	sub    %ecx,%ebx
80107634:	74 32                	je     80107668 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107636:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107638:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010763b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010763e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107644:	56                   	push   %esi
80107645:	ff 75 08             	pushl  0x8(%ebp)
80107648:	e8 53 ff ff ff       	call   801075a0 <uva2ka>
    if(pa0 == 0)
8010764d:	83 c4 10             	add    $0x10,%esp
80107650:	85 c0                	test   %eax,%eax
80107652:	75 ac                	jne    80107600 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107654:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107657:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010765c:	5b                   	pop    %ebx
8010765d:	5e                   	pop    %esi
8010765e:	5f                   	pop    %edi
8010765f:	5d                   	pop    %ebp
80107660:	c3                   	ret    
80107661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107668:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010766b:	31 c0                	xor    %eax,%eax
}
8010766d:	5b                   	pop    %ebx
8010766e:	5e                   	pop    %esi
8010766f:	5f                   	pop    %edi
80107670:	5d                   	pop    %ebp
80107671:	c3                   	ret    
