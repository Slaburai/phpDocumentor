<?php

declare(strict_types=1);

/**
 * This file is part of phpDocumentor.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * @link https://phpdoc.org
 */

namespace phpDocumentor\JsonPath\AST;

use InvalidArgumentException;
use phpDocumentor\JsonPath\Executor;

use function is_iterable;

final class FilterNode implements PathNode
{
    private Expression $expression;

    public function __construct(Expression $expression)
    {
        $this->expression = $expression;
    }

    /** @inheritDoc */
    public function visit(Executor $param, $currentObject, $root)
    {
        if (is_iterable($currentObject) === false) {
            throw new InvalidArgumentException('Can only filter iteratable values %s given');
        }

        foreach ($currentObject as $current) {
            if (!$this->expression->visit($param, $current, $root)) {
                continue;
            }

            yield $current;
        }
    }
}
